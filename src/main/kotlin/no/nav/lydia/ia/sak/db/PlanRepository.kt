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
import no.nav.lydia.ia.sak.domene.plan.PlanRessurs
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
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
        mal: List<TemaMal> = hardkodetPlan,
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
            mal.forEach { tema ->
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

                    tema.undertema.forEach { undertema ->
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
                                    "navn" to undertema.navn,
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
                val navn = row.string("navn")
                PlanUndertema(
                    id = row.int("undertema_id"),
                    navn = navn,
                    målsetning = hardkodetPlan.hentUndertema(navn)?.målsetning ?: "",
                    beskrivelse = hardkodetPlan.hentUndertema(navn)?.beskrivelse ?: "",
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

    data class TemaMal(
        val navn: String,
        val undertema: List<UndertemaMal>,
    )

    data class UndertemaMal(
        val navn: String,
        val målsetning: String,
        val beskrivelse: String,
    )

    private fun List<TemaMal>.hentUndertema(navn: String) = this.flatMap { it.undertema }.firstOrNull { it.navn == navn }

    private val sykefraværsarbeid = TemaMal(
        navn = "Partssamarbeid",
        undertema = listOf(
            UndertemaMal(
                navn = "Sykefraværsrutiner",
                målsetning = "Jobbe systematisk og forebyggende med sykefravær, samt forbedre rutiner og oppfølging av ansatte som er sykmeldte eller står i fare for å bli det.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Oppfølgingssamtaler",
                målsetning = "Øke kompetansen for hvordan man gjennomfører gode oppfølgingssamtaler, både gjennom teori og praksis.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Tilretteleggings- og medvirkningsplikt",
                målsetning = "Utvikle kultur og rutiner for tilrettelegging og medvirkning, samt kartlegging av tilretteleggingsmuligheter på arbeidsplassen. ",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Sykefravær - enkeltsaker",
                målsetning = "Øke kompetansen for hvordan man tar tak i, følger opp og løser enkeltsaker. ",
                beskrivelse = "",
            ),
        ),
    )

    private val partssamarbeid = TemaMal(
        navn = "Partssamarbeid",
        undertema = listOf(
            UndertemaMal(
                navn = "Utvikle partssamarbeidet",
                målsetning = "Styrke samarbeidet mellom leder, tillitsvalgt og verneombud, samt øke kunnskap og ferdigheter for å jobbe systematisk og forebyggende med sykefravær og arbeidsmiljø.",
                beskrivelse = "",
            ),
        ),
    )

    private val arbeidsmiljø = TemaMal(
        navn = "Arbeidsmiljø",
        undertema = listOf(
            UndertemaMal(
                navn = "Utvikle arbeidsmiljøet",
                målsetning = "Kartlegge hvilke forhold ved arbeidsmiljøet som påvirker sykefravær og frafall, samt heve kompetansen for videreutvikling av arbeidsmiljøet.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Endring og omstilling",
                målsetning = "Forebygge fravær ved endringer og omstillingsprosesser og sette gode rammer for medvirkning, kommunikasjon og støtte til ansatte.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Oppfølging av arbeidsmiljøundersøkelser",
                målsetning = "Gi støtte til å identifisere og gjennomføre tiltak basert på behov og ressurser i virksomheten.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Livsfaseorientert personalpolitikk",
                målsetning = "Utvikle personalpolitikk som ivaretar medarbeideres ulike behov, krav, begrensninger og muligheter i  ulike livsfaser.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "Psykisk helse",
                målsetning = "Øke kompetansen om psykisk helse og hvordan møte medarbeidere som har psykiske helseproblemer.",
                beskrivelse = "",
            ),
            UndertemaMal(
                navn = "HelseIArbeid",
                målsetning = "Få ansatte til å mestre jobb, selv med muskel/skjelett- og psykiske helseplager",
                beskrivelse = "",
            ),
        ),
    )

    private val hardkodetPlan: List<TemaMal> = listOf(
        partssamarbeid,
        sykefraværsarbeid,
        arbeidsmiljø,
    )
}
