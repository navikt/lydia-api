package no.nav.lydia.virksomhet.ssb

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import javax.sql.DataSource

class NæringsRepository(
    val dataSource: DataSource
) {
    fun settInn(næringsDto: NæringsDto) {
        using(sessionOf(dataSource = dataSource)) { session ->
            session.run(queryOf("""
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
            )).asUpdate)
        }
    }
}