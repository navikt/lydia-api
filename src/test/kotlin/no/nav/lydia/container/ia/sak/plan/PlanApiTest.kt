package no.nav.lydia.container.ia.sak.plan

import io.kotest.assertions.shouldFail
import io.kotest.assertions.shouldFailWithMessage
import io.kotest.inspectors.forAll
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.equals.shouldBeEqual
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.DatePeriod
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.minus
import kotlinx.datetime.plus
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.sendKvittering
import no.nav.lydia.helper.PlanHelper.Companion.SLUTT_DATO
import no.nav.lydia.helper.PlanHelper.Companion.START_DATO
import no.nav.lydia.helper.PlanHelper.Companion.antallInnholdInkludert
import no.nav.lydia.helper.PlanHelper.Companion.antallInnholdMedStatus
import no.nav.lydia.helper.PlanHelper.Companion.antallTemaInkludert
import no.nav.lydia.helper.PlanHelper.Companion.endreEttTemaIPlan
import no.nav.lydia.helper.PlanHelper.Companion.endreFlereTemaerIPlan
import no.nav.lydia.helper.PlanHelper.Companion.endreStatusPåInnholdIPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAltInnhold
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgAltInnhold
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgEttInnhold
import no.nav.lydia.helper.PlanHelper.Companion.inkluderTemaOgAltInnhold
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.planleggOgFullførAlleUndertemaer
import no.nav.lydia.helper.PlanHelper.Companion.senesteSluttDato
import no.nav.lydia.helper.PlanHelper.Companion.slettPlanForSamarbeid
import no.nav.lydia.helper.PlanHelper.Companion.tidligstStartDato
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.domene.plan.InnholdMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.plan.TemaMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import java.time.LocalDate.now
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.util.UUID
import kotlin.test.Test

class PlanApiTest {
    @Test
    fun `skal kunne slette en tom plan`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(samarbeidId = samarbeid.id)
        val slettetPlan = sak.slettPlanForSamarbeid(samarbeidId = samarbeid.id)
        slettetPlan.status shouldBe IASamarbeid.Status.SLETTET

