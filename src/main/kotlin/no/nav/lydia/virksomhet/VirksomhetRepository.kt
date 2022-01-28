package no.nav.lydia.virksomhet

import kotliquery.queryOf
import kotliquery.sessionOf
import no.nav.lydia.virksomhet.brreg.VirksomhetDTO
import javax.sql.DataSource

class VirksomhetRepository(val dataSource: DataSource) {

    fun insert(virksomhet: VirksomhetDTO) {
        val session = sessionOf(dataSource)
        session.run(
            queryOf(
                """
                       INSERT INTO virksomhet(
                        orgnr,
                        land,
                        landkode,
                        postnummer,
                        poststed,
                        kommune,
                        kommunenummer
                       )
                        VALUES(
                        :orgnr,
                        :land,
                        :landkode,
                        :postnummer,
                        :poststed,
                        :kommune,
                        :kommunenummer
                        ) 
                        ON CONFLICT DO NOTHING
                        """.trimMargin(),
                mapOf(
                    "orgnr" to virksomhet.organisasjonsnummer,
                    "land" to virksomhet.beliggenhetsadresse.land,
                    "landkode" to virksomhet.beliggenhetsadresse.landkode,
                    "postnummer" to virksomhet.beliggenhetsadresse.postnummer,
                    "poststed" to virksomhet.beliggenhetsadresse.poststed,
                    "kommune" to virksomhet.beliggenhetsadresse.kommune,
                    "kommunenummer" to virksomhet.beliggenhetsadresse.kommunenummer
                )
            ).asUpdate
        )
    }

}