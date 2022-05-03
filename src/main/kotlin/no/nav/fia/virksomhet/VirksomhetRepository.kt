package no.nav.fia.virksomhet

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.fia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.fia.virksomhet.domene.Næringsgruppe
import no.nav.fia.virksomhet.domene.Virksomhet
import javax.sql.DataSource

class VirksomhetRepository(val dataSource: DataSource) {

    fun insert(virksomhet: BrregVirksomhetDto) {
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
                            VALUES ${virksomhet.hentNæringsgruppekoder().keys.joinToString(transform = { "((select id from virksomhetId), :${it}) " })}
                            ON CONFLICT DO NOTHING
                            """.trimMargin(),
                        mutableMapOf(
                            "orgnr" to virksomhet.organisasjonsnummer,
                            "navn" to virksomhet.navn,
                            "land" to virksomhet.beliggenhetsadresse?.land,
                            "landkode" to virksomhet.beliggenhetsadresse?.landkode,
                            "postnummer" to virksomhet.beliggenhetsadresse?.postnummer,
                            "poststed" to virksomhet.beliggenhetsadresse?.poststed,
                            "adresse" to session.connection.underlying.createArrayOf(
                                "text",
                                virksomhet.beliggenhetsadresse?.adresse?.toTypedArray() ?: emptyArray()
                            ),
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

    fun hentVirksomhet(orgnr: String) =
        sessionOf(dataSource).use { session ->
            session.run(queryOf(
                """
                    SELECT 
                        virksomhet.id,
                        virksomhet.orgnr,
                        virksomhet.navn,
                        virksomhet.adresse,
                        virksomhet.postnummer,
                        virksomhet.poststed,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        virksomhet.land,
                        virksomhet.landkode,
                        string_agg(naring.kode || '-' || naring.navn, '€') AS naringer
                    FROM virksomhet 
                    JOIN virksomhet_naring ON (virksomhet.id = virksomhet_naring.virksomhet)
                    JOIN naring ON (virksomhet_naring.narings_kode = naring.kode)
                    WHERE virksomhet.orgnr = :orgnr
                    GROUP BY 1,2,3
                """.trimIndent(),
                mapOf("orgnr" to orgnr)
            ).map { row ->
                Virksomhet(
                    id = row.long("id"),
                    orgnr = orgnr,
                    navn = row.string("navn"),
                    adresse = row.array<String>("adresse").toList(),
                    postnummer = row.int("postnummer"),
                    poststed = row.string("poststed"),
                    kommune = row.string("kommune"),
                    kommunenummer = row.string("kommunenummer"),
                    land = row.string("land"),
                    landkode = row.string("landkode"),
                    næringsgrupper = row.string("naringer")
                        .split("€")
                        .map { naring ->
                            Næringsgruppe(
                                kode = naring.split("-")[0],
                                navn = naring.split("-")[1]
                            )
                        })
            }.asSingle)
        }
}