package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Companion.tilDokumentTilPubliseringStatus
import no.nav.lydia.ia.sak.api.spørreundersøkelse.EndreSamarbeidTilSpørreundersøkelseDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvar
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseAntallSvar
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørsmålDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SvaralternativDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaInfo
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.UndertemaDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.UndertemaInfo
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class SpørreundersøkelseRepository(
    private val dataSource: DataSource,
) {
    private val gson: Gson = GsonBuilder().create()

    fun hentAlleSvar(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                    ),
                ).map(this::mapRowToSpørreundersøkelseSvarDto).asList,
            )
        }

    fun hentEnSpørreundersøkelseUtenInnhold(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                         ia_sak_kartlegging.*,
                         dokument_til_publisering.status AS publisering_status
                    FROM ia_sak_kartlegging
                    LEFT JOIN dokument_til_publisering 
                        ON dokument_til_publisering.referanse_id = ia_sak_kartlegging.kartlegging_id
                    WHERE kartlegging_id = :sporreundersokelseId
                        AND ia_sak_kartlegging.status != :slettetStatus
                    """.trimMargin(),
                    mapOf(
                        "sporreundersokelseId" to spørreundersøkelseId,
                        "slettetStatus" to Spørreundersøkelse.Status.SLETTET.name,
                    ),
                ).map(this::mapRowToSpørreundersøkelseUtenInnhold).asSingle,
            )
        }

    fun hentSpørreundersøkelserLegacy(
        samarbeid: IASamarbeid,
        type: Spørreundersøkelse.Type = Spørreundersøkelse.Type.Behovsvurdering,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                    SELECT 
                         ia_sak_kartlegging.*,
                         dokument_til_publisering.status AS publisering_status
                    FROM ia_sak_kartlegging
                    LEFT JOIN dokument_til_publisering 
                        ON dokument_til_publisering.referanse_id = ia_sak_kartlegging.kartlegging_id
                    WHERE ia_sak_kartlegging.ia_prosess = :prosessId
                        AND ia_sak_kartlegging.status != :slettetStatus
                        AND ia_sak_kartlegging.type = :type
                """.trimMargin(),
                mapOf(
                    "prosessId" to samarbeid.id,
                    "slettetStatus" to Spørreundersøkelse.Status.SLETTET.name,
                    "type" to type.name,
                ),
            ).map(this::mapRowToSpørreundersøkelseUtenInnhold).asList,
        )
    }

    fun hentSpørreundersøkelse(spørreundersøkelseId: UUID): SpørreundersøkelseDomene? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT virksomhet.navn,
                       virksomhet.orgnr,
                       sak.saksnummer,
                       samarbeid.id                                          AS samarbeid_id,
                       sporreundersokelse.kartlegging_id                     AS sporreundersokelse_id,
                       sporreundersokelse.type                               AS type,
                       sporreundersokelse.status                             AS status,
                       sporreundersokelse.opprettet_av,
                       sporreundersokelse.opprettet,
                       sporreundersokelse.gyldig_til,
                       sporreundersokelse.endret,
                       sporreundersokelse.pabegynt,
                       sporreundersokelse.fullfort,
                       sporreundersokelse_tema.tema_id,
                       sporreundersokelse_tema.stengt                        AS tema_stengt,
                       tema.navn                                             AS tema_navn,
                       tema.status                                           AS tema_status,
                       tema.rekkefolge                                       AS tema_rekkefolge,
                       tema.sist_endret                                      AS tema_endret,
                       undertema.undertema_id,
                       undertema.navn                                        AS undertema_navn,
                       undertema.status                                      AS undertema_status,
                       undertema.rekkefolge                                  AS undertema_rekkefolge,
                       undertema.sist_endret                                 AS undertema_endret,
                       sporsmal.sporsmal_id,
                       sporsmal.sporsmal_tekst,
                       sporsmal_undertema.rekkefolge                         AS sporsmal_rekkefolge,
                       sporsmal.flervalg,
                       svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       dokument_til_publisering.status                       AS publisering_status,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = sporreundersokelse.kartlegging_id
                                                   AND us.sporsmal_id = sporsmal.sporsmal_id) < 3
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = sporreundersokelse.kartlegging_id
                                  AND svar.sporsmal_id = sporsmal.sporsmal_id
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       )                                                     AS antall_svar,
                       (SELECT COUNT(DISTINCT unike_svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar unike_svar
                        WHERE unike_svar.kartlegging_id = sporreundersokelse.kartlegging_id
                          AND unike_svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging sporreundersokelse
                         JOIN ia_prosess samarbeid
                              ON sporreundersokelse.ia_prosess = samarbeid.id
                         JOIN ia_sak sak USING (saksnummer, orgnr)
                         JOIN virksomhet USING (orgnr)
                         JOIN ia_sak_kartlegging_kartlegging_til_undertema sporreundersokelse_undertema
                              ON sporreundersokelse.kartlegging_id = sporreundersokelse_undertema.kartlegging_id
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON sporreundersokelse_undertema.undertema_id = undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                              ON undertema.undertema_id = sporsmal_undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_svaralternativer svaralternativ
                                   ON sporsmal.sporsmal_id = svaralternativ.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                                   ON sporreundersokelse_tema.kartlegging_id = sporreundersokelse.kartlegging_id
                                       AND sporreundersokelse_tema.tema_id = undertema.tema_id
                         LEFT JOIN ia_sak_kartlegging_tema tema
                                   ON tema.tema_id = sporreundersokelse_tema.tema_id
                         LEFT JOIN dokument_til_publisering
                                   ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                WHERE sporreundersokelse.kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                    ),
                ).map(this::mapRowToSpørreundersøkelseDbRad).asList,
            ).tilDomene()
        }

    private data class SpørreundersøkelseDatabaseRad(
        val virksomhetsNavn: String,
        val orgnummer: String,
        val saksnummer: String,
        val samarbeidId: Int,
        val spørreundersøkelseId: UUID,
        val type: SpørreundersøkelseDomene.Type,
        val status: SpørreundersøkelseDomene.Status,
        val opprettetAv: String,
        val opprettet: LocalDateTime,
        val gyldigTil: LocalDateTime,
        val endret: LocalDateTime?,
        val påbegynt: LocalDateTime?,
        val fullført: LocalDateTime?,
        val temaId: Int,
        val temaNavn: String,
        val temaStatus: TemaDomene.Status,
        val temaRekkefølge: Int,
        val temaStengt: Boolean,
        val temaEndret: LocalDateTime,
        val undertemaId: Int,
        val undertemaNavn: String,
        val undertemaStatus: UndertemaDomene.Status,
        val undertemaRekkefølge: Int,
        val spørsmålId: UUID,
        val spørsmålTekst: String,
        val spørsmålRekkefølge: Int,
        val flervalg: Boolean,
        val svaralternativId: UUID,
        val svaralternativTekst: String,
        val antallSvar: Int,
        val antallSvarPerSpørsmål: Int,
        val publiseringStatus: DokumentPublisering.Status,
    )

    private fun List<SpørreundersøkelseDatabaseRad>.tilDomene(): SpørreundersøkelseDomene? {
        if (this.isEmpty()) {
            return null
        }

        val spørreundersøkelse = first()
        return SpørreundersøkelseDomene(
            virksomhetsNavn = spørreundersøkelse.virksomhetsNavn,
            orgnummer = spørreundersøkelse.orgnummer,
            saksnummer = spørreundersøkelse.saksnummer,
            samarbeidId = spørreundersøkelse.samarbeidId,
            id = spørreundersøkelse.spørreundersøkelseId,
            type = spørreundersøkelse.type,
            status = spørreundersøkelse.status,
            opprettetAv = spørreundersøkelse.opprettetAv,
            opprettetTidspunkt = spørreundersøkelse.opprettet.toKotlinLocalDateTime(),
            gyldigTilTidspunkt = spørreundersøkelse.gyldigTil.toKotlinLocalDateTime(),
            endretTidspunkt = spørreundersøkelse.endret?.toKotlinLocalDateTime(),
            påbegyntTidspunkt = spørreundersøkelse.påbegynt?.toKotlinLocalDateTime(),
            fullførtTidspunkt = spørreundersøkelse.fullført?.toKotlinLocalDateTime(),
            publiseringStatus = spørreundersøkelse.publiseringStatus,
            temaer = groupBy { it.temaId }.map { (_, temaRader) ->
                val tema = temaRader.first()
                TemaDomene(
                    id = tema.temaId,
                    navn = tema.temaNavn,
                    status = tema.temaStatus,
                    rekkefølge = tema.temaRekkefølge,
                    stengtForSvar = tema.temaStengt,
                    sistEndret = tema.temaEndret.toKotlinLocalDateTime(),
                    undertemaer = temaRader.groupBy { it.undertemaId }.map { (_, undertemaRader) ->
                        val undertema = undertemaRader.first()
                        UndertemaDomene(
                            id = undertema.undertemaId,
                            navn = undertema.undertemaNavn,
                            status = undertema.undertemaStatus,
                            rekkefølge = undertema.undertemaRekkefølge,
                            spørsmål = undertemaRader.groupBy { it.spørsmålId }.map { (_, spørsmålRader) ->
                                val spørsmål = spørsmålRader.first()
                                SpørsmålDomene(
                                    id = spørsmål.spørsmålId,
                                    tekst = spørsmål.spørsmålTekst,
                                    rekkefølge = spørsmål.spørsmålRekkefølge,
                                    flervalg = spørsmål.flervalg,
                                    antallSvar = spørsmål.antallSvarPerSpørsmål,
                                    svaralternativer = spørsmålRader.groupBy { it.svaralternativId }
                                        .map { (_, svaralternativRader) ->
                                            val svaralternativ = svaralternativRader.first()
                                            SvaralternativDomene(
                                                id = svaralternativ.svaralternativId,
                                                tekst = svaralternativ.svaralternativTekst,
                                                antallSvar = svaralternativ.antallSvar,
                                            )
                                        },
                                )
                            },
                        )
                    },
                )
            },
        )
    }

    fun hentSpørreundersøkelser(
        samarbeid: IASamarbeid,
        type: SpørreundersøkelseDomene.Type,
    ): List<SpørreundersøkelseDomene> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT virksomhet.navn,
                       virksomhet.orgnr,
                       sak.saksnummer,
                       samarbeid.id                                          AS samarbeid_id,
                       sporreundersokelse.kartlegging_id                     AS sporreundersokelse_id,
                       sporreundersokelse.type                               AS type,
                       sporreundersokelse.status                             AS status,
                       sporreundersokelse.opprettet_av,
                       sporreundersokelse.opprettet,
                       sporreundersokelse.gyldig_til,
                       sporreundersokelse.endret,
                       sporreundersokelse.pabegynt,
                       sporreundersokelse.fullfort,
                       sporreundersokelse_tema.tema_id,
                       sporreundersokelse_tema.stengt                        AS tema_stengt,
                       tema.navn                                             AS tema_navn,
                       tema.status                                           AS tema_status,
                       tema.rekkefolge                                       AS tema_rekkefolge,
                       tema.sist_endret                                      AS tema_endret,
                       undertema.undertema_id,
                       undertema.navn                                        AS undertema_navn,
                       undertema.status                                      AS undertema_status,
                       undertema.rekkefolge                                  AS undertema_rekkefolge,
                       undertema.sist_endret                                 AS undertema_endret,
                       sporsmal.sporsmal_id,
                       sporsmal.sporsmal_tekst,
                       sporsmal_undertema.rekkefolge                         AS sporsmal_rekkefolge,
                       sporsmal.flervalg,
                       svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       dokument_til_publisering.status                       AS publisering_status,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = sporreundersokelse.kartlegging_id
                                                   AND us.sporsmal_id = sporsmal.sporsmal_id) < 3
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = sporreundersokelse.kartlegging_id
                                  AND svar.sporsmal_id = sporsmal.sporsmal_id
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       )                                                     AS antall_svar,
                       (SELECT COUNT(DISTINCT unike_svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar unike_svar
                        WHERE unike_svar.kartlegging_id = sporreundersokelse.kartlegging_id
                          AND unike_svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging sporreundersokelse
                         JOIN ia_prosess samarbeid
                              ON sporreundersokelse.ia_prosess = samarbeid.id
                         JOIN ia_sak sak USING (saksnummer, orgnr)
                         JOIN virksomhet USING (orgnr)
                         JOIN ia_sak_kartlegging_kartlegging_til_undertema sporreundersokelse_undertema
                              ON sporreundersokelse.kartlegging_id = sporreundersokelse_undertema.kartlegging_id
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON sporreundersokelse_undertema.undertema_id = undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                              ON undertema.undertema_id = sporsmal_undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_svaralternativer svaralternativ
                                   ON sporsmal.sporsmal_id = svaralternativ.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                                   ON sporreundersokelse_tema.kartlegging_id = sporreundersokelse.kartlegging_id
                                       AND sporreundersokelse_tema.tema_id = undertema.tema_id
                         LEFT JOIN ia_sak_kartlegging_tema tema
                                   ON tema.tema_id = sporreundersokelse_tema.tema_id
                         LEFT JOIN dokument_til_publisering
                                   ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                    WHERE samarbeid.id = :samarbeidId
                        AND sporreundersokelse.status != :slettetStatus
                        AND sporreundersokelse.type = :type
                    """.trimMargin(),
                    mapOf(
                        "samarbeidId" to samarbeid.id,
                        "slettetStatus" to SpørreundersøkelseDomene.Status.SLETTET.name,
                        "type" to type.name,
                    ),
                ).map(this::mapRowToSpørreundersøkelseDbRad).asList,
            ).tilSpørreundersøkelser()
        }

    fun hentAlleSpørreundersøkelser(): List<SpørreundersøkelseDomene> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT virksomhet.navn,
                       virksomhet.orgnr,
                       sak.saksnummer,
                       samarbeid.id                                          AS samarbeid_id,
                       sporreundersokelse.kartlegging_id                     AS sporreundersokelse_id,
                       sporreundersokelse.type                               AS type,
                       sporreundersokelse.status                             AS status,
                       sporreundersokelse.opprettet_av,
                       sporreundersokelse.opprettet,
                       sporreundersokelse.gyldig_til,
                       sporreundersokelse.endret,
                       sporreundersokelse.pabegynt,
                       sporreundersokelse.fullfort,
                       sporreundersokelse_tema.tema_id,
                       sporreundersokelse_tema.stengt                        AS tema_stengt,
                       tema.navn                                             AS tema_navn,
                       tema.status                                           AS tema_status,
                       tema.rekkefolge                                       AS tema_rekkefolge,
                       tema.sist_endret                                      AS tema_endret,
                       undertema.undertema_id,
                       undertema.navn                                        AS undertema_navn,
                       undertema.status                                      AS undertema_status,
                       undertema.rekkefolge                                  AS undertema_rekkefolge,
                       undertema.sist_endret                                 AS undertema_endret,
                       sporsmal.sporsmal_id,
                       sporsmal.sporsmal_tekst,
                       sporsmal_undertema.rekkefolge                         AS sporsmal_rekkefolge,
                       sporsmal.flervalg,
                       svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       dokument_til_publisering.status                       AS publisering_status,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = sporreundersokelse.kartlegging_id
                                                   AND us.sporsmal_id = sporsmal.sporsmal_id) < 3
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = sporreundersokelse.kartlegging_id
                                  AND svar.sporsmal_id = sporsmal.sporsmal_id
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       ) AS antall_svar,
                       (SELECT COUNT(DISTINCT unike_svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar unike_svar
                        WHERE unike_svar.kartlegging_id = sporreundersokelse.kartlegging_id
                          AND unike_svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging sporreundersokelse
                         JOIN ia_prosess samarbeid
                              ON sporreundersokelse.ia_prosess = samarbeid.id
                         JOIN ia_sak sak USING (saksnummer, orgnr)
                         JOIN virksomhet USING (orgnr)
                         JOIN ia_sak_kartlegging_kartlegging_til_undertema sporreundersokelse_undertema
                              ON sporreundersokelse.kartlegging_id = sporreundersokelse_undertema.kartlegging_id
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON sporreundersokelse_undertema.undertema_id = undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                              ON undertema.undertema_id = sporsmal_undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_svaralternativer svaralternativ
                                   ON sporsmal.sporsmal_id = svaralternativ.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                                   ON sporreundersokelse_tema.kartlegging_id = sporreundersokelse.kartlegging_id
                                       AND sporreundersokelse_tema.tema_id = undertema.tema_id
                         LEFT JOIN ia_sak_kartlegging_tema tema
                                   ON tema.tema_id = sporreundersokelse_tema.tema_id
                         LEFT JOIN dokument_til_publisering
                                   ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                    """.trimMargin(),
                ).map(this::mapRowToSpørreundersøkelseDbRad).asList,
            ).tilSpørreundersøkelser()
        }

    private fun mapRowToSpørreundersøkelseDbRad(row: Row): SpørreundersøkelseDatabaseRad = row.mapTilSpørreundersøkelseDbRad()

    private fun Row.mapTilSpørreundersøkelseDbRad(): SpørreundersøkelseDatabaseRad =
        SpørreundersøkelseDatabaseRad(
            virksomhetsNavn = this.string("navn"),
            orgnummer = this.string("orgnr"),
            saksnummer = this.string("saksnummer"),
            samarbeidId = this.int("samarbeid_id"),
            spørreundersøkelseId = UUID.fromString(this.string("sporreundersokelse_id")),
            type = SpørreundersøkelseDomene.Type.valueOf(this.string("type")),
            status = SpørreundersøkelseDomene.Status.valueOf(this.string("status")),
            opprettetAv = this.string("opprettet_av"),
            opprettet = this.localDateTime("opprettet"),
            gyldigTil = this.localDateTime("gyldig_til"),
            endret = this.localDateTimeOrNull("endret"),
            påbegynt = this.localDateTimeOrNull("pabegynt"),
            fullført = this.localDateTimeOrNull("fullfort"),
            temaId = this.int("tema_id"),
            temaNavn = this.string("tema_navn"),
            temaStatus = TemaDomene.Status.valueOf(this.string("tema_status")),
            temaRekkefølge = this.int("tema_rekkefolge"),
            temaStengt = this.boolean("tema_stengt"),
            temaEndret = this.localDateTime("tema_endret"),
            undertemaId = this.int("undertema_id"),
            undertemaNavn = this.string("undertema_navn"),
            undertemaStatus = UndertemaDomene.Status.valueOf(this.string("undertema_status")),
            undertemaRekkefølge = this.int("undertema_rekkefolge"),
            spørsmålId = UUID.fromString(this.string("sporsmal_id")),
            spørsmålTekst = this.string("sporsmal_tekst"),
            spørsmålRekkefølge = this.int("sporsmal_rekkefolge"),
            flervalg = this.boolean("flervalg"),
            svaralternativId = UUID.fromString(this.string("svaralternativ_id")),
            svaralternativTekst = this.string("svaralternativ_tekst"),
            antallSvar = this.intOrNull("antall_svar") ?: 0,
            antallSvarPerSpørsmål = this.intOrNull("antall_svar_per_sporsmal") ?: 0,
            publiseringStatus = this.stringOrNull("publisering_status").tilDokumentTilPubliseringStatus(),
        )

    private fun List<SpørreundersøkelseDatabaseRad>.tilSpørreundersøkelser(): List<SpørreundersøkelseDomene> =
        this.groupBy {
            it.spørreundersøkelseId
        }.mapNotNull { (_, spørreundersøkelseRad) ->
            spørreundersøkelseRad.tilDomene()
        }

    fun hentSpørreundersøkelseLegacy(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT ia_sak_kartlegging.*,
                         ia_sak.saksnummer,
                         virksomhet.orgnr,
                         virksomhet.navn,
                         ia_prosess.id AS prosessId
                        FROM ia_sak_kartlegging
                        JOIN ia_prosess on (ia_sak_kartlegging.ia_prosess = ia_prosess.id)
                        JOIN ia_sak using (saksnummer, orgnr)
                        JOIN virksomhet using (orgnr)
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                    ),
                ).map(this::mapRowToSpørreundersøkelse).asSingle,
            )
        }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        spørreundersøkelseId: UUID,
        prosessId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        temaer: List<TemaInfo>,
        type: SpørreundersøkelseDomene.Type,
    ): Either<Feil, SpørreundersøkelseDomene> {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                val opprettet = LocalDateTime.now()
                tx.run(
                    queryOf(
                        """
                            INSERT INTO ia_sak_kartlegging (
                                kartlegging_id,
                                orgnr,
                                ia_prosess,
                                status,
                                opprettet_av,
                                type,
                                opprettet,
                                gyldig_til
                            )
                            VALUES (
                                :kartlegging_id,
                                :orgnr,
                                :prosessId,
                                :status,
                                :opprettet_av,
                                :sporreundersokelseType,
                                :opprettet,
                                :gyldigTil
                            )
                        """.trimMargin(),
                        mapOf(
                            "kartlegging_id" to spørreundersøkelseId,
                            "orgnr" to orgnummer,
                            "prosessId" to prosessId,
                            "status" to "OPPRETTET",
                            "opprettet_av" to saksbehandler.navIdent,
                            "sporreundersokelseType" to type.name,
                            "opprettet" to opprettet,
                            "gyldigTil" to opprettet.plusHours(ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG),
                        ),
                    ).asUpdate,
                )

                temaer.sortedBy { it.rekkefølge }.forEach { tema ->
                    tx.run(
                        queryOf(
                            """
                    INSERT INTO ia_sak_kartlegging_kartlegging_til_tema (
                        kartlegging_id,
                        tema_id
                    )
                    VALUES (
                        :kartlegging_id,
                        :tema_id
                    )
                            """.trimMargin(),
                            mapOf(
                                "kartlegging_id" to spørreundersøkelseId,
                                "tema_id" to tema.id,
                            ),
                        ).asUpdate,
                    )
                }

                temaer.sortedBy { it.rekkefølge }.forEach { tema ->
                    tema.undertemaer.sortedBy { it.rekkefølge }.forEach { undertema ->
                        tx.run(
                            queryOf(
                                """
                        INSERT INTO ia_sak_kartlegging_kartlegging_til_undertema (
                            kartlegging_id,
                            tema_id, 
                            undertema_id
                        )
                        VALUES (
                            :kartlegging_id,
                            :tema_id, 
                            :undertema_id
                        )
                                """.trimMargin(),
                                mapOf(
                                    "kartlegging_id" to spørreundersøkelseId,
                                    "tema_id" to tema.id,
                                    "undertema_id" to undertema.id,
                                ),
                            ).asUpdate,
                        )
                    }
                }
            }
        }

        return hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette kartlegging",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
    }

    private fun mapRowToSpørreundersøkelseUtenInnhold(row: Row): SpørreundersøkelseUtenInnhold = row.tilSpørreundersøkelseUtenInnhold()

    private fun Row.tilSpørreundersøkelseUtenInnhold(): SpørreundersøkelseUtenInnhold {
        val spørreundersøkelseId = UUID.fromString(this.string("kartlegging_id"))
        return SpørreundersøkelseUtenInnhold(
            id = spørreundersøkelseId,
            samarbeidId = this.int("ia_prosess"),
            status = Spørreundersøkelse.Status.valueOf(this.string("status")),
            publiseringStatus = this.stringOrNull("publisering_status").tilDokumentTilPubliseringStatus(),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet"),
            endretTidspunkt = this.localDateTimeOrNull("endret"),
            påbegyntTidspunkt = this.localDateTimeOrNull("pabegynt"),
            fullførtTidspunkt = this.localDateTimeOrNull("fullfort"),
            gyldigTilTidspunkt = this.localDateTime("gyldig_til"),
        )
    }

    private fun mapRowToSpørreundersøkelse(row: Row): Spørreundersøkelse = row.tilSpørreundersøkelse()

    private fun Row.tilSpørreundersøkelse(): Spørreundersøkelse {
        val spørreundersøkelseId = UUID.fromString(this.string("kartlegging_id"))
        return Spørreundersøkelse(
            id = spørreundersøkelseId,
            saksnummer = this.string("saksnummer"),
            samarbeidId = this.int("prosessId"),
            orgnummer = this.string("orgnr"),
            virksomhetsNavn = this.string("navn"),
            status = Spørreundersøkelse.Status.valueOf(this.string("status")),
            temaer = hentTemaer(spørreundersøkelseId),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet").toKotlinLocalDateTime(),
            type = Spørreundersøkelse.Type.valueOf(this.string("type")),
            endretTidspunkt = this.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
            påbegyntTidspunkt = this.localDateTimeOrNull("pabegynt")?.toKotlinLocalDateTime(),
            fullførtTidspunkt = this.localDateTimeOrNull("fullfort")?.toKotlinLocalDateTime(),
            gyldigTilTidspunkt = this.localDateTime("gyldig_til").toKotlinLocalDateTime(),
        )
    }

    private fun hentTemaer(spørreundersøkelseId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                        ia_sak_kartlegging_kartlegging_til_tema.kartlegging_id as kartlegging_id,
                        ia_sak_kartlegging_kartlegging_til_tema.stengt as stengt,
                        ia_sak_kartlegging_kartlegging_til_tema.tema_id as tema_id,
                        ia_sak_kartlegging_tema.rekkefolge as rekkefolge,
                        ia_sak_kartlegging_tema.navn as navn,
                        ia_sak_kartlegging_tema.status as status,
                        ia_sak_kartlegging_tema.sist_endret as sist_endret,                      
                        ia_sak_kartlegging_undertema.navn as undertemanavn,
                        ia_sak_kartlegging_sporsmal.sporsmal_id as sporsmal_id,
                        ia_sak_kartlegging_sporsmal.sporsmal_tekst as sporsmal_tekst,
                        ia_sak_kartlegging_sporsmal.flervalg as flervalg,
                        ia_sak_kartlegging_svaralternativer.svaralternativ_id as svaralternativ_id,
                        ia_sak_kartlegging_svaralternativer.svaralternativ_tekst as svaralternativ_tekst
                      FROM ia_sak_kartlegging_sporsmal
                      JOIN ia_sak_kartlegging_sporsmal_til_undertema USING (sporsmal_id) 
                      JOIN ia_sak_kartlegging_svaralternativer USING (sporsmal_id)
                      JOIN ia_sak_kartlegging_undertema USING (undertema_id)
                      JOIN ia_sak_kartlegging_tema USING (tema_id)
                      JOIN ia_sak_kartlegging_kartlegging_til_tema USING (tema_id)
                      JOIN ia_sak_kartlegging_kartlegging_til_undertema USING (undertema_id) 
                    WHERE ia_sak_kartlegging_kartlegging_til_tema.kartlegging_id = :kartlegging_id
                    AND ia_sak_kartlegging_kartlegging_til_undertema.kartlegging_id = :kartlegging_id
                    ORDER BY ia_sak_kartlegging_tema.rekkefolge,
                      ia_sak_kartlegging_undertema.rekkefolge,
                      ia_sak_kartlegging_sporsmal.sporsmal_id, 
                      ia_sak_kartlegging_svaralternativer.svaralternativ_id
                    """.trimIndent(),
                    mapOf(
                        "kartlegging_id" to spørreundersøkelseId.toString(),
                    ),
                ).map {
                    SpørsmålsRad(
                        spørreundersøkelseId = UUID.fromString(it.string("kartlegging_id")),
                        tema = mapTilTema(it),
                        erTemaStengt = it.boolean("stengt"),
                        undertemanavn = it.string("undertemanavn"),
                        spørsmålId = UUID.fromString(it.string("sporsmal_id")),
                        spørsmåltekst = it.string("sporsmal_tekst"),
                        flervalg = it.boolean("flervalg"),
                        svaralternativ = mapTilSvaralternativ(it),
                    )
                }.asList,
            ).tilTemaMedSpørsmålOgSvaralternativer()
        }

    private data class SpørsmålsRad(
        val spørreundersøkelseId: UUID,
        val tema: TemaInfo,
        val erTemaStengt: Boolean,
        val undertemanavn: String,
        val spørsmålId: UUID,
        val spørsmåltekst: String,
        val flervalg: Boolean,
        val svaralternativ: Svaralternativ,
    )

    private fun List<SpørsmålsRad>.tilTemaMedSpørsmålOgSvaralternativer() =
        this.groupBy {
            it.tema
        }.map { tema ->
            val temaInfo = tema.key
            val erTemaStengt = tema.value.any { spørsmålsRad -> spørsmålsRad.erTemaStengt }
            val spørsmål = tema.value.groupBy { spørsmålsRad -> spørsmålsRad.spørsmålId }
                .map { spørsmål ->
                    val spørsmålId = spørsmål.key
                    val spørsmåltekst = spørsmål.value.first().spørsmåltekst
                    val flervalg = spørsmål.value.first().flervalg
                    val svaralternativer = spørsmål.value.map { it.svaralternativ }
                    val undertemanavn = spørsmål.value.first().undertemanavn
                    Spørsmål(
                        spørsmålId = spørsmålId,
                        undertemanavn = undertemanavn,
                        spørsmåltekst = spørsmåltekst,
                        flervalg = flervalg,
                        svaralternativer = svaralternativer,
                    )
                }
            Tema(
                tema = temaInfo,
                stengtForSvar = erTemaStengt,
                spørsmål = spørsmål,
            )
        }

    private fun mapTilSvaralternativ(row: Row) =
        Svaralternativ(
            svarId = UUID.fromString(row.string("svaralternativ_id")),
            svartekst = row.string("svaralternativ_tekst"),
        )

    fun hentAntallSvar(
        spørreundersøkelseId: UUID,
        spørsmålId: UUID,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                        SELECT COUNT(*) AS antallSvar
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                        AND sporsmal_id = :sporsmalId
                """.trimMargin(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                    "sporsmalId" to spørsmålId.toString(),
                ),
            ).map { rad ->
                SpørreundersøkelseAntallSvar(
                    spørreundersøkelseId = spørreundersøkelseId,
                    spørsmålId = spørsmålId,
                    antallSvar = rad.int("antallSvar"),
                )
            }.asSingle,
        )
    } ?: SpørreundersøkelseAntallSvar(
        spørreundersøkelseId = spørreundersøkelseId,
        spørsmålId = spørsmålId,
        antallSvar = 0,
    )

    private fun mapRowToSpørreundersøkelseSvarDto(row: Row): SpørreundersøkelseSvar = row.tilSpørreundersøkelseSvar()

    private val svarIderType = object : TypeToken<List<String>>() {}.type

    private fun Row.tilSpørreundersøkelseSvar(): SpørreundersøkelseSvar =
        SpørreundersøkelseSvar(
            spørreundersøkelseId = this.string("kartlegging_id"),
            sesjonId = this.string("sesjon_id"),
            spørsmålId = this.string("sporsmal_id"),
            svarIder = gson.fromJson(this.string("svar_ider"), svarIderType),
            opprettet = this.localDateTime("opprettet").toKotlinLocalDateTime(),
            endret = this.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
        )

    fun lagreSvar(karleggingSvarDto: SpørreundersøkelseSvarDto) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_sak_kartlegging_svar (
                            kartlegging_id,
                            sesjon_id,
                            sporsmal_id,
                            svar_ider
                        )
                        VALUES (
                            :kartleggingId,
                            :sesjonId,
                            :sporsmalId,
                            :svar_ider::jsonb
                        )
                        ON CONFLICT ON CONSTRAINT ia_sak_kartlegging_svar_kartlegging_sesjon_spm DO UPDATE SET
                            svar_ider = :svar_ider::jsonb,
                            endret = now()
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to karleggingSvarDto.spørreundersøkelseId,
                        "sesjonId" to karleggingSvarDto.sesjonId,
                        "sporsmalId" to karleggingSvarDto.spørsmålId,
                        "svar_ider" to gson.toJson(karleggingSvarDto.svarIder),
                    ),
                ).asUpdate,
            )
        }

    fun slettSpørreundersøkelse(
        spørreundersøkelseId: UUID,
        sistEndret: LocalDateTime = LocalDateTime.now(),
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                UPDATE ia_sak_kartlegging SET
                    status = '${Spørreundersøkelse.Status.SLETTET}',
                    endret = :sistEndret
                WHERE kartlegging_id = :kartleggingId
                """.trimIndent(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                    "sistEndret" to sistEndret,
                ),
            ).asUpdate,
        )
        hentSpørreundersøkelse(spørreundersøkelseId)
    }

    fun startSpørreundersøkelse(spørreundersøkelseId: UUID): SpørreundersøkelseDomene? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${Spørreundersøkelse.Status.PÅBEGYNT.name}',
                        endret = :navaerendeTidspunkt,
                        pabegynt = :navaerendeTidspunkt
                    WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "navaerendeTidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    fun avsluttSpørreundersøkelse(spørreundersøkelseId: UUID): SpørreundersøkelseDomene? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${Spørreundersøkelse.Status.AVSLUTTET.name}',
                        endret = :navaerendeTidspunkt,
                        fullfort = :navaerendeTidspunkt
                        WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "navaerendeTidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    private fun mapTilTema(row: Row): TemaInfo {
        val temaId = row.int("tema_id")
        return TemaInfo(
            id = temaId,
            rekkefølge = row.int("rekkefolge"),
            navn = row.string("navn"),
            status = TemaStatus.valueOf(row.string("status")),
            sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
            undertemaer = hentAktiveUndertemaer(temaId = temaId),
        )
    }

    fun stengTema(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging_kartlegging_til_tema
                      SET stengt = true 
                      WHERE kartlegging_id = :kartleggingId
                      AND tema_id = :temaId 
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "temaId" to temaId,
                    ),
                ).asUpdate,
            )
        }
    }

    fun hentAktiveTemaer(type: SpørreundersøkelseDomene.Type): List<TemaInfo> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_tema
                    WHERE status = :status
                    AND type = :type
                    """.trimIndent(),
                    mapOf(
                        "status" to TemaStatus.AKTIV.name,
                        "type" to type.name,
                    ),
                ).map(this::mapTilTema).asList,
            )
        }

    fun hentObligatoriskeAktiveUndertemaer(temaId: Int): List<UndertemaInfo> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_undertema
                    WHERE status = :status
                    AND obligatorisk = true
                    AND tema_id = :temaId
                    """.trimIndent(),
                    mapOf(
                        "status" to TemaStatus.AKTIV.name,
                        "temaId" to temaId,
                    ),
                ).map(this::mapTilUndertema).asList,
            )
        }

    private fun hentAktiveUndertemaer(temaId: Int): List<UndertemaInfo> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_undertema
                    WHERE status = '${TemaStatus.AKTIV}'
                    AND tema_id = '$temaId'
                    """.trimIndent(),
                ).map(this::mapTilUndertema).asList,
            )
        }

    private fun mapTilUndertema(row: Row) =
        UndertemaInfo(
            id = row.int("undertema_id"),
            navn = row.string("navn"),
            rekkefølge = row.int("rekkefolge"),
            status = TemaStatus.valueOf(row.string("status")),
        )

    fun endreSamarbeidTilSpørreundersøkelse(
        spørreundersøkelseId: UUID,
        oppdaterSpørreundersøkelseDto: EndreSamarbeidTilSpørreundersøkelseDto,
    ): Either<Feil, SpørreundersøkelseDomene> {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET 
                    ia_prosess = :samarbeidId,
                    endret = now()
                    WHERE kartlegging_id = :sporreundersokelseId
                    """.trimIndent(),
                    mapOf(
                        "samarbeidId" to oppdaterSpørreundersøkelseDto.prosessId,
                        "sporreundersokelseId" to spørreundersøkelseId.toString(),
                    ),
                ).asUpdate,
            )
        }

        return hentSpørreundersøkelse(spørreundersøkelseId)?.right()
            ?: IASakSpørreundersøkelseError.`feil under oppdatering`.left()
    }
}
