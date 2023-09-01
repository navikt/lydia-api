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
import no.nav.lydia.virksomhet.domene.tilSektor
import javax.sql.DataSource

class VirksomhetRepository(val dataSource: DataSource) {
    fun insertVirksomhet(virksomhet: VirksomhetLagringDao) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                val virksomhetInsertSql = """
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
                                oppdatertAvBrregOppdateringsId
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
                                    :oppdatertAvBrregOppdateringsId
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
                )
                tx.run(
                    queryOf(
                        virksomhetInsertSql,
                        params,
                    ).asExecute
                )

            }
        }
    }


    fun oppdaterStatus(orgnr: String, status: VirksomhetStatus, oppdatertAvBrregOppdateringsId: Long?) {
        sessionOf(dataSource).use { session ->
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
                        virksomhet_naringsundergrupper.naringsundergruppe1,
                        virksomhet_naringsundergrupper.naringsundergruppe2,
                        virksomhet_naringsundergrupper.naringsundergruppe3,
                        naring1.navn as naringsundergruppenavn1,
                        naring2.navn as naringsundergruppenavn2,
                        naring3.navn as naringsundergruppenavn3,
                        virksomhet.oppdatertAvBrregOppdateringsId,
                        virksomhet.opprettetTidspunkt,
                        virksomhet.sistEndretTidspunkt
                    FROM virksomhet 
                    JOIN virksomhet_naringsundergrupper ON (virksomhet.id = virksomhet_naringsundergrupper.virksomhet)
                    JOIN naring as naring1 ON (virksomhet_naringsundergrupper.naringsundergruppe1 = naring1.kode)
                    LEFT JOIN naring as naring2 ON (virksomhet_naringsundergrupper.naringsundergruppe2 = naring2.kode)
                    LEFT JOIN naring as naring3 ON (virksomhet_naringsundergrupper.naringsundergruppe3 = naring3.kode)
                    LEFT JOIN virksomhet_statistikk_metadata USING (orgnr)
                    WHERE virksomhet.orgnr = :orgnr
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
                        næringsundergruppe1 = Næringsgruppe(
                            kode = row.string("naringsundergruppe1"),
                            navn = row.string("naringsundergruppenavn1")
                        ),
                        næringsundergruppe2 = row.stringOrNull("naringsundergruppe2")?.let { næringsundergruppe2 ->
                            Næringsgruppe(
                                kode = næringsundergruppe2,
                                navn = row.string("naringsundergruppenavn2")
                            )
                        },
                        næringsundergruppe3 = row.stringOrNull("naringsundergruppe3")?.let { næringsundergruppe3 ->
                            Næringsgruppe(
                                kode = næringsundergruppe3,
                                navn = row.string("naringsundergruppenavn3")
                            )
                        },
                        sektor = row.stringOrNull("sektor")?.tilSektor(),
                        oppdatertAvBrregOppdateringsId = row.longOrNull("oppdatertAvBrregOppdateringsId"),
                        opprettetTidspunkt = row.instant("opprettetTidspunkt").toKotlinInstant(),
                        sistEndretTidspunkt = row.instant("sistEndretTidspunkt").toKotlinInstant()
                    )
                }.asSingle
            )
        }
    }

    fun finnVirksomheter(søkestreng: String): List<VirksomhetSøkeresultat> {
        val søkestrengSomStøtterStjerne = søkestreng.replace("*", "%")
        val søkEtterOrgnummer = søkestrengSomStøtterStjerne.matches("\\d{3,9}".toRegex())
        return sessionOf(dataSource = dataSource).use { session ->
            val sql = """
                    SELECT 
                        orgnr,
                        navn 
                    FROM virksomhet
                    WHERE navn ilike :ekspanderbarSokestreng
                    ${if (søkEtterOrgnummer) "OR orgnr like :ekspanderbarSokestreng" else ""}
                    ORDER BY 
                        (lower(navn) = lower(:sokestreng)) DESC,
                        POSITION(LOWER(:sokestreng) IN LOWER(navn)),
                        navn
                    LIMIT 10
                    """.trimMargin()
            val params = mapOf(
                "sokestreng" to søkestrengSomStøtterStjerne,
                "ekspanderbarSokestreng" to "%$søkestrengSomStøtterStjerne%",
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

    fun insertNæringsundergrupper(virksomhet: VirksomhetLagringDao) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                val insertSql = """
                    WITH virksomhetId as (
                        select id from virksomhet where orgnr = :orgnr
                    )
                    INSERT INTO virksomhet_naringsundergrupper(
                        virksomhet,
                        naringsundergruppe1,
                        naringsundergruppe2,
                        naringsundergruppe3
                    )
                    VALUES (
                        (select id from virksomhetId),
                        :naringsundergruppe1,
                        :naringsundergruppe2,
                        :naringsundergruppe3
                    )                   
                    ON CONFLICT (virksomhet) DO UPDATE SET 
                        naringsundergruppe1 = :naringsundergruppe1,
                        naringsundergruppe2 = :naringsundergruppe2,
                        naringsundergruppe3 = :naringsundergruppe3,
                        oppdateringsdato = now()
                """.trimIndent()
                tx.run(
                        queryOf(
                                insertSql,
                                mapOf(
                                        "orgnr" to virksomhet.orgnr,
                                        "naringsundergruppe1" to virksomhet.næringsgrupper["naeringskode1"],
                                        "naringsundergruppe2" to virksomhet.næringsgrupper["naeringskode2"],
                                        "naringsundergruppe3" to virksomhet.næringsgrupper["naeringskode3"],
                                )
                        ).asUpdate
                )
            }
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
)
