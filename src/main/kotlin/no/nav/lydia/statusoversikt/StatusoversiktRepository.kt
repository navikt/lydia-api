package no.nav.lydia.statusoversikt

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåBransjeOgNæring
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåEiere
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåKommuner
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.filtrerPåSektor
import javax.sql.DataSource

class StatusoversiktRepository(
    val dataSource: DataSource,
) {
    fun hentStatusoversikt(søkeparametere: Søkeparametere) =
        using(sessionOf(dataSource)) { session ->
            val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
            val sektorer = søkeparametere.sektor.map { it.kode }.toSet()

            val sql =
                """
                SELECT
                    count(*) as antall, ia_sak.status
                FROM 
                    virksomhetsstatistikk_for_prioritering AS statistikk
                    LEFT JOIN ia_sak ON ( ia_sak.orgnr = statistikk.orgnr )
                WHERE 
                    true = true
                    ${filtrerPåBransjeOgNæring(søkeparametere = søkeparametere)}
                    ${filtrerPåKommuner(søkeparametere = søkeparametere)}
                    ${filtrerPåSektor(søkeparametere = søkeparametere)}
                    ${filtrerPåEiere(søkeparametere = søkeparametere)}
                    
                    ${søkeparametere.sykefraværsprosentFra?.let { " AND prosent >= $it " } ?: ""}
                    ${søkeparametere.sykefraværsprosentTil?.let { " AND prosent <= $it " } ?: ""}
                    ${søkeparametere.ansatteFra?.let { " AND antall_personer_siste_kvartal >= $it " } ?: ""}
                    ${søkeparametere.ansatteTil?.let { " AND antall_personer_siste_kvartal <= $it " } ?: ""}
                GROUP BY 
                    ia_sak.status
                """.trimIndent()

            val query = queryOf(
                statement = sql,
                mapOf(
                    "naringer" to session.createArrayOf("text", næringsgrupperMedBransjer),
                    "kommuner" to session.createArrayOf("text", søkeparametere.kommunenummer),
                    "sektorer" to session.createArrayOf("text", sektorer),
                    "eiere" to session.createArrayOf("text", søkeparametere.navIdenter),
                ),
            ).map(this::mapRowToStatusoversikt).asList
            session.run(query)
        }

    private fun mapRowToStatusoversikt(rad: Row): Statusoversikt =
        Statusoversikt(
            status = rad.stringOrNull("status")?.let {
                IASak.Status.valueOf(it)
            },
            antall = rad.int("antall"),
        )
}
