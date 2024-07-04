package no.nav.lydia.ia.sak.db

import arrow.core.left
import arrow.core.right
import kotlinx.datetime.toJavaLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus.LEVERT
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.Rolle
import java.time.LocalDateTime
import javax.sql.DataSource

private val hentIASakLeveranserSql = """
                    select
                        iasak_leveranse.id,
                        iasak_leveranse.saksnummer,
                        iasak_leveranse.frist,
                        iasak_leveranse.status,
                        iasak_leveranse.opprettet_av,
                        iasak_leveranse.sist_endret,
                        iasak_leveranse.sist_endret_av,
                        iasak_leveranse.sist_endret_av_rolle,
                        iasak_leveranse.fullfort,
                        iasak_leveranse.opprettet_tidspunkt,
                        modul.id as modulId,
                        modul.navn as modulNavn,
                        modul.deaktivert as modulDeaktivert,
                        ia_tjeneste.id as iaTjenesteId,
                        ia_tjeneste.navn iaTjenesteNavn,
                        ia_tjeneste.deaktivert as iaTjenesteDeaktivert
                    from iasak_leveranse
                    join modul on (iasak_leveranse.modul = modul.id)
                    join ia_tjeneste on (modul.ia_tjeneste = ia_tjeneste.id)
""".trimIndent()

class IASakLeveranseRepository(val dataSource: DataSource) {
    fun hentIASakLeveranser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            val sql = """
                $hentIASakLeveranserSql
                where iasak_leveranse.saksnummer = :saksnummer
            """.trimMargin()
            val query = queryOf(
                sql, mapOf(
                    "saksnummer" to saksnummer
                )
            ).map(this::mapTilIASakLeveranse).asList

