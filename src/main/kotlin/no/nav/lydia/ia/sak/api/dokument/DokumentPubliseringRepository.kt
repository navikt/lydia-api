package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.integrasjoner.kvittering.KvitteringDto
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID
import javax.sql.DataSource

class DokumentPubliseringRepository(
    val dataSource: DataSource,
) {
    fun hentDokumentPubliseringMetadata(samarbeidId: Int): DokumentPubliseringMetadata? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT virksomhet.orgnr,
                           virksomhet.navn AS virksomhetsNavn,
                           ia_sak.saksnummer,
                           ia_prosess.id AS samarbeidId,
                           ia_prosess.navn AS samarbeidsnavn
                    FROM ia_prosess
                         JOIN ia_sak
                            ON ia_prosess.saksnummer = ia_sak.saksnummer
                         JOIN virksomhet
                            ON ia_sak.orgnr = virksomhet.orgnr
                    WHERE ia_prosess.id = :samarbeidId
                    """.trimIndent(),
                    mapOf("samarbeidId" to samarbeidId),
                ).map { row ->
                    DokumentPubliseringMetadata(
                        orgnummer = row.string("orgnr"),
                        virksomhetsNavn = row.string("virksomhetsNavn"),
                        saksnummer = row.string("saksnummer"),
                        samarbeidId = row.int("samarbeidId"),
                        samarbeidsnavn = row.string("samarbeidsnavn"),
                    )
                }.asSingle,
            )
        }

    fun opprettDokument(
        referanseId: UUID,
        dokumentType: DokumentPubliseringDto.Type,
        opprettetAv: NavAnsatt,
    ): Either<Feil, DokumentPubliseringDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                action = queryOf(
                    paramMap = mapOf(
                        "referanseId" to referanseId.toString(),
                        "type" to dokumentType.name,
                        "opprettetAv" to opprettetAv.navIdent,
                    ),
                    statement =
                        """
                        INSERT INTO dokument_til_publisering (
                          referanse_id, 
                          type, 
                          opprettet_av
                        ) 
                        VALUES (
                          :referanseId, 
                          :type, 
                          :opprettetAv 
                        )
                        RETURNING *
                        """.trimIndent(),
                ).map { row ->
                    row.tilDokumentDto()
                }.asSingle,
            )?.right()
                ?: Feil(
                    feilmelding = "Kunne ikke opprette dokument med referanseId: $referanseId " +
                        "og type: $dokumentType",
                    httpStatusCode = HttpStatusCode.InternalServerError,
                ).left()
        }

    fun hentKvitterteDokumenter(
        referanseId: UUID,
        type: DokumentPubliseringDto.Type,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                SELECT * FROM kvittert_dokument
                 WHERE referanse_id = :referanseId
                 AND type = :type
                """.trimIndent(),
                mapOf(
                    "referanseId" to referanseId.toString(),
                    "type" to type.name,
                ),
            ).map {
                KvittertDokument(
                    dokumentId = UUID.fromString(it.string("dokument_id")),
                    samarbeidId = it.int("ia_prosess"),
                    referanseId = UUID.fromString(it.string("referanse_id")),
                    type = DokumentPubliseringDto.Type.valueOf(it.string("type")),
                    status = DokumentPubliseringDto.Status.valueOf(it.string("status")),
                    publisertTidspunkt = it.localDateTimeOrNull("publisert_tidspunkt")?.toKotlinLocalDateTime(),
                    journalpostId = it.stringOrNull("journalpost_id"),
                    kvittertTidspunkt = it.localDateTime("kvittert_tidspunkt").toKotlinLocalDateTime(),
                )
            }.asList,
        )
    }

    fun hentDokumentTilPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPubliseringDto.Type,
    ): DokumentPubliseringDto? =
        using(closeable = sessionOf(dataSource)) { session ->
            session.run(
                action = queryOf(
                    statement = """
                        SELECT *
                        FROM dokument_til_publisering
                        WHERE referanse_id = :dokumentReferanseId and type = :type
                    """.trimMargin(),
                    paramMap = mapOf(
                        "dokumentReferanseId" to dokumentReferanseId.toString(),
                        "type" to dokumentType.name,
                    ),
                ).map { row ->
                    row.tilDokumentDto()
                }.asSingle,
            )
        }

    fun lagreKvittering(kvittering: KvitteringDto) =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        DELETE FROM dokument_til_publisering
                            WHERE referanse_id = :referanseId
                            AND type = :type
                        """.trimIndent(),
                        mapOf<String, String>(
                            "referanseId" to kvittering.referanseId,
                            "type" to kvittering.type,
                        ),
                    ).asUpdate,
                )
                tx.run(
                    queryOf(
                        """
                        INSERT INTO kvittert_dokument
                            (dokument_id, ia_prosess, referanse_id, type, status, publisert_tidspunkt, journalpost_id)
                        VALUES (
                            :dokumentId,
                            :samarbeidId,
                            :referanseId,
                            :type,
                            :status,
                            :publisertTidspunkt,
                            :journalpostId
                        )
                        """.trimIndent(), // TODO: håndter duplicate key
                        mapOf(
                            "dokumentId" to kvittering.dokumentId,
                            "samarbeidId" to kvittering.samarbeidId,
                            "referanseId" to kvittering.referanseId,
                            "type" to kvittering.type,
                            "status" to DokumentPubliseringDto.Status.PUBLISERT.name, // TODO: hva ved feilende journalføring?
                            "publisertTidspunkt" to kvittering.publisertDato.toJavaLocalDateTime(),
                            "journalpostId" to kvittering.journalpostId,
                        ),
                    ).asUpdate,
                )
            }
        }

    fun Row.tilDokumentDto(): DokumentPubliseringDto =
        DokumentPubliseringDto(
            referanseId = this.string(columnLabel = "referanse_id"),
            opprettetAv = this.string(columnLabel = "opprettet_av"),
            dokumentType = DokumentPubliseringDto.Type.valueOf(this.string(columnLabel = "type")),
            opprettetTidspunkt = this.localDateTime(columnLabel = "opprettet").toKotlinLocalDateTime(),
        )
}
