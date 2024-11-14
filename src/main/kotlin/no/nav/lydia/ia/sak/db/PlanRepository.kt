package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.Session
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.eksport.SamarbeidDto
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.eksport.tilPlanKafkaMeldingDto
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.hentInnholdsMålsetning
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID
import javax.sql.DataSource

class PlanRepository(
    val dataSource: DataSource,
) {
    fun opprettPlan(
        planId: UUID,
        prosessId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        mal: PlanMalDto,
    ): Either<Feil, Plan> {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                            INSERT INTO ia_sak_plan (
                                plan_id,
                                ia_prosess,
                                opprettet_av
                            )
                            VALUES (
                                :plan_id,
                                :ia_prosess,
                                :opprettet_av
                            )
                        """.trimMargin(),
                        mapOf(
                            "plan_id" to planId.toString(),
                            "ia_prosess" to prosessId,
                            "opprettet_av" to saksbehandler.navIdent,
                        ),
                    ).asUpdate,
                )
            }
            mal.tema.forEach { tema ->
                session.transaction { tx ->
                    val temaId = tx.run(
                        queryOf(
                            """
                            INSERT INTO ia_sak_plan_tema (
                                navn,
                                inkludert,
                                plan_id
                            )
                            VALUES (
                                :navn,
                                :inkludert,
                                :plan_id
                            )
                            RETURNING *
                            """.trimMargin(),
                            mapOf(
                                "navn" to tema.navn,
                                "inkludert" to tema.inkludert,
                                "plan_id" to planId.toString(),
                            ),
                        ).map { row: Row ->
                            row.int("tema_id")
                        }.asSingle,
                    )!!

                    tema.innhold.forEach { innhold ->
                        tx.run(
                            queryOf(
                                """
                            INSERT INTO ia_sak_plan_undertema (
                                navn,
                                inkludert,
                                status,
                                start_dato, 
                                slutt_dato,
                                tema_id,
                                plan_id
                                
                            )
                            VALUES (
                                :navn,
                                :inkludert,
                                :status,
                                :start_dato, 
                                :slutt_dato,
                                :tema_id,
                                :plan_id
                            )
                                """.trimMargin(),
                                mapOf(
                                    "navn" to innhold.navn,
                                    "inkludert" to innhold.inkludert,
                                    "status" to if (innhold.inkludert) PlanUndertema.Status.PLANLAGT.name else null,
                                    "start_dato" to innhold.startDato?.toJavaLocalDate(),
                                    "slutt_dato" to innhold.sluttDato?.toJavaLocalDate(),
                                    "tema_id" to temaId,
                                    "plan_id" to planId.toString(),
                                ),
                            ).asUpdate,
                        )
                    }
                }
            }
        }

        return hentPlan(prosessId = prosessId)?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette plan",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
    }

    fun hentPlan(prosessId: Int): Plan? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_plan
                        WHERE ia_prosess = :prosessId
                    """.trimMargin(),
                    mapOf(
                        "prosessId" to prosessId,
                    ),
                ).map { row: Row ->
                    val planId = UUID.fromString(row.string("plan_id"))
                    Plan(
                        id = planId,
                        samarbeidId = row.int("ia_prosess"),
                        sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
                        sistPublisert = row.localDateOrNull("sist_publisert")?.toKotlinLocalDate(),
                        temaer = hentTema(planId, session),
                    )
                }.asSingle,
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
                status = row.stringOrNull("status")?.let { IAProsessStatus.valueOf(it) },
                startDato = startDato,
                sluttDato = sluttDato,
                endretTidspunkt = row.localDateTimeOrNull("endret_tidspunkt")?.toKotlinLocalDateTime()
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
            ).map { row: Row ->
                val planIdLestFraDB = UUID.fromString(row.string("plan_id"))
                Plan(
                    id = planIdLestFraDB,
                    samarbeidId = row.int("ia_prosess"),
                    sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
                    sistPublisert = row.localDateOrNull("sist_publisert")?.toKotlinLocalDate(),
                    temaer = hentTema(planIdLestFraDB, session),
                )
            }.asSingle,
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

    private fun hentTema(
        planId: UUID,
        temaId: Int,
    ): PlanTema? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_plan_tema
                        WHERE plan_id = :planId
                        AND tema_id = :temaId
                    """.trimMargin(),
                    mapOf(
                        "planId" to planId.toString(),
                        "temaId" to temaId,
                    ),
                ).map { row: Row ->
                    PlanTema(
                        id = temaId,
                        navn = row.string("navn"),
                        inkludert = row.boolean("inkludert"),
                        undertemaer = hentUndertema(temaId = temaId, session = session),
                    )
                }.asSingle,
            )
        }

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
                PlanUndertema(
                    id = row.int("undertema_id"),
                    navn = innholdsNavn,
                    målsetning = hentInnholdsMålsetning(innholdsNavn) ?: "",
                    inkludert = row.boolean("inkludert"),
                    status = row.stringOrNull("status")?.let { PlanUndertema.Status.valueOf(it) },
                    startDato = row.localDateOrNull("start_dato")?.toKotlinLocalDate(),
                    sluttDato = row.localDateOrNull("slutt_dato")?.toKotlinLocalDate(),
                )
            }.asList,
        )

    fun oppdaterTema(
        planId: UUID,
        temaId: Int,
        inkludert: Boolean,
    ): PlanTema? {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak_plan_tema SET 
                            inkludert = :inkludert
                        WHERE tema_id = :temaId
                        """.trimMargin(),
                        mapOf(
                            "temaId" to temaId,
                            "inkludert" to inkludert,
                        ),
                    ).asUpdate,
                )
            }
        }
        return hentTema(planId = planId, temaId = temaId)
    }

    fun oppdaterUndertema(
        temaId: Int,
        undertema: PlanUndertema,
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            tx.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan_undertema SET 
                        inkludert = :inkludert,
                        status = :status,
                        start_dato = :startDato,
                        slutt_dato = :sluttDato
                    WHERE tema_id = :temaId
                    AND undertema_id = :undertemaId
                    """.trimMargin(),
                    mapOf(
                        "temaId" to temaId,
                        "undertemaId" to undertema.id,
                        "inkludert" to undertema.inkludert,
                        "status" to undertema.status?.name,
                        "startDato" to undertema.startDato?.toJavaLocalDate(),
                        "sluttDato" to undertema.sluttDato?.toJavaLocalDate(),
                    ),
                ).asUpdate,
            )
        }

        hentUndertema(temaId = temaId, session = session).firstOrNull { it.id == undertema.id }
    }

    fun oppdaterSistEndret(plan: Plan) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan SET
                      sist_endret = now()
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf(
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
                ).map { row: Row ->
                    val planId = UUID.fromString(row.string("plan_id"))
                    Plan(
                        id = planId,
                        samarbeidId = row.int("ia_prosess"),
                        sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
                        sistPublisert = row.localDateOrNull("sist_publisert")?.toKotlinLocalDate(),
                        temaer = hentTema(planId, session),
                    )
                }.asList,
            )
        }
}
