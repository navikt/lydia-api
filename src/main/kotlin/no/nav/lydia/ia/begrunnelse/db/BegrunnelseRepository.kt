package no.nav.lydia.ia.begrunnelse.db

import no.nav.lydia.ia.begrunnelse.domene.ValgtÅrsak
import javax.sql.DataSource

class BegrunnelseRepository(val dataSource: DataSource) {
//    fun hentBegrunnelser(): List<Årsak> {
//         using(sessionOf(dataSource)) { session ->
//            session.run(queryOf("""
//                select
//                        aarsak.id,
//                        aarsak.navn,
//                        begrunnelse.id,
//                        begrunnelse.navn
//                    from
//                        ikke_aktuell_aarsak as aarsak
//                        join ikke_aktuell_begrunnelse as begrunnelse on (aarsak.id = begrunnelse.aarsak_id)
//            """.trimIndent()).map { row -> {
//                Pair(Årsak(), Begrunnelse())
//            } }.asList)
//        }
//    }
    fun hentBegrunnelser() = listOf<ValgtÅrsak>()
}