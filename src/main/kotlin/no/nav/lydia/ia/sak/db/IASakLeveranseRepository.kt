package no.nav.lydia.ia.sak.db

import arrow.core.left
import arrow.core.right
import kotlinx.datetime.toJavaLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.LeveranseStatus
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.tilgangskontroll.Rådgiver
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
                        modul.id as modulId,
                        modul.navn as modulNavn,
                        ia_tjeneste.id as iaTjenesteId,
                        ia_tjeneste.navn iaTjenesteNavn
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
                    ia_tjeneste.navn as iaTjenesteNavn
                from ia_tjeneste
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
                    modul.id as modulId,
                    modul.navn as modulNavn
                from ia_tjeneste join modul on (ia_tjeneste.id = modul.ia_tjeneste)
            """.trimIndent()

            val query = queryOf(sql).map { mapTilModul(it) }.asList
            session.run(query)
        }

    fun opprettIASakLeveranse(iaSakleveranse: IASakLeveranseOpprettelsesDto, rådgiver: Rådgiver) =
        using(sessionOf(dataSource, returnGeneratedKey = true)) { session ->
            val sql = """
                insert into iasak_leveranse (
                    saksnummer,
                    modul,
                    frist,
                    opprettet_av,
                    sist_endret_av
                ) 
                values (
                    :saksnummer,
                    :modul,
                    :frist,
                    :opprettetAv,
                    :opprettetAv
                )
            """.trimIndent()

            val iaSakLeveranseId = session.run(
                queryOf(
                    sql, mapOf(
                        "saksnummer" to iaSakleveranse.saksnummer,
                        "modul" to iaSakleveranse.modulId,
                        "frist" to iaSakleveranse.frist.toJavaLocalDate(),
                        "opprettetAv" to rådgiver.navIdent,
                    )
                ).asUpdateAndReturnGeneratedKey
            ) ?: return@using IASakError.`generell feil under uthenting`.left()

            hentIASakLeveranse(iaSakLeveranseId = iaSakLeveranseId.toInt())?.right() ?:IASakError.`generell feil under uthenting`.left()
        }

    fun hentIASakLeveranse(iaSakLeveranseId: Int) =
        using(sessionOf(dataSource)) { session ->
            val sql = """
                $hentIASakLeveranserSql
                where iasak_leveranse.id = :iaSakLeveranseId
            """.trimIndent()

            val query  = queryOf(sql, mapOf(
                "iaSakLeveranseId" to iaSakLeveranseId
            )).map { mapTilIASakLeveranse(it) }.asSingle
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

    private fun mapTilIASakLeveranse(rad: Row) =
        IASakLeveranse(
            id = rad.int("id"),
            saksnummer = rad.string("saksnummer"),
            modul = mapTilModul(rad),
            frist = rad.localDate("frist"),
            status = LeveranseStatus.valueOf(rad.string("status")),
            opprettetAv = rad.string("opprettet_av"),
            sistEndret = rad.localDateTime("sist_endret"),
            sistEndretAv = rad.string("sist_endret_av")
        )

    private fun mapTilIATjeneste(rad: Row) = IATjeneste(
        id = rad.int("iaTjenesteId"),
        navn = rad.string("iaTjenesteNavn")
    )

    private fun mapTilModul(rad: Row) = Modul(
        id = rad.int("modulId"),
        iaTjeneste = mapTilIATjeneste(rad),
        navn = rad.string("modulNavn")
    )


}
