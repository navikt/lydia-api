package no.nav.lydia.container.ny.flyt

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import ia.felles.definisjoner.bransjer.Bransje
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAll
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.Clock
import kotlinx.datetime.DateTimeUnit
import kotlinx.datetime.LocalDate
import kotlinx.datetime.TimeZone
import kotlinx.datetime.plus
import kotlinx.datetime.todayIn
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraKvartal
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraSiste4Kvartaler
import no.nav.lydia.container.ia.eksport.SamarbeidsplanBigqueryEksportererTest.Companion.inkludertInnhold
import no.nav.lydia.container.ia.eksport.SamarbeidsplanBigqueryEksportererTest.Companion.inkluderteTemaer
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanResponse
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.bliEier
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.performPut
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.eksport.SamarbeidBigqueryProdusent.SamarbeidValue
import no.nav.lydia.ia.eksport.SamarbeidDto
import no.nav.lydia.ia.eksport.SamarbeidProdusent.SamarbeidKafkaMeldingValue
import no.nav.lydia.ia.eksport.SamarbeidsplanBigqueryProdusent.InnholdIPlanMelding
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_API_PATH
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandDto
import no.nav.lydia.ia.sak.api.plan.EndreTemaRequest
import no.nav.lydia.ia.sak.api.plan.EndreUndertemaRequest
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.virksomhet.api.VirksomhetDto
import org.apache.kafka.clients.consumer.KafkaConsumer
import kotlin.test.fail

class NyFlytTestUtils {
    companion object {
        private val iaSakTopic = Topic.IA_SAK_TOPIC
        private val iaSakStatistikkTopic = Topic.IA_SAK_STATISTIKK_TOPIC
        private val samarbeidsplanTopic = Topic.SAMARBEIDSPLAN_TOPIC
        private val samarbeidBigqueryTopic = Topic.SAMARBEID_BIGQUERY_TOPIC
        private val samarbeidsplanBigqueryTopic = Topic.SAMARBEIDSPLAN_BIGQUERY_TOPIC
        private lateinit var iaSakKonsument: KafkaConsumer<String, String>
        private lateinit var iaSakStatistikkKonsument: KafkaConsumer<String, String>
        private lateinit var samarbeidsplanKonsument: KafkaConsumer<String, String>
        private lateinit var samarbeidBigqueryKonsument: KafkaConsumer<String, String>
        private lateinit var samarbeidsplanBigqueryKonsument: KafkaConsumer<String, String>

        fun setUpKonsumenter() {
            iaSakKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakTopic)
            iaSakStatistikkKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakStatistikkTopic)
            samarbeidsplanKonsument = kafkaContainerHelper.nyKonsument(topic = samarbeidsplanTopic)
            samarbeidBigqueryKonsument = kafkaContainerHelper.nyKonsument(topic = samarbeidBigqueryTopic)
            samarbeidsplanBigqueryKonsument = kafkaContainerHelper.nyKonsument(topic = samarbeidsplanBigqueryTopic)

