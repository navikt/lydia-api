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
                    "land" to virksomhet.forretningsadresse.land,
                    "landkode" to virksomhet.forretningsadresse.landkode,
                    "postnummer" to virksomhet.forretningsadresse.postnummer,
                    "poststed" to virksomhet.forretningsadresse.poststed,
                    "kommune" to virksomhet.forretningsadresse.kommune,
                    "kommunenummer" to virksomhet.forretningsadresse.kommunenummer
                )
            ).asUpdate
        )
    }

}