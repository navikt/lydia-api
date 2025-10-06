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
        samarbeidId: Int,
        referanseId: UUID,
        dokumentType: DokumentPublisering.Type,
        opprettetAv: NavAnsatt,
    ): Either<Feil, DokumentPubliseringDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                action = queryOf(
                    paramMap = mapOf(
                        "samarbeidId" to samarbeidId,
                        "referanseId" to referanseId.toString(),
                        "type" to dokumentType.name,
                        "opprettetAv" to opprettetAv.navIdent,
                        "status" to DokumentPublisering.Status.OPPRETTET.name,
                    ),
                    statement =
                        """
                        INSERT INTO dokument_til_publisering (
                          ia_prosess,
                          referanse_id, 
                          type, 
                          opprettet_av, 
                          status
                        ) 
                        VALUES (
                          :samarbeidId,
                          :referanseId, 
                          :type, 
                          :opprettetAv, 
                          :status
                        )
                        ON CONFLICT (id) DO NOTHING
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

    fun hentDokument(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPublisering.Type,
    ): List<DokumentPubliseringDto> =
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
                }.asList,
            )
        }

    fun lagreKvittering(kvittering: KvitteringDto) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE dokument_til_publisering SET
                    status = :status,
                    dokument_id = :dokumentId,
                    journalpost_id = :journalpostId,
                    publisert = :publisertDato
                    WHERE referanse_id = :referanseId 
                    AND type = :type
                    """.trimIndent(),
                    mapOf(
                        "status" to DokumentPublisering.Status.PUBLISERT.name, // TODO: hva ved feilende journalføring?
                        "dokumentId" to kvittering.dokumentId,
                        "journalpostId" to kvittering.journalpostId,
                        "publisertDato" to kvittering.publisertDato.toJavaLocalDateTime(),
                        "referanseId" to kvittering.referanseId,
                        "type" to kvittering.type,
                    ),
                ).asUpdate,
            ).also {
                println(
                    mapOf(
                        "status" to DokumentPublisering.Status.PUBLISERT.name, // TODO: hva ved feilende journalføring?
                        "dokumentId" to kvittering.dokumentId,
                        "journalpostId" to kvittering.journalpostId,
                        "publisertDato" to kvittering.publisertDato.toJavaLocalDateTime(),
                        "referanse_id" to kvittering.referanseId,
                        "type" to kvittering.type,
                    ).toString(),
                )
            }
        }

    fun Row.tilDokumentDto(): DokumentPubliseringDto =
        DokumentPubliseringDto(
            dokumentId = this.stringOrNull(columnLabel = "dokument_id"),
            referanseId = this.string(columnLabel = "referanse_id"),
            opprettetAv = this.string(columnLabel = "opprettet_av"),
            status = DokumentPublisering.Status.valueOf(this.string(columnLabel = "status")),
            dokumentType = DokumentPublisering.Type.valueOf(this.string(columnLabel = "type")),
            opprettetTidspunkt = this.localDateTime(columnLabel = "opprettet").toKotlinLocalDateTime(),
            publisertTidspunkt = this.localDateTimeOrNull(columnLabel = "publisert")?.toKotlinLocalDateTime(),
            samarbeidId = this.int("ia_prosess"),
        )
}