        shouldFailWithMessage("HTTP Exception 404 Not Found") {
            sak.hentPlan(prosessId = samarbeid.id)
        }
    }

    @Test
    fun `skal kunne opprette en ny plan etter at man har slettet en`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(samarbeidId = samarbeid.id)
        val slettetPlan = sak.slettPlanForSamarbeid(samarbeidId = samarbeid.id)
        val nyPlan = sak.opprettEnPlan(samarbeidId = samarbeid.id)
        val hentetPlan = sak.hentPlan(prosessId = samarbeid.id)
        hentetPlan.id shouldBe nyPlan.id
        hentetPlan.status shouldBe IASamarbeid.Status.AKTIV
        hentetPlan.id shouldNotBe slettetPlan.id
    }

    @Test
    fun `skal kunne slette plan dersom planen inneholder aktive temaer`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.opprettEnPlan(samarbeidId = samarbeid.id, plan = hentPlanMal().inkluderAlt())
        val slettetPlan = sak.slettPlanForSamarbeid(samarbeidId = samarbeid.id)
        slettetPlan.status shouldBe IASamarbeid.Status.SLETTET
        slettetPlan.temaer.forAll { tema ->
            tema.inkludert shouldBe false
            tema.undertemaer.forAll { undertema ->
                undertema.inkludert shouldBe false
            }
        }

        shouldFailWithMessage("HTTP Exception 404 Not Found") {
            sak.hentPlan(prosessId = samarbeid.id)
        }
    }

    @Test
    fun `skal ikke kunne fjerne undertemaer som har aktiviteter fra salesforce knyttet til seg`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())
        val førsteTema = plan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()
        førsteUndertema.inkludert shouldBe true

        val salesforceAktivitet = SalesforceAktivitetDto(
            Id__c = UUID.randomUUID().toString(),
            IACaseNumber__c = sak.saksnummer,
            IACooperationId__c = samarbeid.id.toString(),
            IAPlanId__c = plan.id,
            LastModifiedDate__c = ZonedDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME),
            EventType__c = "Created",
            TaskEvent__c = "Møte",
            Service__c = førsteTema.navn,
            IASubtheme__c = førsteUndertema.navn,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = salesforceAktivitet.Id__c,
            melding = Json.encodeToString(salesforceAktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        shouldFailWithMessage("HTTP Exception 409 Conflict") {
            sak.endreEttTemaIPlan(
                temaId = førsteTema.id,
                endring = førsteTema.undertemaer.map {
                    it.copy(
                        inkludert = false,
                        startDato = null,
                        sluttDato = null,
                    )
                }.tilRequest(),
                prosessId = samarbeid.id,
            )
        }
        applikasjon shouldContainLog "Endring av plan med id '${plan.id}' kan ikke gjennomføres, da det finnes aktiviteter i SF".toRegex()

        // -- Send slette melding om SF aktivitet
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = salesforceAktivitet.Id__c,
            melding = Json.encodeToString(salesforceAktivitet.copy(EventType__c = "Deleted")),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        val planEtterEndring = sak.endreEttTemaIPlan(
            temaId = førsteTema.id,
            endring = førsteTema.undertemaer.map {
                it.copy(
                    inkludert = false,
                    startDato = null,
                    sluttDato = null,
                )
            }.tilRequest(),
            prosessId = samarbeid.id,
        )
        planEtterEndring.temaer.first().undertemaer.forAll {
            it.inkludert shouldBe false
        }
    }

    @Test
    fun `kan ikke endre en plan om forespørselen er ufullstendig`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()
        val planDto = sak.opprettEnPlan(plan = enTomPlanMal)

        val inkludertUtenDato = planDto.copy(
            temaer = planDto.temaer.map { tema ->
                tema.copy(
                    inkludert = true,
                    undertemaer = tema.undertemaer.map { innhold ->
                        innhold.copy(
                            inkludert = true,
                            startDato = null,
                            sluttDato = null,
                        )
                    },
                )
            },
        )

        val datoUtenInkludert = planDto.copy(
            temaer = planDto.temaer.map { tema ->
                tema.copy(
                    inkludert = true,
                    undertemaer = tema.undertemaer.map { innhold ->
                        innhold.copy(
                            inkludert = false,
                            startDato = START_DATO,
                            sluttDato = SLUTT_DATO,
                        )
                    },
                )
            },
        )

        val gyldigEndring = planDto.inkluderTemaOgAltInnhold(planDto.temaer.first().id)

        shouldFail { sak.endreFlereTemaerIPlan(endring = datoUtenInkludert.tilRequest()) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        shouldFail { sak.endreFlereTemaerIPlan(endring = inkludertUtenDato.tilRequest()) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val uendretPlan = sak.hentPlan()
        uendretPlan.antallTemaInkludert() shouldBe 0
        uendretPlan.antallInnholdInkludert() shouldBe 0

        sak.endreFlereTemaerIPlan(endring = gyldigEndring.tilRequest())

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 1
        endretPlan.antallInnholdInkludert() shouldBe planDto.temaer.first().undertemaer.size

        shouldFail {
            sak.endreEttTemaIPlan(
                endring = datoUtenInkludert.temaer.first().undertemaer.tilRequest(),
                temaId = planDto.temaer.first().id,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        shouldFail {
            sak.endreEttTemaIPlan(
                endring = inkludertUtenDato.temaer.first().undertemaer.tilRequest(),
                temaId = planDto.temaer.first().id,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        val sammePlan = sak.hentPlan()
        sammePlan.antallTemaInkludert() shouldBe 1
        sammePlan.antallInnholdInkludert() shouldBe planDto.temaer.first().undertemaer.size
    }

    @Test
    fun `kan opprette en plan basert på mal`() {
        // TODO: Det skal vel egentlig ikke være mulig å opprette en tom plan?
        //  (hindret ved oppretting i frontend, men mulig å nullstille en plan ved endring)

        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal)

        plan.antallTemaInkludert() shouldBe 0
        plan.antallInnholdInkludert() shouldBe 0
        plan.publiseringStatus shouldBe null
    }

    @Test
    fun `kan opprette og publisere en plan, motta kvittering, hente plan og verifisere at tidspunkt og status er korrekt`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        val førPublisering = sak.hentPlan(prosessId = samarbeid.id)
        førPublisering.sistPublisert shouldBe null
        førPublisering.publiseringStatus shouldBe DokumentPubliseringDto.Status.IKKE_PUBLISERT
        førPublisering.harEndringerSidenSistPublisert shouldBe false

        val response = publiserDokument(
            dokumentReferanseId = plan.id,
            dokumentType = DokumentPubliseringDto.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Created.value
        val dokumentPubliseringDto = response.third.get()

        val etterSendtTilPublisering = sak.hentPlan(prosessId = samarbeid.id)
        etterSendtTilPublisering.sistPublisert shouldBe null
        etterSendtTilPublisering.publiseringStatus shouldBe DokumentPubliseringDto.Status.OPPRETTET
        etterSendtTilPublisering.harEndringerSidenSistPublisert shouldBe false

        sendKvittering(dokument = dokumentPubliseringDto, sak.hentAlleSamarbeid().first().id)

        val etterKvittering = sak.hentPlan(prosessId = samarbeid.id)
        etterKvittering.publiseringStatus shouldBe DokumentPubliseringDto.Status.PUBLISERT
        etterKvittering.sistPublisert shouldNotBe null
        etterKvittering.harEndringerSidenSistPublisert shouldBe false
    }

    @Test
    fun `skal informere dersom en plan har endringer siden sist publisering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        val response = publiserDokument(
            dokumentReferanseId = plan.id,
            dokumentType = DokumentPubliseringDto.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        )
        sendKvittering(response.third.get(), sak.hentAlleSamarbeid().first().id)
        sak.hentPlan().harEndringerSidenSistPublisert shouldBe false

        val planEtterEndring = plan.planleggOgFullførAlleUndertemaer(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
        )
        planEtterEndring.harEndringerSidenSistPublisert shouldBe true
    }

    @Test
    fun `kan opprette en ny plan med alt inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()

        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        plan.antallTemaInkludert() shouldBeEqual plan.temaer.size
        plan.antallInnholdInkludert() shouldBeEqual plan.temaer.sumOf { it.undertemaer.size }
        plan.id shouldBeEqual sak.hentPlan().id
    }

    @Test
    fun `kan endre status på innhold i plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        sak.endreStatusPåInnholdIPlan(
            temaId = plan.temaer.first().id,
            innholdId = plan.temaer.first().undertemaer.first().id,
            status = PlanUndertema.Status.FULLFØRT,
        )

        val endretPlan = sak.hentPlan()

        endretPlan.antallTemaInkludert() shouldBe plan.temaer.size
        endretPlan.antallInnholdInkludert() shouldBe plan.temaer.sumOf { it.undertemaer.size }
        endretPlan.antallInnholdMedStatus(status = PlanUndertema.Status.FULLFØRT) shouldBe 1
    }

    @Test
    fun `kan ikke endre status på innhold i plan om innhold ikke er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal)

        shouldFail {
            sak.endreStatusPåInnholdIPlan(
                temaId = plan.temaer.first().id,
                innholdId = plan.temaer.first().undertemaer.first().id,
                status = PlanUndertema.Status.FULLFØRT,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 0
        endretPlan.antallInnholdInkludert() shouldBe 0
        endretPlan.temaer.first().undertemaer.first().status shouldBe null
    }

    @Test
    fun `kan endre på innhold i et tema som er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMedEttTemaOgEttInnhold = hentPlanMal().inkluderEttTemaOgEttInnhold(
            temanummer = 3,
            innholdnummer = 1,
        )
        val planDto = sak.opprettEnPlan(plan = planMedEttTemaOgEttInnhold)
        val temaId = planDto.temaer.last().id
        val endring = planDto.inkluderTemaOgAltInnhold(temaId = temaId).tilRequest().last()

        sak.endreEttTemaIPlan(temaId = temaId, endring = endring.undertemaer)

        val endretPlan = sak.hentPlan()

        endretPlan.antallTemaInkludert() shouldBe 1
        endretPlan.antallInnholdInkludert() shouldBe planDto.temaer.last().undertemaer.size
    }

    @Test
    fun `kan ikke endre innhold i plan om det temaet ikke allerede er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()
        val plan = sak.opprettEnPlan(plan = enTomPlanMal)
        val førsteTema = plan.temaer.first()

        val endring = førsteTema.undertemaer.inkluderAltInnhold().tilRequest()

        shouldFail { sak.endreEttTemaIPlan(temaId = førsteTema.id, endring = endring) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 0
        endretPlan.antallInnholdInkludert() shouldBe 0
    }

    @Test
    fun `kan ikke endre på innhold i et tema som ikke er inkludert`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()
        val planDto = sak.opprettEnPlan(plan = enTomPlanMal)

        val endring = planDto.copy(
            temaer = planDto.temaer.map { tema ->
                tema.copy(
                    undertemaer = tema.undertemaer.inkluderAltInnhold(),
                )
            },
        )

        shouldFail { sak.endreEttTemaIPlan(temaId = endring.temaer.first().id, endring = endring.tilRequest().first().undertemaer) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 0
        endretPlan.antallInnholdInkludert() shouldBe 0
    }

    @Test
    fun `kan endre en tom plan til å inkludere alle tema og alle undertema`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val plan = sak.opprettEnPlan()

        sak.endreFlereTemaerIPlan(endring = plan.inkluderAlt().tilRequest())

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe plan.temaer.size
        endretPlan.antallInnholdInkludert() shouldBe plan.temaer.sumOf { it.undertemaer.size }
    }

    @Test
    fun `kan endre en plan med ett inkludert tema til å inkludere alt innhold i temaet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val planMalDto = hentPlanMal().inkluderEttTemaOgEttInnhold(temanummer = 3, innholdnummer = 1)
        val plan = sak.opprettEnPlan(plan = planMalDto)

        plan.antallTemaInkludert() shouldBe 1
        plan.antallInnholdInkludert() shouldBe 1

        sak.endreEttTemaIPlan(temaId = plan.temaer.last().id, endring = plan.inkluderAlt().tilRequest().last().undertemaer)

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 1
        endretPlan.antallInnholdInkludert() shouldBe plan.temaer.last().undertemaer.size
    }

    @Test
    fun `kan endre flere planer i flere samarbeid uten at de påvirker hverandre`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "Først")
            .opprettNyttSamarbeid(navn = "Sist")
        val enTomPlanMal = hentPlanMal()
        val planMalDto = enTomPlanMal.inkluderEttTemaOgEttInnhold(temanummer = 3, innholdnummer = 1)

        val alleSamarbeid = sak.hentAlleSamarbeid()

        val plan1 = sak.opprettEnPlan(plan = planMalDto, samarbeidId = alleSamarbeid.first().id)
        val plan2 = sak.opprettEnPlan(plan = enTomPlanMal, samarbeidId = alleSamarbeid.last().id)

        plan1.antallTemaInkludert() shouldBe 1
        plan1.antallInnholdInkludert() shouldBe 1

        plan2.antallTemaInkludert() shouldBe 0
        plan2.antallInnholdInkludert() shouldBe 0

        sak.endreEttTemaIPlan(
            temaId = plan1.temaer.last().id,
            endring = plan1.inkluderAlt().tilRequest().last().undertemaer,
            prosessId = alleSamarbeid.first().id,
        )

        sak.endreFlereTemaerIPlan(endring = plan2.inkluderAlt().tilRequest(), prosessId = alleSamarbeid.last().id)

        val endretPlan1 = sak.hentPlan(prosessId = alleSamarbeid.first().id)
        endretPlan1.antallTemaInkludert() shouldBe 1
        endretPlan1.antallInnholdInkludert() shouldBe plan1.temaer.last().undertemaer.size

        val endretPlan2 = sak.hentPlan(prosessId = alleSamarbeid.last().id)
        endretPlan2.antallTemaInkludert() shouldBe 3
        endretPlan2.antallInnholdInkludert() shouldBe plan2.temaer.sumOf { it.undertemaer.size }
    }

    @Test
    fun `endre status til avbrutt dersom undertema har startet eller er passert`() {
        val iDag = now().toKotlinLocalDate()
        val forEnMånedSiden = iDag.minus(6, DateTimeUnit.MONTH)
        val omEnMåned = iDag.plus(6, DateTimeUnit.MONTH)
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enNyPlan = PlanMalDto(
            tema = listOf(
                TemaMalDto(
                    rekkefølge = 1,
                    navn = "Et tema til test",
                    inkludert = true,
                    innhold = listOf(
                        InnholdMalDto(
                            rekkefølge = 1,
                            navn = "Et undertema til test",
                            inkludert = true,
                            startDato = forEnMånedSiden,
                            sluttDato = omEnMåned,
                        ),
                    ),
                ),
            ),
        )
        val planDto = sak.opprettEnPlan(plan = enNyPlan)
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()

        sak.endreStatusPåInnholdIPlan(temaId = førsteTema.id, innholdId = førsteUndertema.id, status = PlanUndertema.Status.AVBRUTT)

        val planMedNyStatus = sak.hentPlan()
        planMedNyStatus.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.AVBRUTT
        planMedNyStatus.temaer.first().undertemaer.first().sluttDato shouldBe omEnMåned
    }

    @Test
    fun `endre status til avbrutt endrer ikke sluttdato dersom undertemaet er i fortiden`() {
        val iDag = now().toKotlinLocalDate()
        val for6MånedereSiden = iDag.minus(6, DateTimeUnit.MONTH)
        val iGår = iDag.minus(1, DateTimeUnit.DAY)
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enNyPlan = PlanMalDto(
            tema = listOf(
                TemaMalDto(
                    rekkefølge = 1,
                    navn = "Et tema til test",
                    inkludert = true,
                    innhold = listOf(
                        InnholdMalDto(
                            rekkefølge = 1,
                            navn = "Et undertema til test",
                            inkludert = true,
                            startDato = for6MånedereSiden,
                            sluttDato = iGår,
                        ),
                    ),
                ),
            ),
        )

        val planDto = sak.opprettEnPlan(plan = enNyPlan)
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        førsteUndertema.status shouldBe PlanUndertema.Status.PLANLAGT
        førsteUndertema.sluttDato shouldBe iGår

        sak.endreStatusPåInnholdIPlan(temaId = førsteTema.id, innholdId = førsteUndertema.id, status = PlanUndertema.Status.AVBRUTT)

        val planMedNyStatus = sak.hentPlan()
        planMedNyStatus.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.AVBRUTT
        planMedNyStatus.temaer.first().undertemaer.first().sluttDato shouldBe iGår
    }

    @Test
    fun `det er ikke mulig å endre status til avbrutt dersom undertemaet er i fremtiden`() {
        val iDag = now().toKotlinLocalDate()
        val om6Måneder = iDag.plus(6, DateTimeUnit.MONTH)
        val iMorgen = iDag.plus(1, DateTimeUnit.DAY)
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enNyPlan = PlanMalDto(
            tema = listOf(
                TemaMalDto(
                    rekkefølge = 1,
                    navn = "Et tema til test",
                    inkludert = true,
                    innhold = listOf(
                        InnholdMalDto(
                            rekkefølge = 1,
                            navn = "Et undertema til test",
                            inkludert = true,
                            startDato = iMorgen,
                            sluttDato = om6Måneder,
                        ),
                    ),
                ),
            ),
        )

        val planDto = sak.opprettEnPlan(plan = enNyPlan)
        val førsteTema = planDto.temaer.first()
        val førsteUndertema = planDto.temaer.first().undertemaer.first()
        planDto.temaer.first().undertemaer.first().status shouldBe PlanUndertema.Status.PLANLAGT
        planDto.temaer.first().undertemaer.first().sluttDato shouldBe om6Måneder
        planDto.temaer.first().undertemaer.first().startDato shouldBe iMorgen

        shouldFail { sak.endreStatusPåInnholdIPlan(temaId = førsteTema.id, innholdId = førsteUndertema.id, status = PlanUndertema.Status.AVBRUTT) }
            .message shouldBe "HTTP Exception 400 Bad Request"
    }

    @Test
    fun `kan legge til nytt tema i plan uten uventet bieffekter`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlan = hentPlanMal()

        val opprettetPlan = sak.opprettEnPlan(plan = enTomPlan.inkluderEttTemaOgEttInnhold(2, 1))

        opprettetPlan.antallTemaInkludert() shouldBe 1
        opprettetPlan.antallInnholdInkludert() shouldBe 1
        opprettetPlan.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe 1

        val nyStatus = PlanUndertema.Status.PÅGÅR

        shouldFail {
            sak.endreStatusPåInnholdIPlan(
                temaId = opprettetPlan.temaer.first().id,
                innholdId = opprettetPlan.temaer.first().undertemaer.first().id,
                status = nyStatus,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        sak.endreStatusPåInnholdIPlan(
            temaId = opprettetPlan.temaer[1].id,
            innholdId = opprettetPlan.temaer[1].undertemaer.first().id,
            status = nyStatus,
        )

        val planMedNyStatus = sak.hentPlan()

        planMedNyStatus.antallTemaInkludert() shouldBe 1
        planMedNyStatus.antallInnholdInkludert() shouldBe 1
        planMedNyStatus.antallInnholdMedStatus(status = nyStatus) shouldBe 1

        sak.endreFlereTemaerIPlan(endring = planMedNyStatus.inkluderAlt().tilRequest())

        val planMedAltInnhold = sak.hentPlan()

        planMedAltInnhold.antallTemaInkludert() shouldBe 3
        planMedAltInnhold.antallInnholdInkludert() shouldBe opprettetPlan.temaer.sumOf { it.undertemaer.size }
        planMedAltInnhold.antallInnholdMedStatus(status = nyStatus) shouldBe 1
        planMedAltInnhold.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe opprettetPlan.temaer.sumOf { it.undertemaer.size } - 1
        planMedAltInnhold.antallInnholdMedStatus(status = PlanUndertema.Status.PÅGÅR) shouldBe 1
    }

    @Test
    fun `Kan ikke opprette eller endre en plan med sluttdato før startdato`() {
        // TODO: Kanskje litt vel lang test, dekkes noe av dette av andre tester?
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlan = hentPlanMal()

        val ugyldigPlan = enTomPlan.inkluderEttTemaOgAltInnhold(temanummer = 3, startDato = SLUTT_DATO, sluttDato = START_DATO)
        // sluttdato før start-dato

        val gyldigPlan = enTomPlan.inkluderEttTemaOgAltInnhold(temanummer = 3)

        shouldFail { sak.opprettEnPlan(plan = ugyldigPlan) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val opprettetPlan = sak.opprettEnPlan(plan = gyldigPlan)
        val sisteTema = opprettetPlan.temaer.last()
        val førsteTema = opprettetPlan.temaer.first()

        opprettetPlan.antallTemaInkludert() shouldBe 1
        opprettetPlan.antallInnholdInkludert() shouldBe gyldigPlan.tema.last().innhold.size
        opprettetPlan.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe gyldigPlan.tema.last().innhold.size
        opprettetPlan.tidligstStartDato() shouldBe START_DATO
        opprettetPlan.senesteSluttDato() shouldBe SLUTT_DATO
        // det siste temaet er inkludert

        val ugyldigEndring = opprettetPlan.inkluderTemaOgAltInnhold(
            temaId = opprettetPlan.temaer[0].id,
            startDato = SLUTT_DATO,
            sluttDato = START_DATO,
        )

        val gyldigEndring = opprettetPlan.inkluderTemaOgAltInnhold(
            temaId = opprettetPlan.temaer[0].id,
            startDato = START_DATO,
            sluttDato = SLUTT_DATO,
        )

        shouldFail { sak.endreFlereTemaerIPlan(endring = ugyldigEndring.tilRequest()) }
            .message shouldBe "HTTP Exception 400 Bad Request"

        val uendretPlan = sak.hentPlan()

        uendretPlan.antallTemaInkludert() shouldBe 1
        uendretPlan.antallInnholdInkludert() shouldBe sisteTema.undertemaer.size
        uendretPlan.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe sisteTema.undertemaer.size
        uendretPlan.tidligstStartDato() shouldBe START_DATO
        uendretPlan.senesteSluttDato() shouldBe SLUTT_DATO
        // det siste temaet er inkludert samme som opprettetPlan

        sak.endreFlereTemaerIPlan(endring = gyldigEndring.tilRequest())

        val endretPlan = sak.hentPlan()
        endretPlan.antallTemaInkludert() shouldBe 2
        endretPlan.antallInnholdInkludert() shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan.tidligstStartDato() shouldBe START_DATO
        endretPlan.senesteSluttDato() shouldBe SLUTT_DATO
        // det første og siste temaet er inkludert

        val nyUgyldigEndring = endretPlan.inkluderTemaOgAltInnhold(
            temaId = endretPlan.temaer.last().id,
            startDato = SLUTT_DATO.plus(DatePeriod(years = 1)),
            sluttDato = START_DATO.plus(DatePeriod(years = 1)),
        ) // setter alle innhold til feil dato

        val nyGyldigEndring = endretPlan.inkluderTemaOgAltInnhold(
            temaId = endretPlan.temaer.last().id,
            startDato = START_DATO.plus(DatePeriod(years = 1)),
            sluttDato = SLUTT_DATO.plus(DatePeriod(years = 1)),
        ) // setter alle innhold til ny rett dato

        shouldFail {
            sak.endreEttTemaIPlan(
                endring = nyUgyldigEndring.tilRequest().last().undertemaer,
                temaId = nyUgyldigEndring.temaer.last().id,
            )
        }.message shouldBe "HTTP Exception 400 Bad Request"

        sak.endreEttTemaIPlan(
            endring = nyGyldigEndring.tilRequest().last().undertemaer,
            temaId = nyGyldigEndring.temaer.last().id,
        )

        val endretPlan2 = sak.hentPlan()

        endretPlan2.antallTemaInkludert() shouldBe 2
        endretPlan2.antallInnholdInkludert() shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan2.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe førsteTema.undertemaer.size + sisteTema.undertemaer.size
        endretPlan2.tidligstStartDato() shouldBe START_DATO
        endretPlan2.senesteSluttDato() shouldBe SLUTT_DATO.plus(DatePeriod(years = 1))
        // Alle temaer og alt innhold er inkludert, seneste sluttdato

        // datoer er endret
    }

    @Test
    fun `skal få feil når man henter plan uten å ha opprettet en plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        shouldFail { sak.hentPlan() }.message shouldBe "HTTP Exception 404 Not Found"
    }

    @Test
    fun `følgere av sak som er saksbehandlere skal kunne opprette en plan`() {
        val sak = nySakIViBistår(token = authContainerHelper.saksbehandler1.token)
        sak.leggTilFolger(token = authContainerHelper.saksbehandler2.token)

        val plan = sak.opprettEnPlan(token = authContainerHelper.saksbehandler2.token)
        plan.status shouldBe IASamarbeid.Status.AKTIV
    }

    @Test
    fun `følgere av sak som er lesebrukere skal IKKE kunne opprette en plan`() {
        val sak = nySakIViBistår(token = authContainerHelper.saksbehandler1.token)
        sak.leggTilFolger(token = authContainerHelper.lesebruker.token)
        shouldFail {
            sak.opprettEnPlan(token = authContainerHelper.lesebruker.token)
        }
    }

    @Test
    fun `saksbehandlere som ikke er eier eller følger av sak skal IKKE kunne opprette en plan`() {
        val sak = nySakIViBistår(token = authContainerHelper.saksbehandler1.token)
        shouldFail {
            sak.opprettEnPlan(token = authContainerHelper.saksbehandler2.token)
        }
    }

    @Test
    fun `følgere av sak som er saksbehandlere skal kunne slette plan`() {
        val eierAvSak = authContainerHelper.saksbehandler1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = nySakIViBistår(token = eierAvSak.token)
        val samarbeid = sak.hentAlleSamarbeid().first()
        sak.leggTilFolger(token = følgerAvSak.token)

        val plan = sak.opprettEnPlan(token = følgerAvSak.token)
        plan.status shouldBe IASamarbeid.Status.AKTIV

        val slettetPlan = sak.slettPlanForSamarbeid(token = følgerAvSak.token, samarbeidId = sak.hentAlleSamarbeid().first().id)
        slettetPlan.status shouldBe IASamarbeid.Status.SLETTET

        shouldFailWithMessage("HTTP Exception 404 Not Found") {
            sak.hentPlan(token = følgerAvSak.token, prosessId = samarbeid.id)
        }
    }

    @Test
    fun `følgere av sak som er saksbehandlere skal kunne endre status på innhold i plan`() {
        val eierAvSak = authContainerHelper.saksbehandler1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = nySakIViBistår(token = eierAvSak.token)
        sak.leggTilFolger(token = følgerAvSak.token)

        val plan = sak.opprettEnPlan(
            token = følgerAvSak.token,
            plan = hentPlanMal().inkluderEttTemaOgEttInnhold(
                temanummer = 1,
                innholdnummer = 1,
            ),
        )
        plan.antallInnholdMedStatus(status = PlanUndertema.Status.PLANLAGT) shouldBe 1

        val tema = plan.temaer.first()
        val innhold = tema.undertemaer.first()

        val endretPlan = sak.endreStatusPåInnholdIPlan(
            token = følgerAvSak.token,
            temaId = tema.id,
            innholdId = innhold.id,
            status = PlanUndertema.Status.FULLFØRT,
        )
        endretPlan.temaer.flatMap { it.undertemaer }.forExactlyOne { undertema ->
            undertema.status shouldBe PlanUndertema.Status.FULLFØRT
        }
    }

    @Test
    fun `følgere av sak som er saksbehandlere skal kunne redigere tema i plan`() {
        val eierAvSak = authContainerHelper.saksbehandler1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = nySakIViBistår(token = eierAvSak.token)
        sak.leggTilFolger(token = følgerAvSak.token)

        val plan = sak.opprettEnPlan(
            token = følgerAvSak.token,
            plan = hentPlanMal().inkluderEttTemaOgEttInnhold(
                temanummer = 1,
                innholdnummer = 1,
            ),
        )

        val temaDto = plan.temaer.first()
        val innholdDto = temaDto.undertemaer.first()
        innholdDto.sluttDato shouldBe SLUTT_DATO

        val nySluttdato = SLUTT_DATO.plus(1, DateTimeUnit.YEAR)
        val endretPlan = sak.endreEttTemaIPlan(
            token = følgerAvSak.token,
            temaId = temaDto.id,
            endring = listOf(
                innholdDto.copy(
                    sluttDato = SLUTT_DATO.plus(1, DateTimeUnit.YEAR),
                ),
            ).tilRequest(),
        )

        endretPlan.temaer.flatMap { it.undertemaer }.forExactlyOne { undertema ->
            undertema.sluttDato shouldBe nySluttdato
        }
    }

    @Test
    fun `følgere av sak som er saksbehandlere skal kunne redigere plan`() {
        val eierAvSak = authContainerHelper.saksbehandler1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = nySakIViBistår(token = eierAvSak.token)
        val planMal = hentPlanMal().inkluderEttTemaOgEttInnhold(
            temanummer = 3,
            innholdnummer = 1,
        )
        sak.leggTilFolger(token = følgerAvSak.token)
        val plan = sak.opprettEnPlan(token = følgerAvSak.token, plan = planMal)
        plan.antallTemaInkludert() shouldBe 1

        val planMedAltInkludert = plan.inkluderAlt()
        sak.endreFlereTemaerIPlan(
            token = følgerAvSak.token,
            endring = planMedAltInkludert.tilRequest(),
            prosessId = sak.hentAlleSamarbeid().first().id,
        )

        val endretPlan = sak.hentPlan(token = følgerAvSak.token)
        endretPlan.antallTemaInkludert() shouldBe planMedAltInkludert.temaer.size
    }

    @Test
    fun `skal kunne hente plan uten å være eier som lesebruker`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val opprettetPlan = sak.opprettEnPlan()

        val hentetPlan = sak.hentPlan(token = authContainerHelper.lesebruker.token)

        opprettetPlan.id shouldBeEqual hentetPlan.id
    }

    @Test
    fun `skal kunne hente plan-mal som eier`() {
        val planMal = hentPlanMal()

        planMal.tema.size shouldBe 3
        planMal.tema.first().navn shouldBe "Partssamarbeid"
    }

    @Test
    fun `Skal oppdatere sist endret dato ved endring av plan`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val enTomPlanMal = hentPlanMal()

        val opprettetPlan = sak.opprettEnPlan(plan = enTomPlanMal.inkluderAlt())

        val førsteTema = opprettetPlan.temaer.first()
        val førsteUndertema = førsteTema.undertemaer.first()

        sak.endreStatusPåInnholdIPlan(
            temaId = førsteTema.id,
            innholdId = førsteUndertema.id,
            status = PlanUndertema.Status.PÅGÅR,
        )

        sak.hentPlan().sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
    }
}