            iaSakKonsument.subscribe(mutableListOf(iaSakTopic.navn))
            iaSakStatistikkKonsument.subscribe(mutableListOf(iaSakStatistikkTopic.navn))
            samarbeidsplanKonsument.subscribe(mutableListOf(samarbeidsplanTopic.navn))
            samarbeidBigqueryKonsument.subscribe(mutableListOf(samarbeidBigqueryTopic.navn))
            samarbeidsplanBigqueryKonsument.subscribe(mutableListOf(samarbeidsplanBigqueryTopic.navn))
        }

        fun tearDownKonsumenter() {
            iaSakKonsument.unsubscribe()
            iaSakKonsument.close()

            iaSakStatistikkKonsument.unsubscribe()
            iaSakStatistikkKonsument.close()

            samarbeidsplanKonsument.unsubscribe()
            samarbeidsplanKonsument.close()

            samarbeidBigqueryKonsument.unsubscribe()
            samarbeidBigqueryKonsument.close()
        }

        // Verifisering
        fun hentVirksomhet(
            orgnr: String,
            token: String = authContainerHelper.superbruker1.token,
        ): VirksomhetDto {
            val url = "$NY_FLYT_PATH/virksomhet/$orgnr"
            return applikasjon.performGet(url)
                .authentication().bearer(token).tilSingelRespons<VirksomhetDto>().third.get()
        }

        fun hentVirksomhetTilstand(
            orgnr: String,
            token: String = authContainerHelper.superbruker1.token,
        ): VirksomhetTilstandDto {
            val url = "$NY_FLYT_PATH/$orgnr/tilstand"
            return applikasjon.performGet(url)
                .authentication().bearer(token).tilSingelRespons<VirksomhetTilstandDto>().third.get()
        }

        fun verifiserKafkaPlanObserversErVarslet(
            iASakDto: IASakDto,
            iASamarbeidDto: IASamarbeidDto,
            plan: PlanMedPubliseringStatusDto,
        ) {
            runBlocking {
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = plan.id,
                    konsument = samarbeidsplanBigqueryKonsument,
                ) { meldinger ->
                    meldinger shouldHaveAtLeastSize 1
                    val planer = meldinger.map { Json.decodeFromString<List<InnholdIPlanMelding>>(it) }
                    val sistePlan = planer.last()
                    sistePlan.shouldForAll { it.planId shouldBe plan.id }
                    sistePlan.inkluderteTemaer() shouldBe plan.temaer.size
                    sistePlan.inkludertInnhold() shouldBe plan.temaer.sumOf { it.undertemaer.size }
                }
            }
            runBlocking {
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = "${iASakDto.saksnummer}-${iASamarbeidDto.id}-${plan.id}",
                    konsument = samarbeidsplanKonsument,
                ) { meldinger ->
                    meldinger.forAtLeastOne { melding ->
                        val samarbeidsplanProdusentTestSentTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                        samarbeidsplanProdusentTestSentTilSalesforce.plan.id shouldBe plan.id
                        samarbeidsplanProdusentTestSentTilSalesforce.samarbeid.id shouldBe iASamarbeidDto.id
                        samarbeidsplanProdusentTestSentTilSalesforce.samarbeid.navn shouldBe iASamarbeidDto.navn
                        samarbeidsplanProdusentTestSentTilSalesforce.plan shouldNotBe null
                    }
                }
            }
        }

        fun verifiserSamarbeidObserversErVarslet(
            iASakDto: IASakDto,
            iaSamarbeidDto: IASamarbeidDto,
            samarbeidsnavn: String,
            forventetSamarbeidStatus: IASamarbeid.Status,
        ) {
            runBlocking {
                // Samarbeid salesforce observer
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger("${iASakDto.saksnummer}-${iaSamarbeidDto.id}", samarbeidsplanKonsument) { meldinger ->
                    val samarbeidKafka = meldinger.map { Json.decodeFromString<SamarbeidKafkaMeldingValue>(it) }
                    samarbeidKafka.forExactlyOne {
                        it.samarbeid.id shouldBe iaSamarbeidDto.id
                        it.samarbeid.navn shouldBe samarbeidsnavn
                        it.samarbeid.status shouldBe forventetSamarbeidStatus
                    }
                }

                // Samarbeid big query observer
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(iASakDto.saksnummer, samarbeidBigqueryKonsument) { meldinger ->
                    val samarbeidKafka = meldinger.map { Json.decodeFromString<SamarbeidValue>(it) }
                    samarbeidKafka.forExactlyOne {
                        it.id shouldBe iaSamarbeidDto.id
                        it.navn shouldBe samarbeidsnavn
                        it.status shouldBe forventetSamarbeidStatus.name
                    }
                }
            }
        }

        fun verifiserIASakObserversErVarslet(
            iASakDto: IASakDto,
            forventedeIASakStatuser: List<IASak.Status>,
            forventetIASakStatusIStatistikk: IASak.Status,
            rolle: Rolle,
            hendelseType: IASakshendelseType? = null,
            begrunnelser: List<BegrunnelseType>? = null,
        ) {
            runBlocking {
                // Sak observer - IASakProdusent
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = iASakDto.saksnummer, konsument = iaSakKonsument) { meldinger ->
                    meldinger.forAll { hendelse ->
                        hendelse shouldContain iASakDto.saksnummer
                        hendelse shouldContain iASakDto.orgnr
                    }
                    forventedeIASakStatuser.forEach { status ->
                        meldinger.forAtLeastOne { melding -> melding.contains(status.name) }
                    }
                }
                // IASakStatistikkProdusent
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = iASakDto.saksnummer,
                    konsument = iaSakStatistikkKonsument,
                ) { meldinger ->
                    val objektene = meldinger.map {
                        Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                    }
                    objektene.forExactlyOne {
                        it.orgnr shouldBe iASakDto.orgnr
                        it.saksnummer shouldBe iASakDto.saksnummer
                        it.eierAvSak shouldBe null
                        it.status shouldBe forventetIASakStatusIStatistikk
                        if (hendelseType != null) it.hendelse shouldBe IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
                        if (begrunnelser != null) {
                            it.ikkeAktuelBegrunnelse shouldBe
                                "[${begrunnelser.joinToString { begrunnelse -> begrunnelse.name }}]"
                        }
                        it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                        it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                        it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                        it.bransjeprogram shouldBe Bransje.ANLEGG
                        it.endretAvRolle shouldBe rolle
                        it.enhetsnummer shouldBe "2900"
                        it.enhetsnavn shouldBe "IT-avdelingen" // -- Bør ha fallback til minst spesifikk avdeling
                    }
                }
            }
        }

        // Test-case utils
        fun vurderVirksomhetResponse(
            virksomhet: TestVirksomhet = lastInnNyVirksomhet(),
            token: String = authContainerHelper.superbruker1.token,
        ) = applikasjon.performPost("$NY_FLYT_PATH/${virksomhet.orgnr}/vurder")
            .authentication().bearer(token)
            .tilSingelRespons<IASakDto>()

        fun vurderVirksomhet(
            virksomhet: TestVirksomhet = lastInnNyVirksomhet(),
            token: String = authContainerHelper.superbruker1.token,
        ) = vurderVirksomhetResponse(virksomhet = virksomhet, token = token).third.fold(
            success = { it },
            failure = { fail(it.message) },
        )

        fun IASakDto.angreVurdering(token: String = authContainerHelper.superbruker1.token) =
            applikasjon.performPost("$NY_FLYT_PATH/$orgnr/angre-vurdering")
                .authentication().bearer(token)
                .tilSingelRespons<IASakDto>().third.fold(
                    success = { it },
                    failure = { fail(it.message) },
                )

        fun aktivSamarbeidsperiode(
            virksomhet: TestVirksomhet = lastInnNyVirksomhet(),
            samarbeidsnavn: String = "Samarbeid med ${virksomhet.orgnr}",
            token: String = authContainerHelper.superbruker1.token,
            følgerToken: String? = authContainerHelper.saksbehandler1.token,
        ): IASakDto {
            vurderVirksomhet(virksomhet = virksomhet)
                .bliEier(token = token).also { sak -> følgerToken?.let { sak.leggTilFolger(it) } }
                .opprettSamarbeid(token = token, samarbeidsnavn = samarbeidsnavn)

            return SakHelper.hentSak(orgnummer = virksomhet.orgnr, token = token)
        }

        fun IASakDto.fullførSamarbeidsperiode(token: String = authContainerHelper.superbruker1.token): IASakDto {
            this.hentAlleSamarbeid(token = token).forEach { samarbeid ->
                // Dersom det ikke finnes en plan, så må vi opprette en, slik at man kan avslutte samarbeidet
                if (hentPlanResponse().statuskode() == 404) {
                    samarbeid.opprettSamarbeidsplan(orgnr)
                }
                samarbeid.avsluttSamarbeid(this.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT, token = token)
            }
            return SakHelper.hentSak(orgnummer = this.orgnr, token = token)
        }

        fun TestVirksomhet.opprettOgFullførSamarbeidsperiode(token: String = authContainerHelper.superbruker1.token): IASakDto {
            aktivSamarbeidsperiode(virksomhet = this, token = token).fullførSamarbeidsperiode(token = token)
            return SakHelper.hentSak(orgnummer = this.orgnr, token = token)
        }

        fun IASakDto.avsluttVurderingResponse(
            token: String = authContainerHelper.superbruker1.token,
            valgtÅrsak: ValgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = Clock.System.todayIn(TimeZone.currentSystemDefault()).plus(90, DateTimeUnit.DAY),
            ),
        ) = applikasjon.performPost("$NY_FLYT_API_PATH/virksomhet/$orgnr/avslutt-vurdering")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(valgtÅrsak),
            )
            .tilSingelRespons<IASakDto>()

        fun IASakDto.avsluttVurdering(
            token: String = authContainerHelper.superbruker1.token,
            valgtÅrsak: ValgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = Clock.System.todayIn(TimeZone.currentSystemDefault()).plus(90, DateTimeUnit.DAY),
            ),
        ) = this.avsluttVurderingResponse(
            token = token,
            valgtÅrsak = valgtÅrsak,
        ).third.fold(
            { it },
            { fail(it.message) },
        )

        fun IASamarbeidDto.avsluttSamarbeid(
            orgnr: String,
            avslutningsType: IASamarbeid.Status,
            token: String = authContainerHelper.saksbehandler1.token,
            dato: java.time.LocalDate? = null,
        ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/${this.id}/avslutt-samarbeid" + (dato?.let { "?dato=$it" } ?: ""))
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(
                    SamarbeidDto(
                        id = this.id,
                        status = avslutningsType,
                    ),
                ),
            )
            .tilSingelRespons<IASamarbeidDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        fun IASakDto.opprettSamarbeidResponse(
            token: String = authContainerHelper.superbruker1.token,
            samarbeidsnavn: String = "Samarbeid med $orgnr",
        ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/opprett-samarbeid")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(
                    IASamarbeidDto(
                        id = 0,
                        saksnummer = saksnummer,
                        navn = samarbeidsnavn,
                    ),
                ),
            ).tilSingelRespons<IASamarbeidDto>()

        fun IASakDto.opprettSamarbeid(
            token: String = authContainerHelper.saksbehandler1.token,
            samarbeidsnavn: String = "Samarbeid med $orgnr",
        ): IASamarbeidDto =
            opprettSamarbeidResponse(token = token, samarbeidsnavn = samarbeidsnavn).third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun IASamarbeidDto.endreSamarbeidsNavn(
            orgnr: String,
            nyttNavn: String,
            token: String = authContainerHelper.saksbehandler1.token,
        ) = applikasjon.performPut("$NY_FLYT_PATH/virksomhet/$orgnr/samarbeid/$id/oppdater")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(
                    IASamarbeidDto(
                        id = id,
                        saksnummer = saksnummer,
                        navn = nyttNavn,
                    ),
                ),
            ).tilSingelRespons<IASamarbeidDto>().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        fun IASamarbeidDto.oppdaterSamarbeidsplan(
            orgnr: String,
            planId: String,
            endringer: List<EndreTemaRequest> = emptyList(),
            token: String = authContainerHelper.superbruker1.token,
        ) = applikasjon.performPut(
            url = "$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/${this.saksnummer}/samarbeid/${this.id}/plan/$planId",
        )
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(endringer),
            ).tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
                success = { respons -> respons },
                failure = { fail("${it.message}") },
            )

        fun IASamarbeidDto.oppdaterTemaISamarbeidsplan(
            orgnr: String,
            planId: String,
            temaId: Int,
            endringer: List<EndreUndertemaRequest> = emptyList(),
            token: String = authContainerHelper.superbruker1.token,
        ) = applikasjon.performPut(
            url = "$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/${this.saksnummer}/samarbeid/${this.id}/plan/$planId/tema/$temaId",
        )
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(endringer),
            ).tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
                success = { respons -> respons },
                failure = { fail("${it.message}") },
            )

        fun IASamarbeidDto.slettSamarbeidRespons(
            orgnr: String,
            token: String = authContainerHelper.saksbehandler1.token,
            dato: java.time.LocalDate? = null,
        ) = applikasjon.performDelete("$NY_FLYT_PATH/$orgnr/${this.id}/slett-samarbeid" + (dato?.let { "?dato=$it" } ?: ""))
            .authentication().bearer(token)
            .tilSingelRespons<IASamarbeidDto>()

        fun IASamarbeidDto.slettSamarbeid(
            orgnr: String,
            token: String = authContainerHelper.saksbehandler1.token,
            dato: java.time.LocalDate? = null,
        ) = this.slettSamarbeidRespons(
            orgnr = orgnr,
            token = token,
            dato = dato,
        ).third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

        fun IASamarbeidDto.slettSamarbeidsplan(
            orgnr: String,
            planId: String,
            token: String = authContainerHelper.saksbehandler1.token,
        ) = applikasjon.performDelete("$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/${this.saksnummer}/samarbeid/${this.id}/plan/$planId")
            .authentication().bearer(token)
            .tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) },
            )

        fun IASamarbeidDto.endreStatusPåUndertemaISamarbeidsplan(
            orgnr: String,
            planId: String,
            temaId: Int,
            undertemaId: Int,
            nyStatus: PlanUndertema.Status,
            token: String = authContainerHelper.superbruker1.token,
        ) = applikasjon.performPut(
            url = "$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/$saksnummer/samarbeid/$id/plan/$planId/tema/$temaId/undertema/$undertemaId/status",
        )
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(nyStatus),
            ).tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
                success = { respons -> respons },
                failure = { fail("${it.message}") },
            )

        fun PlanMedPubliseringStatusDto.endreTema(
            temaId: Int,
            inkluderTema: Boolean = true,
            inkluderUnderTema: Boolean = true,
            nyStartDato: LocalDate? = null,
            nySluttDato: LocalDate? = null,
        ): PlanMedPubliseringStatusDto =
            this.copy(
                temaer = this.temaer.map { tema ->
                    if (tema.id == temaId) {
                        tema.copy(
                            inkludert = inkluderTema,
                            undertemaer = tema.undertemaer.map { undertema ->
                                undertema.copy(
                                    inkludert = inkluderUnderTema,
                                    startDato = nyStartDato ?: if (inkluderUnderTema) undertema.startDato else null,
                                    sluttDato = nySluttDato ?: if (inkluderUnderTema) undertema.sluttDato else null,
                                )
                            },
                        )
                    } else {
                        tema
                    }
                },
            )
    }
}
