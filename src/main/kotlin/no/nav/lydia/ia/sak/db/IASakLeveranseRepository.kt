package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.Aktivitet
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.LeveranseStatus
import no.nav.lydia.ia.sak.domene.Område
import javax.sql.DataSource

class IASakLeveranseRepository (val dataSource: DataSource) {
    fun hentIASakLeveranser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            val sql = """"
                select
                    iasak_leveranse.id,
                    iasak_leveranse.saksnummer,
                    iasak_leveranse.frist,
                    iasak_leveranse.status,
                    iasak_leveranse.opprettet_av,
                    iasak_leveranse.sist_endret,
                    iasak_leveranse.sist_endret_av,
                    aktivitet.id as aktivitetsId
                    aktivitet.navn as aktivitetsNavn,
                    omraade.id as omraadeId
                    omraade.navn omraadeNavn,
                from iasak_leveranse
                join aktivitet on (iasak_leveranse.aktivitet = aktivitet.id)
                join omraade on (aktivitet.omraade = omraade.id)
                where iasak_leveranse.saksnummer = :saksnummer
                """".trimMargin()
            val query = queryOf(sql, mapOf(
                "saksnummer" to saksnummer
            )).map(this::mapTilIASakLeveranse).asList

            session.run(query)
        }

    private fun mapTilIASakLeveranse(row: Row) =
        IASakLeveranse(
            id = row.int("id"),
            saksnummer = row.string("saksnummer"),
            aktivitet = Aktivitet(
                id = row.int("aktivitetsId"),
                område = Område(
                    id = row.int("omraadeId"),
                    navn = row.string("omraadeNavn")
                ),
                navn = row.string("aktivitetsNavn")
            ),
            frist = row.localDate("frist"),
            status = LeveranseStatus.valueOf(row.string("status")),
            opprettetAv = row.string("opprettet_av"),
            sistEndret = row.localDateTime("sist_endret"),
            sistEndretAv = row.string("sist_endret_av")
        )
}