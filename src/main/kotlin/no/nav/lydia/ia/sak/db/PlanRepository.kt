package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import java.util.*
import javax.sql.DataSource
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.getHardkodetPlan
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt


class PlanRepository(val dataSource: DataSource) {
    fun opprettPlan(
        planId: UUID,
        prosessId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Plan> {
//        TODO: Lagre plan på prosess
//        using(sessionOf(dataSource)) { session ->
//            session.transaction { tx ->
//                tx.run(
//                    queryOf(
//                        """
//                            INSERT INTO ia_sak_plan (
//                                plan_id,
//                                ia_prosess,
//                                opprettet_av
//                            )
//                            VALUES (
//                                :plan_id,
//                                :prosess_id,
//                                :opprettet_av
//                            )
//                        """.trimMargin(),
//                        mapOf(
//                            "plan_id" to planId,
//                            "prosess_id" to prosessId,
//                            "opprettet_av" to saksbehandler.navIdent
//                        )
//                    ).asUpdate
//                )
//            }
//        }

        return hentPlan(planId = planId)?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette plan",
                httpStatusCode = HttpStatusCode.InternalServerError
            ).left()
    }

    fun hentPlan(planId: UUID): Plan? {
//        TODO: Les plan fra database
//        using(sessionOf(dataSource)) { session ->
//            session.run(
//                queryOf(
//                    """
//                        SELECT *
//                        FROM ia_sak_plan
//                        WHERE plan_id = :planId
//                    """.trimMargin(),
//                    mapOf(
//                        "planId" to planId,
//                    )
//                ).map { row ->
//                    Plan(
//                        id = UUID.fromString(row.string("plan_id")),
//                        temaer = emptyList(),
//                        publisert = row.boolean("publisert"),
//                        sistEndret = row.localDate("sist_endret").toKotlinLocalDate(),
//                        sistPublisert = row.localDate("sist_publisert").toKotlinLocalDate(),
//                    )
//                }.asSingle
//            )
//        }

        return getHardkodetPlan()
    }
}
