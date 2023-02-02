package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.LeveranseStatus
import no.nav.lydia.ia.sak.domene.IATjeneste
import javax.sql.DataSource

class IASakLeveranseRepository (val dataSource: DataSource) {
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
            val query = queryOf(sql, mapOf(
                "saksnummer" to saksnummer
            )).map(this::mapTilIASakLeveranse).asList

            session.run(query)
        }

    private fun mapTilIASakLeveranse(row: Row) =
        IASakLeveranse(
            id = row.int("id"),
            saksnummer = row.string("saksnummer"),
            modul = Modul(
                id = row.int("modulId"),
                iaTjeneste = IATjeneste(
                    id = row.int("iaTjenesteId"),
                    navn = row.string("iaTjenesteNavn")
                ),
                navn = row.string("modulNavn")
            ),
            frist = row.localDate("frist"),
            status = LeveranseStatus.valueOf(row.string("status")),
            opprettetAv = row.string("opprettet_av"),
            sistEndret = row.localDateTime("sist_endret"),
            sistEndretAv = row.string("sist_endret_av")
        )
}