package no.nav.lydia.virksomhet

import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.virksomhet.brreg.Beliggenhetsadresse
import no.nav.lydia.virksomhet.brreg.VirksomhetDto
import javax.sql.DataSource

class VirksomhetRepository(val dataSource: DataSource) {

    fun hentVirksomheterFraKommunenummer(kommunenummer: Collection<String>): List<VirksomhetDto> {
        val queryString = """
            SELECT * FROM virksomhet
            LEFT JOIN virksomhet_naring ON virksomhet.id = virksomhet_naring.virksomhet
            WHERE kommunenummer IN (${kommunenummer.joinToString(transform = { "?" })});
        """.trimIndent()
        val query = queryOf(
            statement = queryString,
            *kommunenummer.toTypedArray()
        ).map { rowToVirksomhetDto(it) }.asList
        return using(sessionOf(dataSource)) { session ->
            session.run(query)
        }
    }

    fun hentAlleVirksomheter(): List<VirksomhetDto> {
        val queryString = """
            SELECT * FROM virksomhet
            LEFT JOIN virksomhet_naring ON virksomhet.id = virksomhet_naring.virksomhet;
        """.trimIndent()
        val query = queryOf(
            statement = queryString
        ).map { rowToVirksomhetDto(it) }.asList
        return using(sessionOf(dataSource)) { session ->
            session.run(query)
        }
    }

    fun insert(virksomhet: VirksomhetDto) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                val id = tx.run(
                    queryOf(
                        """
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
                            """.trimMargin(),
                        mapOf(
                            "orgnr" to virksomhet.organisasjonsnummer,
                            "navn" to virksomhet.navn,
                            "land" to virksomhet.beliggenhetsadresse.land,
                            "landkode" to virksomhet.beliggenhetsadresse.landkode,
                            "postnummer" to virksomhet.beliggenhetsadresse.postnummer,
                            "poststed" to virksomhet.beliggenhetsadresse.poststed,
                            "kommune" to virksomhet.beliggenhetsadresse.kommune,
                            "kommunenummer" to virksomhet.beliggenhetsadresse.kommunenummer
                        )
                    ).asUpdateAndReturnGeneratedKey
                )
                virksomhet.hentNæringsgrupper().forEach {
                    tx.run(
                        queryOf(
                            """
                                INSERT INTO virksomhet_naring(
                                    virksomhet,
                                    narings_kode 
                                )
                                VALUES(
                                    :id
                                    :kode
                                )
                            """.trimIndent(),
                            mapOf(
                                "id" to id,
                                "kode" to it.kode
                            )
                        ).asUpdate
                    )
                }
            }
        }
    }

    private fun rowToVirksomhetDto(row: Row) = VirksomhetDto(
        organisasjonsnummer = row.string("orgnr"),
        navn = row.string("navn"),
        beliggenhetsadresse = Beliggenhetsadresse(
            land = row.string("land"),
            landkode = row.string("landkode"),
            postnummer = row.string("postnummer"),
            poststed = row.string("poststed"),
            kommune = row.string("kommune"),
            kommunenummer = row.string("kommunenummer")
        ),
    )

}