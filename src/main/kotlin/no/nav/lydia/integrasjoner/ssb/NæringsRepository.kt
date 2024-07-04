package no.nav.lydia.integrasjoner.ssb

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import javax.sql.DataSource

class NæringsRepository(
    val dataSource: DataSource
) {
    fun settInn(næringsDto: NæringsDto) {
        using(sessionOf(dataSource = dataSource)) { session ->
            session.run(
                queryOf(
                    """
                INSERT INTO naring (kode, navn, kort_navn) 
                    VALUES (:kode, :navn, :kort_navn)
                ON CONFLICT (kode) DO 
                    UPDATE SET 
                        navn = (:navn),
                        kort_navn = (:kort_navn)
            """.trimIndent(), mapOf(
                        "kode" to næringsDto.code,
                        "navn" to næringsDto.name,
                        "kort_navn" to næringsDto.shortName
                    )
                ).asUpdate
            )
        }
    }

    fun hentNæringer() = using(sessionOf(dataSource = dataSource)) { session ->
        session.run(
            queryOf(
                """
                select * from naring where length(kode) = 2
            """.trimIndent()
            ).map {
                Næringsgruppe(navn = it.string("navn"), kode = it.string("kode"))
            }.asList
        )
    }
}