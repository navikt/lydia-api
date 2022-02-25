package no.nav.lydia.virksomhet

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.virksomhet.brreg.VirksomhetDto
import javax.sql.DataSource

class VirksomhetRepository(val dataSource: DataSource) {

    fun insert(virksomhet: VirksomhetDto) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                           WITH virksomhetId AS(
                               INSERT INTO virksomhet(
                                orgnr,
                                navn,
                                land,
                                landkode,
                                postnummer,
                                poststed,
                                kommune,
                                kommunenummer
                               )
                                VALUES(
                                    :orgnr,
                                    :navn,
                                    :land,
                                    :landkode,
                                    :postnummer,
                                    :poststed,
                                    :kommune,
                                    :kommunenummer
                                ) 
                                ON CONFLICT DO NOTHING
                                RETURNING id
                           )
                           INSERT INTO virksomhet_naring(
                                virksomhet,
                                narings_kode 
                            )
                            VALUES
                                ${virksomhet.hentNæringsgruppekoder().keys.joinToString(transform = {"((select id from virksomhetId), :${it}) "})}
                            """.trimMargin(),
                        mutableMapOf(
                            "orgnr" to virksomhet.organisasjonsnummer,
                            "navn" to virksomhet.navn,
                            "land" to virksomhet.beliggenhetsadresse.land,
                            "landkode" to virksomhet.beliggenhetsadresse.landkode,
                            "postnummer" to virksomhet.beliggenhetsadresse.postnummer,
                            "poststed" to virksomhet.beliggenhetsadresse.poststed,
                            "kommune" to virksomhet.beliggenhetsadresse.kommune,
                            "kommunenummer" to virksomhet.beliggenhetsadresse.kommunenummer,
                        ).apply {
                            this.putAll(virksomhet.hentNæringsgruppekoder())
                        },
                    ).asUpdate
                )
//                virksomhet.hentNæringsgrupper().forEach {
//                    tx.run(
//                        queryOf(
//                            """
//                                INSERT INTO virksomhet_naring(
//                                    virksomhet,
//                                    narings_kode
//                                )
//                                VALUES(
//                                    :id
//                                    :kode
//                                )
//                            """.trimIndent(),
//                            mapOf(
//                                "id" to id,
//                                "kode" to it.kode
//                            )
//                        ).asUpdate
//                    )
//                }
            }
        }
    }
}