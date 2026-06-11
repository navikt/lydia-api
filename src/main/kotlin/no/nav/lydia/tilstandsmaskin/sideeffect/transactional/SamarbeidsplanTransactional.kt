package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.mapTilSalesforceAktivitet
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeidsplan.EndreTemaRequest
import no.nav.lydia.samarbeidsplan.EndreUndertemaRequest
import no.nav.lydia.samarbeidsplan.Plan
import no.nav.lydia.samarbeidsplan.PlanDto
import no.nav.lydia.samarbeidsplan.PlanMalDto
import no.nav.lydia.samarbeidsplan.PlanTema
import no.nav.lydia.samarbeidsplan.PlanTemaDto
import no.nav.lydia.samarbeidsplan.PlanUndertema
import no.nav.lydia.samarbeidsplan.PlanUndertemaDto
import no.nav.lydia.samarbeidsplan.hentInnholdsMålsetning
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.util.UUID
import kotlin.collections.forEach

class SamarbeidsplanTransactional {
    companion object {
        context(tx: TransactionalSession)
        fun opprettSamarbeidsplan(
            planId: UUID,
            samarbeidId: Int,
            saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
            mal: PlanMalDto,
        ): Plan? {
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
                        "ia_prosess" to samarbeidId,
                        "opprettet_av" to saksbehandler.navIdent,
                    ),
                ).asUpdate,
            )
            mal.tema.forEach { tema ->
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
            return hentPlan(samarbeidId = samarbeidId, tx = tx)
        }

        context(tx: TransactionalSession)
        fun oppdaterSamarbeidsplan(
            planDto: PlanDto,
            samarbeidId: Int,
            endringer: List<EndreTemaRequest>,
        ): Plan? {
            endringer.forEach { endreTemaRequest ->
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak_plan_tema SET 
                            inkludert = :inkludert
                        WHERE tema_id = :temaId
                        """.trimMargin(),
                        mapOf(
                            "temaId" to endreTemaRequest.id,
                            "inkludert" to endreTemaRequest.inkludert,
                        ),
                    ).asUpdate,
                ) // oppdater status på tema ^ (arvet teknisk gjeld fra PlanRepository)

                oppdaterTema(
                    tema = planDto.temaer.first { it.id == endreTemaRequest.id },
                    nyttInnholdListe = endreTemaRequest.undertemaer,
                    tx = tx,
                )
                // oppdater status på undertemaene ^ (arvet teknisk gjeld fra PlanRepository)
            }

            return hentPlan(samarbeidId = samarbeidId, tx = tx)
        }

        context(tx: TransactionalSession)
        fun oppdaterTemaISamarbeidsplan(
            planDto: PlanDto,
            samarbeidId: Int,
            endringer: List<EndreUndertemaRequest>,
            temaId: Int,
        ): Plan? {
            oppdaterTema(
                tema = planDto.temaer.first { it.id == temaId },
                nyttInnholdListe = endringer,
                tx = tx,
            )

            return hentPlan(samarbeidId = samarbeidId, tx = tx)
        }

        private fun oppdaterTema(
            tema: PlanTemaDto,
            nyttInnholdListe: List<EndreUndertemaRequest>,
            tx: TransactionalSession,
        ) {
            val innholdSomSkalEndres: List<PlanUndertemaDto> =
                tema.undertemaer.map { undertemaDto: PlanUndertemaDto ->
                    if (nyttInnholdListe.map { it.id }.contains(undertemaDto.id)) {
                        undertemaDto.endreInnhold(nyttInnholdListe.first { it.id == undertemaDto.id })
                    } else {
                        undertemaDto
                    }
                }

            innholdSomSkalEndres.forEach { innhold ->
                oppdaterUndertema(temaId = tema.id, undertema = innhold, tx = tx)
            }
        }

        private fun oppdaterUndertema(
            temaId: Int,
            undertema: PlanUndertemaDto,
            tx: TransactionalSession,
        ) {
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

        context(tx: TransactionalSession)
        fun endreStatusPåUndertemaISamarbeidsplan(
            samarbeidId: Int,
            temaId: Int,
            undertemaId: Int,
            nyStatus: PlanUndertema.Status,
        ): Plan? {
            tx.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan_undertema SET
                        status = :status
                    WHERE tema_id = :temaId
                    AND undertema_id = :undertemaId
                    """.trimIndent(),
                    mapOf(
                        "temaId" to temaId,
                        "undertemaId" to undertemaId,
                        "status" to nyStatus.name,
                    ),
                ).asUpdate,
            )
            return hentPlan(samarbeidId = samarbeidId, tx = tx)
        }

        context(tx: TransactionalSession)
        fun settPlanTilFullført(plan: Plan) {
            plan.temaer.forEach { tema ->
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak_plan_undertema
                        SET status = :statusFullfort
                        WHERE status != :statusAvbrutt
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
                    SET status = :statusFullfort
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf(
                        "statusFullfort" to IASamarbeid.Status.FULLFØRT.name,
                        "planId" to plan.id.toString(),
                    ),
                ).asUpdate,
            )
        }

        context(tx: TransactionalSession)
        fun settPlanTilSlettet(planId: UUID): Plan {
            tx.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan
                    SET status = :statusSlettet
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf(
                        "statusSlettet" to IASamarbeid.Status.SLETTET.name,
                        "planId" to planId.toString(),
                    ),
                ).asUpdate,
            )
            tx.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan_undertema
                    SET inkludert = false, start_dato = null, slutt_dato = null
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf("planId" to planId.toString()),
                ).asUpdate,
            )
            tx.run(
                queryOf(
                    """
                    UPDATE ia_sak_plan_tema
                    SET inkludert = false
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf("planId" to planId.toString()),
                ).asUpdate,
            )
            return hentPlanById(planId = planId, tx = tx)
                ?: error("Fant ikke plan med id $planId etter sletting")
        }

        context(tx: TransactionalSession)
        fun hentPlan(samarbeidId: Int) = hentPlan(samarbeidId, tx)

        private fun hentPlanById(
            planId: UUID,
            tx: TransactionalSession,
        ): Plan? =
            tx.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak_plan
                    WHERE plan_id = :planId
                    """.trimIndent(),
                    mapOf(
                        "planId" to planId.toString(),
                    ),
                ).map { tilPlan(row = it, tx = tx) }.asSingle,
            )

        private fun hentPlan(
            samarbeidId: Int,
            tx: TransactionalSession,
        ): Plan? =
            tx.run(
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
                ).map { tilPlan(row = it, tx = tx) }.asSingle,
            )

        private fun tilPlan(
            row: Row,
            tx: TransactionalSession,
        ): Plan {
            val planIdLestFraDB = UUID.fromString(row.string("plan_id"))
            return Plan(
                id = planIdLestFraDB,
                samarbeidId = row.int("ia_prosess"),
                sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
                status = IASamarbeid.Status.valueOf(row.string("status")),
                temaer = hentTema(planIdLestFraDB, tx = tx),
            )
        }

        private fun hentTema(
            planId: UUID,
            tx: TransactionalSession,
        ): List<PlanTema> =
            tx.run(
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
                        undertemaer = hentUndertema(temaId, tx),
                    )
                }.asList,
            )

        private fun hentUndertema(
            temaId: Int,
            tx: TransactionalSession,
        ): List<PlanUndertema> =
            tx.run(
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
                            tx = tx,
                        ),
                    )
                }.asList,
            )

        private fun PlanUndertemaDto.endreInnhold(nyttInnhold: EndreUndertemaRequest) =
            this.copy(
                inkludert = nyttInnhold.inkludert,
                status = if (nyttInnhold.inkludert) this.status ?: PlanUndertema.Status.PLANLAGT else null,
                startDato = if (nyttInnhold.inkludert) nyttInnhold.startDato else null,
                sluttDato = if (nyttInnhold.inkludert) nyttInnhold.sluttDato else null,
            )

        private fun hentAktiviterISalesforce(
            planId: String,
            undertemaId: Int,
            tx: TransactionalSession,
        ) = tx.run(
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
}
