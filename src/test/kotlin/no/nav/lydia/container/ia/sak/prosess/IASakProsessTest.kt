package no.nav.lydia.container.ia.sak.prosess

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import io.kotest.assertions.shouldFail
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.comparables.shouldBeLessThan
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.PlanHelper.Companion.endreFlereTemaerIPlan
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.tilRequest
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.nyttNavnPåSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaMelding
import no.nav.lydia.ia.sak.MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakProsessTest {
    companion object {
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = Topic.SAMARBEIDSPLAN_TOPIC.konsumentGruppe)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            konsument.subscribe(mutableListOf(Topic.SAMARBEIDSPLAN_TOPIC.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `endring på samarbeid oppdaterer sistEndret`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()

        sak.nyttNavnPåSamarbeid(samarbeid, "Første")
            .nyttNavnPåSamarbeid(samarbeid, "Andre")
            .nyttNavnPåSamarbeid(samarbeid, "Tredje")

        val samarbeidMedNyttNavn = sak.hentAlleSamarbeid().first()

        samarbeidMedNyttNavn.navn shouldBe "Tredje"
        samarbeid.opprettet shouldBe samarbeidMedNyttNavn.opprettet
        samarbeid.sistEndret!! shouldBeLessThan samarbeidMedNyttNavn.sistEndret!!
    }

    @Test
    fun `tomme samarbeidsnavn skal lagres som NULL i databasen`() {
        val sak = nySakIKartleggesMedEtSamarbeid(
            navnPåSamarbeid = "",
        )

        val samarbeid = sak.hentAlleSamarbeid().first()
        postgresContainer.hentEnkelKolonne<String?>(
            """
            select navn from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        ) shouldBe null

        sak.nyttNavnPåSamarbeid(samarbeid, " ")
        postgresContainer.hentEnkelKolonne<String?>(
            """
            select navn from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        ) shouldBe null
    }

    @Test
    fun `oppdater endret_tidspunkt i DB ved endring av samarbeidsnavn`() {
        val sak = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "Avdeling 1")
        val samarbeid = sak.hentAlleSamarbeid().first()

        val endretTidspunktVedOpprettelse = postgresContainer.hentEnkelKolonne<java.sql.Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        endretTidspunktVedOpprettelse shouldNotBe null

        sak.nyttNavnPåSamarbeid(samarbeid, "Avdeling 1 - Fysio")
        val endretTidspunktEtterUpdate = postgresContainer.hentEnkelKolonne<java.sql.Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()

        endretTidspunktEtterUpdate!!.shouldBeGreaterThan(endretTidspunktVedOpprettelse!!)
    }

    @Test
    fun `oppdater endret_tidspunkt i DB ved sletting av samarbeid`() {
        val sak = nySakIKartleggesMedEtSamarbeid(navnPåSamarbeid = "Avdeling 1")
        val samarbeid = sak.hentAlleSamarbeid().first()

        val endretTidspunktVedOpprettelse = postgresContainer.hentEnkelKolonne<java.sql.Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()
        endretTidspunktVedOpprettelse shouldNotBe null

        sak.slettSamarbeid(samarbeid)
        val endretTidspunktEtterSlett = postgresContainer.hentEnkelKolonne<java.sql.Timestamp?>(
            """
            select endret_tidspunkt from ia_prosess where id = ${samarbeid.id}
            """.trimIndent(),
        )?.toLocalDateTime()

        endretTidspunktEtterSlett!!.shouldBeGreaterThan(endretTidspunktVedOpprettelse!!)
    }

    @Test
    fun `skal beholde tildelt prosess selvom man går frem og TILBAKE i saksgang`() {
        val sakIKartlegges = nySakIKartleggesMedEtSamarbeid()
        val alleSamarbeid = sakIKartlegges.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val førsteSamarbeid = alleSamarbeid.first()

        val sakIKartleggesTilbakeOgFrem = sakIKartlegges
            .nyHendelse(hendelsestype = IASakshendelseType.TILBAKE)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
        val alleSamarbeidEtterStatusEndring = sakIKartleggesTilbakeOgFrem.hentAlleSamarbeid()
        alleSamarbeidEtterStatusEndring shouldHaveSize 1

        alleSamarbeidEtterStatusEndring.first() shouldBe førsteSamarbeid
    }

    @Test
    fun `skal kunne opprette flere prosesser på samme sak`() {
        val sakIKartlegges = nySakIKartleggesMedEtSamarbeid()
        sakIKartlegges.hentAlleSamarbeid() shouldHaveSize 1
        sakIKartlegges.opprettNyttSamarbeid(navn = "Annet samarbeidsnavn").hentAlleSamarbeid() shouldHaveSize 2
    }

    @Test
    fun `skal kunne opprette kartlegginger på saker der det er flere prosesser`() {
        val sakMedEttSamarbeid = nySakIKartleggesMedEtSamarbeid()
        sakMedEttSamarbeid.hentAlleSamarbeid() shouldHaveSize 1

        val sakMedFlereSamarbeid = sakMedEttSamarbeid.opprettNyttSamarbeid(navn = "Annet samarbeidsnavn")
        sakMedFlereSamarbeid.hentAlleSamarbeid() shouldHaveSize 2

        val behovsvurdering = sakMedFlereSamarbeid.opprettSpørreundersøkelse()
        behovsvurdering.status shouldBe SpørreundersøkelseStatus.OPPRETTET
    }

    @Test
    fun `skal sende plan ved opprettelse av en ny plan på kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val førsteSamarbeid = alleSamarbeid.first()
        val opprettetPlan = sak.opprettEnPlan()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${førsteSamarbeid.id}-${opprettetPlan.id}",
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val planTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                    planTilSalesforce.orgnr shouldBe sak.orgnr
                    planTilSalesforce.saksnummer shouldBe sak.saksnummer
                    planTilSalesforce.samarbeid.id shouldBe førsteSamarbeid.id
                    planTilSalesforce.samarbeid.navn shouldBe førsteSamarbeid.navn
                    planTilSalesforce.samarbeid.status shouldBe førsteSamarbeid.status
                    planTilSalesforce.samarbeid.endretTidspunkt shouldNotBe null
                    planTilSalesforce.plan.id shouldBe opprettetPlan.id
                    planTilSalesforce.plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
                    planTilSalesforce.plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
                }
            }
        }
    }

    @Test
    fun `skal sende plan ved endringer i plan på kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val førsteSamarbeid = sak.hentAlleSamarbeid().first()
        val opprettetPlan = sak.opprettEnPlan()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${førsteSamarbeid.id}-${opprettetPlan.id}",
                konsument = konsument,
            ) {
                it.size shouldBe 1
            }
        }
        sak.endreFlereTemaerIPlan(endring = opprettetPlan.inkluderAlt().tilRequest())

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = "${sak.saksnummer}-${førsteSamarbeid.id}-${opprettetPlan.id}",
                konsument = konsument,
            ) {
                it.forExactlyOne { melding ->
                    val planTilSalesforce = Json.decodeFromString<SamarbeidsplanKafkaMelding>(melding)
                    planTilSalesforce.orgnr shouldBe sak.orgnr
                    planTilSalesforce.saksnummer shouldBe sak.saksnummer
                    planTilSalesforce.samarbeid.id shouldBe førsteSamarbeid.id
                    planTilSalesforce.samarbeid.navn shouldBe førsteSamarbeid.navn
                    planTilSalesforce.samarbeid.status shouldBe førsteSamarbeid.status
                    planTilSalesforce.samarbeid.endretTidspunkt shouldNotBe null
                    planTilSalesforce.plan.id shouldBe opprettetPlan.id
                    planTilSalesforce.plan.temaer.size shouldBeExactly opprettetPlan.temaer.size
                    planTilSalesforce.plan.sistEndret shouldBeGreaterThan opprettetPlan.sistEndret
                }
            }
        }
    }

    @Test
    fun `skal kunne hente ut alle aktive prosesser i en sak`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1
        alleSamarbeid.first().saksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal ikke få feil i historikken dersom man endrer navn på prosess flere ganger`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val førsteSamarbeid = alleSamarbeid.first()
        sak.nyttNavnPåSamarbeid(førsteSamarbeid, "Første")
            .nyttNavnPåSamarbeid(førsteSamarbeid, "Andre")
            .nyttNavnPåSamarbeid(førsteSamarbeid, "Tredje")
            .hentAlleSamarbeid().first().navn shouldBe "Tredje"

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
            IASakshendelseType.ENDRE_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal ikke få feil i sakshistorikk dersom man sletter flere samarbeid på rad`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "First")
            .opprettNyttSamarbeid(navn = "Sist")

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        sak.slettSamarbeid(alleSamarbeid.first()).slettSamarbeid(alleSamarbeid.last())
        sak.hentAlleSamarbeid() shouldHaveSize 0

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.SLETT_PROSESS,
            IASakshendelseType.SLETT_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal ikke få feil i historikken dersom man oppretter flere prosesser på rad`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        sak.hentAlleSamarbeid() shouldHaveSize 1

        sak.opprettNyttSamarbeid(navn = "Navn 1")
            .opprettNyttSamarbeid(navn = "Navn 2")
            .opprettNyttSamarbeid(navn = "Navn 3")
            .hentAlleSamarbeid() shouldHaveSize 4

        sak.hentAlleSamarbeid() shouldHaveSize 4

        val samarbeidshistorikk = hentSamarbeidshistorikk(
            sak.orgnr,
        )
        samarbeidshistorikk shouldHaveSize 1
        val sakshendelser = samarbeidshistorikk.first().sakshendelser
        sakshendelser shouldHaveSize 9
        sakshendelser.map { it.hendelsestype } shouldBe listOf(
            IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET,
            IASakshendelseType.VIRKSOMHET_VURDERES,
            IASakshendelseType.TA_EIERSKAP_I_SAK,
            IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES,
            IASakshendelseType.VIRKSOMHET_KARTLEGGES,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
            IASakshendelseType.NY_PROSESS,
        )
        sakshendelser.last().status shouldBe IAProsessStatus.KARTLEGGES
    }

    @Test
    fun `skal kunne slette tomme prosesser`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val samarbeidFørSletting = sak.hentAlleSamarbeid()
        samarbeidFørSletting shouldHaveSize 1

        val samarbeidSomSkalSlettes = samarbeidFørSletting.first()
        sak.slettSamarbeid(samarbeidSomSkalSlettes)

        val samarbeidEtterSletting = sak.hentAlleSamarbeid()
        samarbeidEtterSletting shouldBe emptyList()
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en behovsvurdering knyttet til seg`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val alleSamarbeidFørSletting = sak.hentAlleSamarbeid()
        val samarbeidSomSkalSlettes = alleSamarbeidFørSletting.first()
        sak.opprettSpørreundersøkelse(prosessId = samarbeidSomSkalSlettes.id)
        shouldFail {
            sak.slettSamarbeid(samarbeidSomSkalSlettes)
        }
        sak.hentAlleSamarbeid() shouldBe alleSamarbeidFørSletting
    }

    @Test
    fun `skal ikke kunne slette prosesser som har en plan knyttet til seg`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val alleSamarbeidFørSletting = sak.hentAlleSamarbeid()
        val førsteSamarbeid = alleSamarbeidFørSletting.first()
        sak.opprettEnPlan()

        shouldFail {
            sak.slettSamarbeid(samarbeid = førsteSamarbeid)
        }
        sak.hentAlleSamarbeid() shouldBe alleSamarbeidFørSletting
    }

    @Test
    fun `skal få feilmelding dersom man sender inn feil data ved sletting`() {
        val sak = nySakIKartlegges()

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(
                    IAProsessDto(
                        id = 1010000,
                        saksnummer = sak.saksnummer,
                    ),
                ),
            )
        }
    }

    @Test
    fun `skal ikke lagre SLETT_PROSESS hendelse dersom sletting ikke er lov`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid()
        samarbeid shouldHaveSize 1

        sak.opprettSpørreundersøkelse()

        shouldFail {
            sak.nyHendelse(
                hendelsestype = IASakshendelseType.SLETT_PROSESS,
                payload = Json.encodeToString(
                    IAProsessDto(
                        id = 1010000,
                        saksnummer = sak.saksnummer,
                    ),
                ),
            )
        }

        val samarbeidEtterSlett = sak.hentAlleSamarbeid()
        samarbeidEtterSlett shouldHaveSize 1

        val sisteHendelse = postgresContainer.hentEnkelKolonne<String>(
            """
            select id from ia_sak_hendelse where saksnummer = '${sak.saksnummer}' order by  opprettet desc limit 1
            """.trimIndent(),
        )
        sisteHendelse shouldBe sak.endretAvHendelseId
    }

    @Test
    fun `skal kunne opprette et nytt samarbeid med navn`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid(navn = "Navn")
        sak.hentAlleSamarbeid().forExactlyOne {
            it.navn shouldBe "Navn"
        }
    }

    @Test
    fun `skal kun kunne opprette samarbeid med unikt navn`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid(navn = "Navn")
        shouldFail { sak.opprettNyttSamarbeid(navn = "Navn") }.message shouldBe "HTTP Exception 409 Conflict Samarbeidsnavn finnes allerede"
        shouldFail { sak.opprettNyttSamarbeid(navn = "navn") }.message shouldBe "HTTP Exception 409 Conflict Samarbeidsnavn finnes allerede"

        sak.hentAlleSamarbeid().count { it.navn == "Navn" } shouldBeExactly 1
    }

    @Test
    fun `samarbeidsnavn er begrenset til 50 tegn`() {
        val sak = nySakIKartlegges()

        val forLangtNavn = "n".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN + 1)
        val gyldigLangtNavn = "n".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN)
        val nyttGydigLangtNavn = "o".repeat(MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN)
        shouldFail {
            sak.opprettNyttSamarbeid(navn = forLangtNavn)
        }
        val sakMedSamarbeid = sak.opprettNyttSamarbeid(navn = gyldigLangtNavn)
        val samarbeid = sakMedSamarbeid.hentAlleSamarbeid().first()
        shouldFail {
            sakMedSamarbeid.nyttNavnPåSamarbeid(samarbeid, forLangtNavn)
        }
        sakMedSamarbeid.nyttNavnPåSamarbeid(samarbeid, nyttGydigLangtNavn)
    }

    @Test
    fun `skal gå tilbake til forrige status dersom man trykker tilbake etter å ha slettet prosess`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val sakEtterSlettetSamarbeid = sak.slettSamarbeid(samarbeid)
        sakEtterSlettetSamarbeid.status shouldBe IAProsessStatus.KARTLEGGES

        val sakEtterTilbake = sakEtterSlettetSamarbeid.nyHendelse(IASakshendelseType.TILBAKE)
        sakEtterTilbake.status shouldBe IAProsessStatus.KONTAKTES
    }
}
