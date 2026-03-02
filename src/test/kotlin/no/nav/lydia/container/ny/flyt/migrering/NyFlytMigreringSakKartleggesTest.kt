package no.nav.lydia.container.ny.flyt.migrering

import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeEqualComparingTo
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraKvartal
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraSiste4Kvartaler
import no.nav.lydia.container.ny.flyt.NyFlytTest.Companion.hentVirksomhetTilstand
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.fullførSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkNyFlyt
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytMigreringSakKartleggesTest {
    @Test
    fun `EDGE CASE sak med status KARTLEGGES med et fullført samarbeid er ikke dekket enda av migrerings matrise`() {
        val iaSakDto = nySakIKartlegges().opprettNyttSamarbeid().also { it.opprettEnPlan() }.nyHendelse(hendelsestype = VIRKSOMHET_SKAL_BISTÅS)
        val iaSakDtoTilbakeIKartlegges = iaSakDto.fullførSamarbeid().nyHendelse(IASakshendelseType.TILBAKE)

        tømmKafkaTopics(iaSakDto)
        sendMigreringOgVerifiserSak(
            iaSakDto = iaSakDtoTilbakeIKartlegges,
            sistEndretAvBruker = iaSakDtoTilbakeIKartlegges.endretTidspunkt,
            forventetStatus = IASak.Status.KARTLEGGES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
        )
        shouldFail {
            postgresContainerHelper.hentEnkelKolonne<String>(
                "select tilstand from tilstand_virksomhet where orgnr = '${iaSakDtoTilbakeIKartlegges.orgnr}'",
            )
        }

        applikasjon.shouldContainLog("er ikke håndtert som en use-case til migrering enda".toRegex())
    }

    @Test
    fun `Rad #6 sak med status KARTLEGGES men ingen aktive samarbeid migreres til VURDERES status`() {
        val iaSakDto = nySakIKartlegges()

        tømmKafkaTopics(iaSakDto)
        sendMigreringOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = iaSakDto.endretTidspunkt,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #7 sak med status KARTLEGGES og et aktivt samarbeid migreres til AKTIV status`() {
        val iaSakDto = nySakIKartlegges()
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().endretTidspunkt

        tømmKafkaTopics(iaSakDto)
        sendMigreringOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.AKTIV,
            forventetTilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // opprett samarbeid
                IASak.Status.AKTIV,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AKTIV)
    }

    @Test
    fun `Rad #8 sak med status KARTLEGGES hvor alle samarbeid er slettet migreres til VURDERES status`() {
        val iaSakDto = nySakIKartlegges()
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().slettSamarbeid().endretTidspunkt

        tømmKafkaTopics(iaSakDto)
        sendMigreringOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.VURDERES,
            forventetTilstand = VirksomhetIATilstand.VirksomhetVurderes,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // opprett samarbeid
                IASak.Status.KARTLEGGES, // slett samarbeid
                IASak.Status.VURDERES,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.SLETT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.VURDERES)
    }

    @Test
    fun `Rad #9 sak med status KARTLEGGES uten aktive samarbeid men hvor det er minst ett avbryt samarbeid migreres til VURDERES status`() {
        val iaSakDto = nySakIKartlegges()
        val sistEndretAvBruker = iaSakDto.opprettNyttSamarbeid().avbrytSamarbeid().endretTidspunkt

        tømmKafkaTopics(iaSakDto)
        sendMigreringOgVerifiserSak(
            iaSakDto = iaSakDto,
            sistEndretAvBruker = sistEndretAvBruker,
            forventetStatus = IASak.Status.AVSLUTTET,
            forventetTilstand = VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet,
        )

        verifiserHistorikk(
            orgnummer = iaSakDto.orgnr,
            forventedeStatuser = listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.KARTLEGGES, // opprett samarbeid
                IASak.Status.KARTLEGGES, // avbryt samarbeid
                IASak.Status.AVSLUTTET,
            ),
            forventedeHendelsestyper = listOf(
                IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
                IASakshendelseType.VIRKSOMHET_VURDERES,
                IASakshendelseType.TA_EIERSKAP_I_SAK,
                IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
                IASakshendelseType.VIRKSOMHET_KARTLEGGES,
                IASakshendelseType.NY_PROSESS,
                IASakshendelseType.AVBRYT_PROSESS,
                IASakshendelseType.MIGRERING_TIL_NY_FLYT,
            ),
        )

        verifiserKafkaMeldinger(iaSakDto, forventetStatus = IASak.Status.AVSLUTTET)
    }

    companion object {
        private val iaSakTopic = Topic.IA_SAK_TOPIC
        private val iaSakStatistikkTopic = Topic.IA_SAK_STATISTIKK_TOPIC
        private val iaSakKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakTopic)
        private val iaSakStatistikkKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakStatistikkTopic)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            iaSakKonsument.subscribe(mutableListOf(iaSakTopic.navn))
            iaSakStatistikkKonsument.subscribe(mutableListOf(iaSakStatistikkTopic.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            iaSakKonsument.unsubscribe()
            iaSakKonsument.close()

            iaSakStatistikkKonsument.unsubscribe()
            iaSakStatistikkKonsument.close()
        }

        private fun nySakIKartlegges(): IASakDto {
            val næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120"
            val nyVirksomhet = TestVirksomhet.nyVirksomhet(
                næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
            )
            val virksomhet = VirksomhetHelper.lastInnNyVirksomhet(nyVirksomhet)
            val iaSakDto = SakHelper.nySakIKartlegges(virksomhet.orgnr)
            return iaSakDto
        }

        private fun tømmKafkaTopics(iaSakDto: IASakDto) {
            runBlocking {
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = iaSakDto.saksnummer, konsument = iaSakKonsument) {}
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = iaSakDto.saksnummer,
                    konsument = iaSakStatistikkKonsument,
                ) {}
            }
        }

        private fun sendMigreringOgVerifiserSak(
            iaSakDto: IASakDto,
            sistEndretAvBruker: LocalDateTime?,
            forventetStatus: IASak.Status,
            forventetTilstand: VirksomhetIATilstand,
        ) {
            kafkaContainerHelper.sendJobbMelding(Jobb.migrerEnVirksomhetTilNyFlyt, parameter = iaSakDto.orgnr)

            val migrertSak = SakHelper.hentSakNyFlyt(orgnummer = iaSakDto.orgnr)
            migrertSak.status shouldBe forventetStatus
            migrertSak.endretTidspunkt!! shouldBeEqualComparingTo sistEndretAvBruker!!

            val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = iaSakDto.orgnr)
            virksomhetsTilstand.tilstand shouldBe forventetTilstand
        }

        private fun verifiserHistorikk(
            orgnummer: String,
            forventedeStatuser: List<IASak.Status>,
            forventedeHendelsestyper: List<IASakshendelseType>,
        ) {
            hentSamarbeidshistorikkNyFlyt(orgnummer = orgnummer).also { samarbeidshistorikk ->
                samarbeidshistorikk shouldHaveSize 1
                val sakshistorikk = samarbeidshistorikk.first()
                sakshistorikk.sakshendelser.map { it.status } shouldContainExactly forventedeStatuser
                sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly forventedeHendelsestyper
            }
        }

        private fun verifiserKafkaMeldinger(
            iaSakDto: IASakDto,
            forventetStatus: IASak.Status,
        ) {
            runBlocking {
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = iaSakDto.saksnummer, konsument = iaSakKonsument) { meldinger ->
                    meldinger.forAll { hendelse ->
                        hendelse shouldContain iaSakDto.saksnummer
                        hendelse shouldContain iaSakDto.orgnr
                    }
                    meldinger shouldHaveSize 1
                    meldinger[0] shouldContain forventetStatus.name
                }
                kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                    key = iaSakDto.saksnummer,
                    konsument = iaSakStatistikkKonsument,
                ) { meldinger ->
                    val objektene = meldinger.map {
                        Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                    }
                    objektene shouldHaveSize 1
                    objektene.forExactlyOne {
                        it.orgnr shouldBe iaSakDto.orgnr
                        it.saksnummer shouldBe iaSakDto.saksnummer
                        it.eierAvSak shouldBe iaSakDto.eidAv
                        it.status shouldBe forventetStatus
                        it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                        it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                        it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                        it.bransjeprogram shouldBe Bransje.ANLEGG
                        it.endretAv shouldBe "Fia system"
                        it.endretAvRolle shouldBe Rolle.SUPERBRUKER
                        it.enhetsnummer shouldBe NAV_ENHET_FOR_MASKINELT_OPPDATERING.enhetsnummer
                        it.enhetsnavn shouldBe NAV_ENHET_FOR_MASKINELT_OPPDATERING.enhetsnavn
                    }
                }
            }
        }
    }
}
