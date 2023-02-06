package no.nav.lydia.ia.sak.db

import kotlinx.datetime.toJavaLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.LeveranseStatus
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.tilgangskontroll.Rådgiver
import javax.sql.DataSource

class IASakLeveranseRepository(val dataSource: DataSource) {
    fun hentIASakLeveranser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            val sql = """
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
                where iasak_leveranse.saksnummer = :saksnummer
            """.trimMargin()
            val query = queryOf(
                sql, mapOf(
                    "saksnummer" to saksnummer
                )
            ).map(this::mapTilIASakLeveranse).asList

            session.run(query)
        }

    fun hentTjenster() =
        using(sessionOf(dataSource)) { session ->
        val sql = """
                select 
                    ia_tjeneste.id as iaTjenesteId,
                    ia_tjeneste.navn as iaTjenesteNavn
                from ia_tjeneste
            """.trimIndent()

        val query = queryOf(sql).map { mapTilTjeneste(it) }.asList
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

    fun opprettLeveranse(leveranse: IASakLeveranseOpprettelsesDto, rådgiver: Rådgiver) =
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

            val id = session.run(
                queryOf(
                    sql, mapOf(
                        "saksnummer" to leveranse.saksnummer,
                        "modul" to leveranse.modulId,
                        "frist" to leveranse.frist.toJavaLocalDate(),
                        "opprettetAv" to rådgiver.navIdent,
                    )
                ).asUpdateAndReturnGeneratedKey
            )

            hentIASakLeveranser(saksnummer = leveranse.saksnummer).firstOrNull {
                it.id.toLong() == id
            }
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

    private fun mapTilTjeneste(rad: Row) = IATjeneste(
        id = rad.int("iaTjenesteId"),
        navn = rad.string("iaTjenesteNavn")
    )

    private fun mapTilModul(rad: Row) = Modul(
        id = rad.int("modulId"),
        iaTjeneste = mapTilTjeneste(rad),
        navn = rad.string("modulNavn")
    )


}
