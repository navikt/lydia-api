package no.nav.lydia.statusoverikt

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåBransjeOgNæring
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåEiere
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåKommuner
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.filtrerPåSektor
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.joinTilNæringEllerBransje
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import javax.sql.DataSource

class StatusoversiktRepository(val dataSource: DataSource) {

    fun hentStatusoversikt(
        søkeparametere: Søkeparametere,
    ) = using(sessionOf(dataSource)) { session ->
        val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
        val sektorer = søkeparametere.sektor.map { it.kode }.toSet()

        val sql = """
            SELECT
                count(*) as antall, ia_sak.status
            FROM 
                sykefravar_statistikk_virksomhet AS statistikk
                JOIN virksomhet USING (orgnr)
                JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
                ${
                    if (sektorer.isNotEmpty()) " LEFT JOIN virksomhet_statistikk_metadata USING (orgnr) "
                    else ""
                }
                LEFT JOIN ia_sak ON ( ia_sak.orgnr = statistikk.orgnr )
                JOIN virksomhet_naringsundergrupper AS vn on (virksomhet.id = vn.virksomhet)
                ${joinTilNæringEllerBransje(søkeparametere)}

            WHERE 
                statistikk.arstall = :arstall
                AND statistikk.kvartal = :kvartal
                
                ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                ${filtrerPåKommuner(søkeparametere = søkeparametere)}
                ${filtrerPåSektor(søkeparametere = søkeparametere)}
                ${filtrerPåEiere(søkeparametere = søkeparametere)}
                ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                
                ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk_siste4.prosent >= $it " } ?: ""}
                ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk_siste4.prosent <= $it " } ?: ""}
                ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
                ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
                
                AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
            GROUP BY 
                ia_sak.status
        """.trimIndent()

        val query = queryOf(
            statement = sql,
            mapOf(
                "kvartal" to søkeparametere.periode.kvartal,
                "arstall" to søkeparametere.periode.årstall,
                "naringer" to session.createArrayOf("text", næringsgrupperMedBransjer),
                "kommuner" to session.createArrayOf("text", søkeparametere.kommunenummer),
                "sektorer" to session.createArrayOf("text", sektorer),
                "eiere" to session.createArrayOf("text", søkeparametere.navIdenter),
            )
        ).map(this::mapRowToStatusoversikt).asList
        session.run(query)
    }

    private fun mapRowToStatusoversikt(rad: Row): Statusoversikt {
        return Statusoversikt(
            status = rad.stringOrNull("status")?.let {
                IAProsessStatus.valueOf(it)
            },
            antall = rad.int("antall")
        )
    }
}
