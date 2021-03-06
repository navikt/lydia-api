package no.nav.lydia.virksomhet

import kotlinx.datetime.LocalDate
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinInstant
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.Serializable
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Virksomhet
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import org.intellij.lang.annotations.Language
import javax.sql.DataSource

class VirksomhetRepository(val dataSource: DataSource) {
    fun insert(virksomhet: VirksomhetLagringDao) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                @Language("PostgreSQL")
                val sql = """
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
                                kommunenummer,
                                status,
                                oppstartsdato,
                                oppdatertAvBrregOppdateringsId,
                                sistEndretTidspunkt
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
                                    :kommunenummer,
                                    :status,
                                    :oppstartsdato,
                                    :oppdatertAvBrregOppdateringsId,
                                    null
                                ) 
                                ON CONFLICT (orgnr) DO UPDATE SET
                                    navn = :navn,
                                    land = :land,
                                    landkode = :landkode,
                                    postnummer = :postnummer,
                                    poststed = :poststed,
                                    adresse = :adresse,
                                    kommune = :kommune,
                                    kommunenummer = :kommunenummer,
                                    status = :status,                                              
                                    oppstartsdato = :oppstartsdato,                                
                                    oppdatertAvBrregOppdateringsId = :oppdatertAvBrregOppdateringsId,
                                    sistEndretTidspunkt = now()
                                RETURNING id
                           )
                           INSERT INTO virksomhet_naring(
                                virksomhet,
                                narings_kode 
                            )
                            VALUES ${virksomhet.hentNæringsgruppekoder().keys.joinToString(transform = { "((select id from virksomhetId), :${it}) " })}
                            ON CONFLICT DO NOTHING
                            """.trimMargin()
                val params = mutableMapOf(
                    "orgnr" to virksomhet.orgnr,
                    "navn" to virksomhet.navn,
                    "land" to virksomhet.land,
                    "landkode" to virksomhet.landkode,
                    "postnummer" to virksomhet.postnummer,
                    "poststed" to virksomhet.poststed,
                    "adresse" to session.connection.underlying.createArrayOf(
                        "text",
                        virksomhet.adresse.toTypedArray()
                    ),
                    "kommune" to virksomhet.kommune,
                    "kommunenummer" to virksomhet.kommunenummer,
                    "status" to virksomhet.status.name,
                    "oppstartsdato" to virksomhet.oppstartsdato?.toJavaLocalDate(),
                    "oppdatertAvBrregOppdateringsId" to virksomhet.oppdatertAvBrregOppdateringsId
                ).apply {
                    this.putAll(virksomhet.hentNæringsgruppekoder())
                }
                tx.run(
                    queryOf(
                        sql,
                        params,
                    ).asUpdate
                )
            }
        }
    }

    fun oppdaterStatus(orgnr: String, status: VirksomhetStatus, oppdatertAvBrregOppdateringsId: Long?) {
        sessionOf(dataSource).use { session ->
            @Language("PostgreSQL")
            val sql = """
                        UPDATE virksomhet SET
                        status = :status,
                        oppdatertAvBrregOppdateringsId = :oppdatertAvBrregOppdateringsId,
                        sistEndretTidspunkt = now()
                        WHERE orgnr = :orgnr
                    """.trimIndent()
            val params = mapOf(
                "orgnr" to orgnr,
                "status" to status.name,
                "oppdatertAvBrregOppdateringsId" to oppdatertAvBrregOppdateringsId
            )
            session.run(
                queryOf(
                    statement = sql,
                    paramMap = params
                ).asUpdate
            )
        }
    }

    fun hentVirksomhet(orgnr: String): Virksomhet? {
        @Language("PostgreSQL")
        val sql = """
                    SELECT 
                        virksomhet.id,
                        virksomhet.status,
                        virksomhet.oppstartsdato,
                        virksomhet.orgnr,
                        virksomhet.navn,
                        virksomhet.adresse,
                        virksomhet.postnummer,
                        virksomhet.poststed,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        virksomhet.land,
                        virksomhet.landkode,
                        virksomhet_statistikk_metadata.sektor,
                        string_agg(naring.kode || '∞' || naring.navn, '€') AS naringer,
                        virksomhet.oppdatertAvBrregOppdateringsId,
                        virksomhet.opprettetTidspunkt,
                        virksomhet.sistEndretTidspunkt
                    FROM virksomhet 
                    JOIN virksomhet_naring ON (virksomhet.id = virksomhet_naring.virksomhet)
                    JOIN naring ON (virksomhet_naring.narings_kode = naring.kode)
                    LEFT JOIN virksomhet_statistikk_metadata USING (orgnr)
                    WHERE virksomhet.orgnr = :orgnr
                    GROUP BY
                        virksomhet.id,
                        virksomhet.orgnr,
                        virksomhet_statistikk_metadata.sektor
                """.trimIndent()
        val params = mapOf("orgnr" to orgnr)
        return sessionOf(dataSource).use { session ->
            session.run(
                queryOf(
                    sql,
                    params
                ).map { row ->
                    Virksomhet(
                        id = row.long("id"),
                        orgnr = orgnr,
                        navn = row.string("navn"),
                        status = VirksomhetStatus.valueOf(row.string("status")),
                        oppstartsdato = row.localDateOrNull("oppstartsdato")?.toKotlinLocalDate(),
                        adresse = row.array<String>("adresse").toList(),
                        postnummer = row.string("postnummer"),
                        poststed = row.string("poststed"),
                        kommune = row.string("kommune"),
                        kommunenummer = row.string("kommunenummer"),
                        land = row.string("land"),
                        landkode = row.string("landkode"),
                        næringsgrupper = row.string("naringer")
                            .split("€")
                            .map { naring ->
                                Næringsgruppe(
                                    kode = naring.split("∞")[0],
                                    navn = naring.split("∞")[1]
                                )
                            },
                        sektor = row.stringOrNull("sektor"),
                        oppdatertAvBrregOppdateringsId = row.longOrNull("oppdatertAvBrregOppdateringsId"),
                        opprettetTidspunkt = row.instant("opprettetTidspunkt").toKotlinInstant(),
                        sistEndretTidspunkt = row.instantOrNull("sistEndretTidspunkt")?.toKotlinInstant()
                    )
                }.asSingle
            )
        }
    }

    fun finnVirksomheter(søkestreng: String): List<VirksomhetSøkeresultat> {
        val søkEtterOrgnummer = søkestreng.matches("\\d{3,9}".toRegex())
        return sessionOf(dataSource = dataSource).use { session ->
            @Language("PostgreSQL")
            val sql = """
                    SELECT 
                        orgnr,
                        navn 
                    FROM virksomhet
                    WHERE navn ilike :sokestreng
                    ${if (søkEtterOrgnummer) "OR orgnr like :sokestreng" else ""}
                    LIMIT 10
                    """.trimMargin()
            val params = mapOf(
                "sokestreng" to "$søkestreng%",
            )
            session.run(
                queryOf(
                    sql,
                    params
                )
                    .map { row ->
                        VirksomhetSøkeresultat(
                            orgnr = row.string("orgnr"),
                            navn = row.string("navn")
                        )
                    }.asList
            )
        }
    }

}

@Serializable
data class VirksomhetSøkeresultat(val orgnr: String, val navn: String)

data class VirksomhetLagringDao(
    val orgnr: String,
    val navn: String,
    val status: VirksomhetStatus,
    val oppstartsdato: LocalDate?,
    val adresse: List<String>,
    val postnummer: String,
    val poststed: String,
    val kommune: String,
    val kommunenummer: String,
    val land: String,
    val landkode: String,
    val næringsgrupper: Map<String, String>,
    val oppdatertAvBrregOppdateringsId: Long?,
) {
    fun hentNæringsgruppekoder() = næringsgrupper.toMap()
}