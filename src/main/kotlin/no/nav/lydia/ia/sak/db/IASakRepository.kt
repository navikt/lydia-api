package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASak
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.SpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.Svaralternativ
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle

class IASakRepository(val dataSource: DataSource) {

    fun opprettSak(iaSak: IASak): IASak =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_sak (
                        saksnummer,
                        orgnr,
                        status,
                        opprettet_av,
                        opprettet,
                        endret_av_hendelse
                    )
                    VALUES (
                        :saksnummer,
                        :orgnr,
                        :status,
                        :opprettet_av,
                        :opprettet,
                        :endret_av_hendelse
                    )
                    returning *                            
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "orgnr" to iaSak.orgnr,
                        "status" to iaSak.status.name,
                        "opprettet_av" to iaSak.opprettetAv,
                        "opprettet" to iaSak.opprettetTidspunkt,
                        "endret_av_hendelse" to iaSak.endretAvHendelseId
                    )
                ).map(this::mapRowToIASak).asSingle
            )!!
        }

    fun oppdaterSak(iaSak: IASak, sistOppdatertAvHendelseId: String?): Either<Feil, IASak> =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.validerAtSakHarRiktigEndretAvHendelse(iaSak.saksnummer, sistOppdatertAvHendelseId)
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak 
                        SET
                            status = :status,
                            endret_av = :endret_av,
                            endret = :endret,
                            eid_av = :eidAv,
                            endret_av_hendelse = :endret_av_hendelse
                        WHERE saksnummer = :saksnummer
                        RETURNING *
                    """.trimMargin(),
                        mapOf(
                            "saksnummer" to iaSak.saksnummer,
                            "status" to iaSak.status.name,
                            "endret_av" to iaSak.endretAv,
                            "endret" to iaSak.endretTidspunkt,
                            "eidAv" to iaSak.eidAv,
                            "endret_av_hendelse" to iaSak.endretAvHendelseId
                        )
                    ).map(this::mapRowToIASak).asSingle
                )?.right() ?: IASakError.`fikk ikke oppdatert sak`.left()
            }
        }

    fun slettSak(saksnummer: String, sistEndretAvHendelseId: String?) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.validerAtSakHarRiktigEndretAvHendelse(saksnummer, sistEndretAvHendelseId)
                tx.run(
                    queryOf(
                        """
                            DELETE FROM ia_sak 
                            WHERE saksnummer = :saksnummer
                        """.trimIndent(), mapOf(
                            "saksnummer" to saksnummer,
                        )
                    ).asUpdate
                )
                tx.run(
                    queryOf(
                        """
                            DELETE FROM ia_sak_hendelse 
                            WHERE saksnummer = :saksnummer
                        """.trimIndent(), mapOf(
                            "saksnummer" to saksnummer,
                        )
                    ).asUpdate
                )
            }
        }
    }

    private fun mapRowToIASak(row: Row): IASak {
        return row.tilIASak()
    }

    fun hentSaker(orgnummer: String): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    )
                ).map(this::mapRowToIASak).asList
            )
        }

    fun hentIASak(saksnummer: String): IASak? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE saksnummer = :saksnummer
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    )
                ).map(this::mapRowToIASak).asSingle
            )
        }

    fun hentAlleSaker(): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf("SELECT * FROM ia_sak").map(this::mapRowToIASak).asList
            )
        }

    fun oppdaterSistEndret(iaSak: IASak, sistEndret: LocalDateTime = LocalDateTime.now()) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    "UPDATE ia_sak SET endret = :sistEndret WHERE saksnummer = :saksnummer",
                    mapOf("sistEndret" to sistEndret, "saksnummer" to iaSak.saksnummer)
                ).asUpdate
            )
        }
    }

    fun hentUrørteSakerIVurderesUtenEier() =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak 
                     WHERE eid_av IS NULL
                     AND status = '${IAProsessStatus.VURDERES.name}'
                     AND endret < (now() - INTERVAL '6 MONTH')
                    """.trimIndent()
                ).map(this::mapRowToIASak).asList
            )
        }

    fun opprettKartlegging(
        orgnummer: String,
        kartleggingId: UUID,
        saksnummer: String,
        saksbehandler: NavAnsattMedSaksbehandlerRolle
    ): IASakKartlegging =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_sak_kartlegging (
                        kartlegging_id,
                        orgnr,
                        saksnummer,
                        status,
                        opprettet_av
                    )
                    VALUES (
                        :kartlegging_id,
                        :orgnr,
                        :saksnummer,
                        :status,
                        :opprettet_av
                    )
                    returning *                            
                """.trimMargin(),
                    mapOf(
                        "kartlegging_id" to kartleggingId,
                        "orgnr" to orgnummer,
                        "saksnummer" to saksnummer,
                        "status" to "OPPRETTET",
                        "opprettet_av" to saksbehandler.navIdent
                    )
                ).map(this::mapRowToIASakKartlegging).asSingle
            )!!
        }

    fun hentKartlegginger(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak_kartlegging
                    WHERE saksnummer = :saksnummer
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    )
                ).map(this::mapRowToIASakKartlegging).asList
            )
        }

    fun hentKartleggingEtterId(kartleggingId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                    )
                ).map(this::mapRowToIASakKartlegging).asSingle
            )
        }

    data class SpørsmålOgSvar(
        val spørsmålId: UUID,
        val spørsmåltekst: String,
        val svarId: UUID,
        val svartekst: String
    )

    fun hentSpørsmålOgSvaralternativer(): List<SpørsmålOgSvaralternativer> {
        return using(sessionOf(dataSource)) { session ->
            val results = session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_sporsmal
                        JOIN ia_sak_kartlegging_svaralternativer USING (sporsmal_id)
                    """.trimMargin()
                ).map { row ->
                    SpørsmålOgSvar(
                        spørsmålId = UUID.fromString(row.string("sporsmal_id")),
                        spørsmåltekst = row.string("sporsmal_tekst"),
                        svarId = UUID.fromString(row.string("svaralternativ_id")),
                        svartekst = row.string("svaralternativ_tekst")
                    )
                }.asList
            )

            results.groupBy { it.spørsmålId }
                .map { spørsmål ->
                    SpørsmålOgSvaralternativer(
                        spørsmålId = spørsmål.key,
                        kategori = "Partssamarbeid",
                        spørsmåltekst = spørsmål.value.first().spørsmåltekst,
                        svaralternativer = spørsmål.value.map {
                            Svaralternativ(
                                svarId = it.svarId,
                                svartekst = it.svartekst
                            )
                        }
                    )
                }
        }
    }

    private fun mapRowToIASakKartlegging(row: Row): IASakKartlegging {
        return row.tilIASakKartlegging()
    }

    fun Row.tilIASakKartlegging(): IASakKartlegging =
        IASakKartlegging(
            kartleggingId = UUID.fromString(this.string("kartlegging_id")),
            saksnummer = this.string("saksnummer"),
            status = this.string("status"),
            spørsmålOgSvaralternativer = listOf()
        )

    fun lagreKartleggingOgSpørsmålRelasjon(kartleggingId: UUID, sporsmalId: UUID) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_sak_kartlegging_sporsmal_til_kartlegging (
                        kartlegging_id,
                        sporsmal_id
                    )
                    VALUES (
                        :kartleggingId,
                        :sporsmalId
                    )
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                        "sporsmalId" to sporsmalId,
                    )
                ).asUpdate
            )
        }
    }

    companion object {
        fun TransactionalSession.validerAtSakHarRiktigEndretAvHendelse(
            saksnummer: String,
            sistEndretAvHendelseId: String?
        ) {
            sistEndretAvHendelseId?.let {
                run(
                    queryOf(
                        """
                        SELECT saksnummer FROM ia_sak WHERE saksnummer = :saksnummer AND endret_av_hendelse = :endret_av_hendelse
                    """.trimIndent(),
                        mapOf(
                            "saksnummer" to saksnummer,
                            "endret_av_hendelse" to sistEndretAvHendelseId
                        )
                    ).map { it.string("saksnummer") }.asSingle
                ) ?: throw RuntimeException(
                    "Sak har blitt oppdatert underveis! " +
                            "Sak med saksnummer: $saksnummer " +
                            "har ikke endret_av_hendelse = $sistEndretAvHendelseId som forventet."
                )
            }
        }
    }
}
