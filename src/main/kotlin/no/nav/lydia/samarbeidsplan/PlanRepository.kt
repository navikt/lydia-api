package no.nav.lydia.samarbeidsplan

import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.Session
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.mapTilSalesforceAktivitet
import no.nav.lydia.samarbeid.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.samarbeid.IASamarbeid
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class PlanRepository(
    val dataSource: DataSource,
) {
    fun hentPlan(planId: UUID): Plan? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_plan
                        JOIN ia_prosess ON (ia_sak_plan.ia_prosess = ia_prosess.id)
                        WHERE plan_id = :planId
                        AND ia_sak_plan.status != 'SLETTET'
                    """.trimMargin(),
                    mapOf(
                        "planId" to planId.toString(),
                    ),
                ).map { tilPlan(it, session) }.asSingle,
            )
        }

    fun hentPlan(samarbeidId: Int): Plan? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_plan
                        WHERE ia_prosess = :prosessId
                        AND status != 'SLETTET'
                    """.trimMargin(),
                    mapOf(
                        "prosessId" to samarbeidId,
                    ),
                ).map { tilPlan(it, session) }.asSingle,
            )
        }

    fun hentAlleSamarbeidsplanKafkaMelding(): List<SamarbeidsplanKafkaMelding> =
        using(sessionOf(dataSource)) { session: Session ->
            session.run(
                queryOf(
                    """
                        SELECT 
                          ia_prosess.id as ia_prosess_id,
                          ia_prosess.navn as navn,
                          ia_prosess.status as status,
                          ia_prosess.endret_tidspunkt as endret_tidspunkt,
                          ia_sak.saksnummer as saksnummer,
                          ia_sak.orgnr as orgnr,
                          ia_sak_plan.plan_id as plan_id
                          from ia_sak_plan 
                        JOIN ia_prosess on ia_sak_plan.ia_prosess = ia_prosess.id 
                        JOIN ia_sak on ia_sak.saksnummer = ia_prosess.saksnummer 
                    """.trimMargin(),
                ).map { row: Row ->
                    val planId = UUID.fromString(row.string("plan_id"))

                    hentSamarbeidsplanOgMapTilKafkaMld(
                        planId = planId,
                        session = session,
                        row = row,
                    )
                }.asList,
            )
        }

    fun hentSamarbeidsplanKafkaMelding(planId: UUID): SamarbeidsplanKafkaMelding? =
        using(sessionOf(dataSource)) { session: Session ->
            session.run(
                queryOf(
                    """
                        SELECT 
                          ia_prosess.id as ia_prosess_id,
                          ia_prosess.navn as navn,
                          ia_prosess.status as status,
                          ia_prosess.endret_tidspunkt as endret_tidspunkt,
                          ia_sak.saksnummer as saksnummer,
                          ia_sak.orgnr as orgnr
                          from ia_sak_plan 
                        JOIN ia_prosess on ia_sak_plan.ia_prosess = ia_prosess.id 
                        JOIN ia_sak on ia_sak.saksnummer = ia_prosess.saksnummer 
                        WHERE plan_id = :planId
                    """.trimMargin(),
                    mapOf(
                        "planId" to planId.toString(),
                    ),
                ).map { row: Row ->
                    hentSamarbeidsplanOgMapTilKafkaMld(
                        planId = planId,
                        session = session,
                        row = row,
                    )
                }.asSingle,
            )
        }

    private fun hentSamarbeidsplanOgMapTilKafkaMld(
        planId: UUID,
        session: Session,
        row: Row,
    ): SamarbeidsplanKafkaMelding {
        val plan = hentPlan(planId = planId, session = session)
        val startDato = plan?.startDato()
        val sluttDato = plan?.sluttDato()
        val planDto = plan?.tilDto()
            ?.tilPlanKafkaMeldingDto()
            ?: throw Exception("Plan ikke funnet")
        return SamarbeidsplanKafkaMelding(
            orgnr = row.string("orgnr"),
            saksnummer = row.string("saksnummer"),
            samarbeid = SamarbeidDto(
                id = row.int("ia_prosess_id"),
                navn = row.stringOrNull("navn") ?: DEFAULT_SAMARBEID_NAVN,
                status = row.stringOrNull("status")?.let { IASamarbeid.Status.valueOf(it) },
                startDato = startDato,
                sluttDato = sluttDato,
                endretTidspunkt = row.localDateTimeOrNull("endret_tidspunkt")?.toKotlinLocalDateTime(),
            ),
            plan = planDto,
        )
    }

    private fun hentPlan(
        planId: UUID,
        session: Session,
    ): Plan? =
        session.run(
            queryOf(
                """
                        SELECT *
                        FROM ia_sak_plan
                        WHERE plan_id = :planId
                """.trimMargin(),
                mapOf(
                    "planId" to planId.toString(),
                ),
            ).map { tilPlan(it, session) }.asSingle,
        )

    private fun hentTema(
        planId: UUID,
        session: Session,
    ): List<PlanTema> =
        session.run(
            queryOf(
                """
                        SELECT *
                        FROM ia_sak_plan_tema
                        WHERE plan_id = :planId
                """.trimMargin(),
                mapOf(
                    "planId" to planId.toString(),
                ),
            ).map { row: Row ->
                val temaId = row.int("tema_id")
                PlanTema(
                    id = temaId,
                    navn = row.string("navn"),
                    inkludert = row.boolean("inkludert"),
                    undertemaer = hentUndertema(temaId, session),
                )
            }.asList,
        )

    private fun hentUndertema(
        temaId: Int,
        session: Session,
    ): List<PlanUndertema> =
        session.run(
            queryOf(
                """
                        SELECT *
                        FROM ia_sak_plan_undertema
                        WHERE tema_id = :temaId
                """.trimMargin(),
                mapOf(
                    "temaId" to temaId,
                ),
            ).map { row: Row ->
                val innholdsNavn = row.string("navn")
                val undertemaId = row.int("undertema_id")
                PlanUndertema(
                    id = undertemaId,
                    navn = innholdsNavn,
                    målsetning = hentInnholdsMålsetning(innholdsNavn) ?: "",
                    inkludert = row.boolean("inkludert"),
                    status = row.stringOrNull("status")?.let { PlanUndertema.Status.valueOf(it) },
                    startDato = row.localDateOrNull("start_dato")?.toKotlinLocalDate(),
                    sluttDato = row.localDateOrNull("slutt_dato")?.toKotlinLocalDate(),
                    aktiviteterISalesforce = hentAktiviterISalesforce(
                        planId = row.string("plan_id"),
                        undertemaId = undertemaId,
                    ),
                )
            }.asList,
        )

    fun hentAktiviterISalesforce(
        planId: String,
        undertemaId: Int,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                SELECT salesforce_aktiviteter.* 
                FROM ia_sak_plan_undertema JOIN salesforce_aktiviteter USING (plan_id)
                WHERE plan_id = :planId
                AND undertema_id = :undertemaId
                AND position(lower(navn) in lower(undertema)) > 0
                AND salesforce_aktiviteter.slettet = false
                """.trimIndent(),
                mapOf(
                    "planId" to planId,
                    "undertemaId" to undertemaId,
                ),
            ).map(Row::mapTilSalesforceAktivitet).asList,
        )
    }

    fun oppdaterSistEndret(plan: Plan) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan SET
                      sist_endret = :endretTidspunkt
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf(
                        "endretTidspunkt" to LocalDateTime.now(),
                        "planId" to plan.id.toString(),
                    ),
                ).asUpdate,
            )
        }

    fun hentAllePlaner(): List<Plan> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_plan
                    """.trimMargin(),
                ).map { tilPlan(it, session) }.asList,
            )
        }

    private fun PlanRepository.tilPlan(
        row: Row,
        session: Session,
    ): Plan {
        val planIdLestFraDB = UUID.fromString(row.string("plan_id"))
        return Plan(
            id = planIdLestFraDB,
            samarbeidId = row.int("ia_prosess"),
            sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
            status = IASamarbeid.Status.valueOf(row.string("status")),
            temaer = hentTema(planIdLestFraDB, session),
        )
    }

    fun settPlanTilAvbrutt(plan: Plan) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                plan.temaer.forEach { tema ->
                    tx.run(
                        queryOf(
                            """
                            UPDATE ia_sak_plan_undertema
                            SET status = :statusAvbrutt
                            WHERE status != :statusFullfort
                            AND tema_id = :temaId
                            AND plan_id = :planId
                            AND inkludert = true
                            """.trimIndent(),
                            mapOf(
                                "statusFullfort" to PlanUndertema.Status.FULLFØRT.name,
                                "statusAvbrutt" to PlanUndertema.Status.AVBRUTT.name,
                                "temaId" to tema.id,
                                "planId" to plan.id.toString(),
                            ),
                        ).asUpdate,
                    )
                }
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak_plan
                        SET status = :statusAvbrutt
                        WHERE plan_id = :planId
                        """.trimIndent(),
                        mapOf(
                            "statusAvbrutt" to IASamarbeid.Status.AVBRUTT.name,
                            "planId" to plan.id.toString(),
                        ),
                    ).asUpdate,
                )
            }
        }
    }
}