            session.run(query)
        }

    fun hentIATjenster() =
        using(sessionOf(dataSource)) { session ->
            val sql = """
                select 
                    ia_tjeneste.id as iaTjenesteId,
                    ia_tjeneste.navn as iaTjenesteNavn,
                    ia_tjeneste.deaktivert as iaTjenesteDeaktivert
                from ia_tjeneste
                where deaktivert = false
            """.trimIndent()

            val query = queryOf(sql).map { mapTilIATjeneste(it) }.asList
            session.run(query)
        }

    fun hentModuler() =
        using(sessionOf(dataSource)) { session ->
            val sql = """
                select 
                    ia_tjeneste.id as iaTjenesteId,
                    ia_tjeneste.navn as iaTjenesteNavn,
                    ia_tjeneste.deaktivert as iaTjenesteDeaktivert,
                    modul.id as modulId,
                    modul.navn as modulNavn,
                    modul.deaktivert as modulDeaktivert
                from ia_tjeneste join modul on (ia_tjeneste.id = modul.ia_tjeneste)
                where 
                    modul.deaktivert = false AND
                    ia_tjeneste.deaktivert = false
            """.trimIndent()

            val query = queryOf(sql).map { mapTilModul(it) }.asList
            session.run(query)
        }

    fun opprettIASakLeveranse(
        iaSakleveranse: IASakLeveranseOpprettelsesDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle
    ) =
        using(sessionOf(dataSource, returnGeneratedKey = true)) { session ->
            val sql = """
                insert into iasak_leveranse (
                    saksnummer,
                    modul,
                    frist,
                    opprettet_av,
                    sist_endret_av,
                    sist_endret_av_rolle,
                    opprettet_tidspunkt
                ) 
                values (
                    :saksnummer,
                    :modul,
                    :frist,
                    :opprettetAv,
                    :opprettetAv,
                    :opprettetAvRolle,
                    now()
                )
            """.trimIndent()

            val iaSakLeveranseId = session.run(
                queryOf(
                    sql, mapOf(
                        "saksnummer" to iaSakleveranse.saksnummer,
                        "modul" to iaSakleveranse.modulId,
                        "frist" to iaSakleveranse.frist.toJavaLocalDate(),
                        "opprettetAv" to saksbehandler.navIdent,
                        "opprettetAvRolle" to saksbehandler.rolle.name,
                    )
                ).asUpdateAndReturnGeneratedKey
            ) ?: return@using IASakError.`generell feil under uthenting`.left()

            hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId.toInt())?.right()
                ?: IASakError.`generell feil under uthenting`.left()
        }

    fun hentIASakLeveranse(iaSakLeveranseId: Int) =
        using(sessionOf(dataSource)) { session ->
            val sql = """
                $hentIASakLeveranserSql
                where iasak_leveranse.id = :iaSakLeveranseId
            """.trimIndent()

            val query = queryOf(
                sql, mapOf(
                    "iaSakLeveranseId" to iaSakLeveranseId
                )
            ).map { mapTilIASakLeveranse(it) }.asSingle
            session.run(query)
        }

    fun slettIASakLeveranse(iaSakLeveranseId: Int) =
        using(sessionOf(dataSource = dataSource)) { session ->
            val query = queryOf(
                "delete from iasak_leveranse where id = :iaSakLeveranseId",
                mapOf(
                    "iaSakLeveranseId" to iaSakLeveranseId
                )
            ).asUpdate

            session.run(query)
        }

    fun oppdaterIASakLeveranse(
        iaSakLeveranseId: Int,
        oppdateringsDto: IASakLeveranseOppdateringsDto,
        saksbehandler: NavAnsattMedSaksbehandlerRolle,
    ) = using(sessionOf(dataSource = dataSource)) { session ->
        val fullførtDato = when (oppdateringsDto.status) {
            LEVERT -> LocalDateTime.now()
            else -> null
        }
        val query = queryOf(
            """
                update iasak_leveranse set 
                    status = :status,
                    fullfort = :fullfort,
                    sist_endret = :sistEndret,
                    sist_endret_av = :sistEndretAv,
                    sist_endret_av_rolle = :sistEndretAvRolle
                where id = :iaSakLeveranseId
            """.trimIndent(),
            mapOf(
                "iaSakLeveranseId" to iaSakLeveranseId,
                "status" to oppdateringsDto.status.name,
                "fullfort" to fullførtDato,
                "sistEndret" to LocalDateTime.now(),
                "sistEndretAv" to saksbehandler.navIdent,
                "sistEndretAvRolle" to saksbehandler.rolle.name,
            )
        ).asUpdate
        session.run(query)

        hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId)?.right() ?: IASakError.`ugyldig iaSakLeveranseId`.left()
    }

    fun hentAlleIASakLeveranser() = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(hentIASakLeveranserSql)
                .map(this::mapTilIASakLeveranse).asList
        )
    }

    private fun mapTilIASakLeveranse(rad: Row) =
        IASakLeveranse(
            id = rad.int("id"),
            saksnummer = rad.string("saksnummer"),
            modul = mapTilModul(rad),
            frist = rad.localDate("frist"),
            status = IASakLeveranseStatus.valueOf(rad.string("status")),
            opprettetAv = rad.string("opprettet_av"),
            sistEndret = rad.localDateTime("sist_endret"),
            sistEndretAv = rad.string("sist_endret_av"),
            sistEndretAvRolle = rad.stringOrNull("sist_endret_av_rolle")?.let { Rolle.valueOf(it) },
            fullført = rad.localDateTimeOrNull("fullfort"),
            opprettetTidspunkt = rad.localDateTimeOrNull("opprettet_tidspunkt")
        )

    private fun mapTilIATjeneste(rad: Row) = IATjeneste(
        id = rad.int("iaTjenesteId"),
        navn = rad.string("iaTjenesteNavn"),
        deaktivert = rad.boolean("iaTjenesteDeaktivert"),
    )

    private fun mapTilModul(rad: Row) = Modul(
        id = rad.int("modulId"),
        iaTjeneste = mapTilIATjeneste(rad),
        navn = rad.string("modulNavn"),
        deaktivert = rad.boolean("modulDeaktivert"),
    )


}
