package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID
import javax.sql.DataSource
import kotlin.text.trimIndent
import kotlin.text.trimMargin
import kotlin.to

class DokumentPubliseringRepository(
    val dataSource: DataSource,
) {
    fun opprettDokument(
        samarbeid: IASamarbeid,
        referanseId: UUID,
        dokumentType: DokumentPublisering.Type,
        opprettetAv: NavAnsatt,
    ): Either<Feil, DokumentPubliseringDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                action = queryOf(
                    paramMap = mapOf(
                        "samarbeidId" to samarbeid.id,
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
                        ON CONFLICT (referanse_id, type) DO NOTHING
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

    fun Row.tilDokumentDto(): DokumentPubliseringDto =
        DokumentPubliseringDto(
            dokumentId = this.stringOrNull(columnLabel = "dokument_id"),
            referanseId = this.string(columnLabel = "referanse_id"),
            opprettetAv = this.string(columnLabel = "opprettet_av"),
            status = DokumentPublisering.Status.valueOf(this.string(columnLabel = "status")),
            dokumentType = DokumentPublisering.Type.valueOf(this.string(columnLabel = "type")),
            opprettetTidspunkt = this.localDateTime(columnLabel = "opprettet").toKotlinLocalDateTime(),
            publisertTidspunkt = this.localDateTimeOrNull(columnLabel = "publisert")?.toKotlinLocalDateTime(),
        )
}
