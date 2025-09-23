package no.nav.lydia.ia.sak.db

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IATjeneste
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.tilgangskontroll.fia.Rolle
import javax.sql.DataSource

private val hentIASakLeveranserSql =
    """
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

class IASakLeveranseRepository(
    val dataSource: DataSource,
) {
    fun hentIASakLeveranser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            val sql = """
                $hentIASakLeveranserSql
                where iasak_leveranse.saksnummer = :saksnummer
            """.trimMargin()
            val query = queryOf(
                statement = sql,
                paramMap = mapOf(
                    "saksnummer" to saksnummer,
                ),
            ).map(this::mapTilIASakLeveranse).asList

            session.run(query)
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
            opprettetTidspunkt = rad.localDateTimeOrNull("opprettet_tidspunkt"),
        )

    private fun mapTilIATjeneste(rad: Row) =
        IATjeneste(
            id = rad.int("iaTjenesteId"),
            navn = rad.string("iaTjenesteNavn"),
            deaktivert = rad.boolean("iaTjenesteDeaktivert"),
        )

    private fun mapTilModul(rad: Row) =
        Modul(
            id = rad.int("modulId"),
            iaTjeneste = mapTilIATjeneste(rad),
            navn = rad.string("modulNavn"),
            deaktivert = rad.boolean("modulDeaktivert"),
        )
}
