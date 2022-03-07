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
                                adresse,
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
                                    :adresse,
                                    :kommune,
                                    :kommunenummer
                                ) 
                                ON CONFLICT (orgnr) DO UPDATE SET
                                    navn = :navn,
                                    land = :land,
                                    landkode = :landkode,
                                    postnummer = :postnummer,
                                    poststed = :poststed,
                                    adresse = :adresse,
                                    kommune = :kommune,
                                    kommunenummer = :kommunenummer
                                RETURNING id
                           )
                           INSERT INTO virksomhet_naring(
                                virksomhet,
                                narings_kode 
                            )
                            VALUES ${virksomhet.hentNæringsgruppekoder().keys.joinToString(transform = {"((select id from virksomhetId), :${it}) "})}
                            ON CONFLICT DO NOTHING
                            """.trimMargin(),
                        mutableMapOf(
                            "orgnr" to virksomhet.organisasjonsnummer,
                            "navn" to virksomhet.navn,
                            "land" to virksomhet.beliggenhetsadresse?.land,
                            "landkode" to virksomhet.beliggenhetsadresse?.landkode,
                            "postnummer" to virksomhet.beliggenhetsadresse?.postnummer,
                            "poststed" to virksomhet.beliggenhetsadresse?.poststed,
                            "adresse" to session.connection.underlying.createArrayOf("text", virksomhet.beliggenhetsadresse?.adresse?.toTypedArray() ?: emptyArray()),
                            "kommune" to virksomhet.beliggenhetsadresse?.kommune,
                            "kommunenummer" to virksomhet.beliggenhetsadresse?.kommunenummer,
                        ).apply {
                            this.putAll(virksomhet.hentNæringsgruppekoder())
                        },
                    ).asUpdate
                )
            }
        }
    }
}