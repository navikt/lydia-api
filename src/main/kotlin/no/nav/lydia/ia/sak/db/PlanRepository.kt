package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.Session
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanRessurs
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.hentInnholdsMålsetning
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
        mal: PlanMalDto = PlanMalDto(),
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
                                planlagt,
                                plan_id
                            )
                            VALUES (
                                :navn,
                                :planlagt,
                                :plan_id
                            )
                            RETURNING *
                            """.trimMargin(),
                            mapOf(
                                "navn" to tema.navn,
                                "planlagt" to false,
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
                                planlagt,
                                status,
                                start_dato, 
                                slutt_dato,
                                tema_id,
                                plan_id
                                
                            )
                            VALUES (
                                :navn,
                                :planlagt,
                                :status,
                                :start_dato, 
                                :slutt_dato,
                                :tema_id,
                                :plan_id
                            )
                                """.trimMargin(),
                                mapOf(
                                    "navn" to innhold.navn,
                                    "planlagt" to false,
                                    "status" to null,
                                    "start_dato" to null,
                                    "slutt_dato" to null,
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
                        sistEndret = row.localDate("sist_endret").toKotlinLocalDate(),
                        sistPublisert = row.localDateOrNull("sist_publisert")?.toKotlinLocalDate(),
                        temaer = hentTema(planId, session),
                    )
                }.asSingle,
            )
        }

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
                    planlagt = row.boolean("planlagt"),
                    undertemaer = hentUndertema(planId, temaId, session),
                    ressurser = hentRessurser(planId, temaId, session),
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
                        planlagt = row.boolean("planlagt"),
                        undertemaer = hentUndertema(planId, temaId, session),
                        ressurser = hentRessurser(planId, temaId, session),
                    )
                }.asSingle,
            )
        }

    private fun hentUndertema(
        planId: UUID,
        temaId: Int,
        session: Session,
    ): List<PlanUndertema> =
        session.run(
            queryOf(
                """
                        SELECT *
                        FROM ia_sak_plan_undertema
                        WHERE plan_id = :planId
                        AND tema_id = :temaId
                """.trimMargin(),
                mapOf(
                    "planId" to planId.toString(),
                    "temaId" to temaId,
                ),
            ).map { row: Row ->
                val innholdsNavn = row.string("navn")
                PlanUndertema(
                    id = row.int("undertema_id"),
                    navn = innholdsNavn,
                    målsetning = hentInnholdsMålsetning(innholdsNavn) ?: "",
                    planlagt = row.boolean("planlagt"),
                    status = row.stringOrNull("status")?.let { PlanUndertema.Status.valueOf(it) },
                    startDato = row.localDateOrNull("start_dato")?.toKotlinLocalDate(),
                    sluttDato = row.localDateOrNull("slutt_dato")?.toKotlinLocalDate(),
                )
            }.asList,
        )

    private fun hentRessurser(
        planId: UUID,
        temaId: Int,
        session: Session,
    ): List<PlanRessurs> =
        session.run(
            queryOf(
                """
                        SELECT *
                        FROM ia_sak_plan_ressurs
                        WHERE plan_id = :planId
                        AND tema_id = :temaId
                """.trimMargin(),
                mapOf(
                    "planId" to planId.toString(),
                    "temaId" to temaId,
                ),
            ).map { row: Row ->
                PlanRessurs(
                    id = row.int("ressurs_id"),
                    beskrivelse = row.string("beskrivelse"),
                    url = row.stringOrNull("url"),
                )
            }.asList,
        )

    fun oppdaterTema(
        planId: UUID,
        temaId: Int,
        undertemaer: List<PlanUndertema>,
        planlagt: Boolean,
    ): PlanTema? {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak_plan_tema SET 
                            planlagt = :planlagt
                        WHERE plan_id = :planId
                        AND tema_id = :temaId
                        """.trimMargin(),
                        mapOf(
                            "planId" to planId.toString(),
                            "temaId" to temaId,
                            "planlagt" to planlagt,
                        ),
                    ).asUpdate,
                )
            }

            undertemaer.forEach { undertema ->
                oppdaterUndertema(planId = planId, temaId = temaId, endretUndertema = undertema, session = session)
            }
        }
        return hentTema(planId = planId, temaId = temaId)
    }

    private fun oppdaterUndertema(
        planId: UUID,
        temaId: Int,
        endretUndertema: PlanUndertema,
        session: Session,
    ) {
        session.transaction { tx ->
            tx.run(
                queryOf(
                    """
                        UPDATE ia_sak_plan_undertema SET 
                            planlagt = :planlagt,
                            status = :status,
                            start_dato = :startDato,
                            slutt_dato = :sluttDato
                        WHERE plan_id = :planId
                        AND tema_id = :temaId
                        AND undertema_id = :undertemaId
                    """.trimMargin(),
                    mapOf(
                        "planId" to planId.toString(),
                        "temaId" to temaId,
                        "undertemaId" to endretUndertema.id,
                        "planlagt" to endretUndertema.planlagt,
                        "status" to endretUndertema.status?.name,
                        "startDato" to endretUndertema.startDato?.toJavaLocalDate(),
                        "sluttDato" to endretUndertema.sluttDato?.toJavaLocalDate(),
                    ),
                ).asUpdate,
            )
        }
    }

    fun oppdaterUndertema(
        planId: UUID,
        temaId: Int,
        undertema: PlanUndertema,
    ) = using(sessionOf(dataSource)) { session ->
        // TODO oppdater Plan sist endret dato
        session.transaction { tx ->
            tx.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan_undertema SET 
                        planlagt = :planlagt,
                        status = :status,
                        start_dato = :startDato,
                        slutt_dato = :sluttDato
                    WHERE plan_id = :planId
                    AND tema_id = :temaId
                    AND undertema_id = :undertemaId
                    """.trimMargin(),
                    mapOf(
                        "planId" to planId.toString(),
                        "temaId" to temaId,
                        "undertemaId" to undertema.id,
                        "planlagt" to undertema.planlagt,
                        "status" to undertema.status?.name,
                        "startDato" to undertema.startDato?.toJavaLocalDate(),
                        "sluttDato" to undertema.sluttDato?.toJavaLocalDate(),
                    ),
                ).asUpdate,
            )
        }

        hentUndertema(planId = planId, temaId = temaId, session = session).firstOrNull { it.id == undertema.id }
    }
}
