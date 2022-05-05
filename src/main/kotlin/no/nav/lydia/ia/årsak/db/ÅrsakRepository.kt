package no.nav.lydia.ia.årsak.db

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import javax.sql.DataSource

class ÅrsakRepository(private val dataSource: DataSource) {

    fun lagreÅrsakForHendelse(sakshendelse: VirksomhetIkkeAktuellHendelse) =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                sakshendelse.valgtÅrsak.begrunnelser.forEach { begrunnelse ->
                    tx.run(
                        queryOf(
                            """
                            INSERT INTO hendelse_begrunnelse (
                                hendelse_id,
                                aarsak,
                                begrunnelse,
                                aarsak_enum,
                                begrunnelse_enum
                            )
                            VALUES (
                                :hendelse_id,
                                :aarsak,
                                :begrunnelse,
                                :aarsak_enum,
                                :begrunnelse_enum
                            ) 
                            ON CONFLICT DO NOTHING  
                        """.trimMargin(),
                            mapOf(
                                "hendelse_id" to sakshendelse.id,
                                "aarsak" to sakshendelse.valgtÅrsak.type.navn,
                                "begrunnelse" to begrunnelse.navn,
                                "aarsak_enum" to sakshendelse.valgtÅrsak.type.name,
                                "begrunnelse_enum" to begrunnelse.name

                            )
                        ).asUpdate
                    )
                }
            }
        }
}
