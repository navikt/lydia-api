package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.forNone
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.shouldBeIn
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotContainAnyOf
import io.kotest.matchers.doubles.shouldBeGreaterThanOrEqual
import io.kotest.matchers.doubles.shouldBeLessThanOrEqual
import io.kotest.matchers.ints.shouldBeGreaterThan
import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.ints.shouldBeInRange
import io.kotest.matchers.ints.shouldBeLessThanOrEqual
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.endredeVirksomheter
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.fjernedeVirksomheter
import no.nav.lydia.helper.PiaBrregOppdateringTestData.Companion.slettedeVirksomheter
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.slettSak
import no.nav.lydia.helper.StatistikkHelper.Companion.hentFilterverdier
import no.nav.lydia.helper.StatistikkHelper.Companion.hentPubliseringsinfo
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForAlleVirksomheter
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSiste4Kvartaler
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSiste4KvartalerRespons
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSisteTilgjengeligKvartal
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværRespons
import no.nav.lydia.helper.StatistikkHelper.Companion.hentTotaltAntallTreffISykefravær
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestData.Companion.SCENEKUNST
import no.nav.lydia.helper.TestData.Companion.SEKTOR_KOMMUNAL_FORVALTNING
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.INDRE_ØSTFOLD
import no.nav.lydia.helper.TestVirksomhet.Companion.KOMMUNE_OSLO
import no.nav.lydia.helper.TestVirksomhet.Companion.LUNNER
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_STATUSFILTER
import no.nav.lydia.helper.TestVirksomhet.Companion.beliggenhet
import no.nav.lydia.helper.TestVirksomhet.Companion.nyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentVirksomhetsinformasjon
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnTestdata
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.sykefraversstatistikk.api.EierDTO
import no.nav.lydia.sykefraversstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.VIRKSOMHETER_PER_SIDE
import no.nav.lydia.sykefraversstatistikk.api.VirksomhetsoversiktDto
import no.nav.lydia.sykefraversstatistikk.api.VirksomhetsoversiktResponsDto
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val mockOAuth2Server = oauth2ServerContainer

    // Denne testen bruker vi for å hente en dump lokalt (les README)
    @Test
    fun `Test for å hente datasource`() {
        val jdbcUrl = postgresContainer.dataSource.jdbcUrl
        jdbcUrl shouldStartWith "jdbc:postgresql"
    }

    @Test
    fun `skal kunne filtrere sykefraværsstatistikk på sektor`() {
        lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(), sektor = SEKTOR_KOMMUNAL_FORVALTNING)
        val sykefraværstatistikkKommunalSektor = hentSykefravær(sektor = SEKTOR_KOMMUNAL_FORVALTNING).data
        sykefraværstatistikkKommunalSektor.size shouldBeGreaterThan 0
        sykefraværstatistikkKommunalSektor.forAll { sykefraværstatistikk ->
            hentVirksomhetsinformasjon(
                orgnummer = sykefraværstatistikk.orgnr,
                token = mockOAuth2Server.saksbehandler1.token
            ).sektor shouldBe Sektor.KOMMUNAL.beskrivelse
        }

        hentTotaltAntallTreffISykefravær(sektor = SEKTOR_KOMMUNAL_FORVALTNING) shouldBeGreaterThanOrEqual sykefraværstatistikkKommunalSektor.size
    }

    @Test
    fun `skal kunne hente sykefraværsstatistikk fra siste tilgjengelige kvartal`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = nyVirksomhet()
        lastInnTestdata(
            TestData().lagData(
                virksomhet = virksomhet,
                perioder = listOf(
                    gjeldendePeriode,
                    gjeldendePeriode.forrigePeriode(),
                    Periode(kvartal = 4, årstall = 2019)
                ),
            )
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal = postgresContainer.hentEnkelKolonne<Double>(
            """select sykefraversprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.kvartal}
                and arstall=${gjeldendePeriode.årstall}
                """.trimMargin()
        )

        val result =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.arstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.sykefraversprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }

    @Test
    fun `skal kunne hente sykefraværsstatistikk riktig når vi mangler siste periode`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = nyVirksomhet()
        lastInnTestdata(
            TestData().lagData(
                virksomhet = virksomhet,
                perioder = listOf(gjeldendePeriode.forrigePeriode()), // uten siste periode
            )
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal = postgresContainer.hentEnkelKolonne<Double>(
            """select sykefraversprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.forrigePeriode().kvartal}
                and arstall=${gjeldendePeriode.forrigePeriode().årstall}
                """.trimMargin()
        )

        val result =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.sykefraversprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }

    @Test
    fun `skal kunne hente sykefraværsstatistikk for en enkelt virksomhet`() {
        val orgnr = BERGEN.orgnr
        hentSykefraværForVirksomhetSiste4Kvartaler(orgnummer = orgnr)
            .also {
                it.orgnr shouldBe orgnr
            }
    }

    @Test
    fun `skal kunne hente sykefraværsstatistikk for en enkelt bedrift for de siste 4 kvartaler`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val orgnr = BERGEN.orgnr
        hentSykefraværForVirksomhetSiste4Kvartaler(orgnummer = orgnr).also {
            it.orgnr shouldBe orgnr
            it.antallKvartaler shouldBe 2
            it.kvartaler.size shouldBe 2
            it.kvartaler[0].kvartal shouldBe gjeldendePeriode.kvartal
            it.kvartaler[0].årstall shouldBe gjeldendePeriode.årstall
        }
    }

    @Test
    fun `skal kunne sortere sykefraværsstatistikk på valgfri nøkkel`() {
        val sorteringsnøkkel = "tapte_dagsverk"

        hentSykefravær(
            success = { response ->
                val tapteDagsverk = response.data.map { it.tapteDagsverk }
                tapteDagsverk shouldContainInOrder tapteDagsverk.sortedDescending()
            },
            sorteringsnokkel = sorteringsnøkkel,
            sorteringsretning = "desc",
            token = mockOAuth2Server.saksbehandler1.token
        )

        hentSykefravær(success = { response ->
            val tapteDagsverk = response.data.map { it.tapteDagsverk }
            tapteDagsverk shouldContainInOrder tapteDagsverk.sorted()
        }, sorteringsnokkel = sorteringsnøkkel, sorteringsretning = "asc")
    }

    @Test
    fun `skal kunne sortere sykefraværsstatistikk etter sist endret-dato`() {
        val testKommune = Kommune(navn = "Jimmyyy", nummer = "0555")
        val virksomhet1 =
                lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        val virksomhet2 =
                lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        val virksomhet3 =
                lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        val virksomhet4 =
                lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))

        opprettSakForVirksomhet(orgnummer = virksomhet1.orgnr)
        opprettSakForVirksomhet(orgnummer = virksomhet2.orgnr).oppdaterHendelsesTidspunkter(antallDagerTilbake = 5)
        opprettSakForVirksomhet(orgnummer = virksomhet3.orgnr)
        opprettSakForVirksomhet(orgnummer = virksomhet4.orgnr).oppdaterHendelsesTidspunkter(antallDagerTilbake = 10)

        val sorteringsnøkkel = "sist_endret"

        hentSykefravær(
            success = { response ->
                val sistEndret = response.data.map { it.sistEndret }
                sistEndret shouldContainInOrder sistEndret.sortedByDescending { it?.toEpochDays()}
            },
            kommuner = testKommune.nummer,
            sorteringsnokkel = sorteringsnøkkel,
            sorteringsretning = "desc",
        )

        hentSykefravær(
                success = { response ->
                    val sistEndret = response.data.map { it.sistEndret }
                    sistEndret shouldContainInOrder sistEndret.sortedBy { it?.toEpochDays() }
                },
                kommuner = testKommune.nummer,
                sorteringsnokkel = sorteringsnøkkel,
                sorteringsretning = "asc")
    }

    @Test
    fun `skal få sykefraværsstatistikk for siste fire kvartal`() {
        val orgnummer = nyttOrgnummer()

        val sykefraversprosent = hentSykefraværForVirksomhetSiste4Kvartaler(orgnummer = orgnummer).sykefraversprosent

        val sykefraværsprosentSiste4Kvartal = postgresContainer.hentEnkelKolonne<Double>(
            "select prosent from sykefravar_statistikk_virksomhet_siste_4_kvartal where orgnr='$orgnummer'"
        )
        sykefraversprosent shouldBe sykefraværsprosentSiste4Kvartal
    }

    @Test
    fun `skal få riktig publiseringsinfo`() {
        val tilPeriode = TestData.gjeldendePeriode
        val fraPeriode = tilPeriode.forrigePeriode().forrigePeriode().forrigePeriode()
        val hentetPubliseringsinfo = hentPubliseringsinfo()

        hentetPubliseringsinfo.nestePubliseringsdato shouldNotBe null
        hentetPubliseringsinfo.sistePubliseringsdato shouldNotBe null
        hentetPubliseringsinfo.fraTil.fra.årstall shouldBe fraPeriode.årstall
        hentetPubliseringsinfo.fraTil.fra.kvartal shouldBe fraPeriode.kvartal
        hentetPubliseringsinfo.fraTil.til.årstall shouldBe tilPeriode.årstall
        hentetPubliseringsinfo.fraTil.til.kvartal shouldBe tilPeriode.kvartal
    }

    @Test
    fun `skal returnere både samiske og norske kommunenavn`() {
        val filterverdier = hentFilterverdier()
        val tromsOgFinnmark = filterverdier.fylker.first { it.fylke.nummer == "54" }
        tromsOgFinnmark.kommuner.forExactlyOne {
            it.nummer shouldBe "5441"
            it.navn shouldBe "Deatnu"
            it.navnNorsk shouldBe "Tana"
        }

    }

    @Test
    fun `frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val saksbehandler1 = mockOAuth2Server.saksbehandler1
        val filterverdier = hentFilterverdier(token = saksbehandler1.token)

        filterverdier.fylker[0].fylke.navn shouldBe "Oslo"
        filterverdier.fylker[0].fylke.nummer shouldBe "03"
        filterverdier.fylker[0].kommuner.size shouldBe 1
        filterverdier.neringsgrupper.find { it.kode == Næringsgruppe.UOPPGITT.tilTosifret() }
            .shouldNotBeNull()
        filterverdier.neringsgrupper.size shouldBeGreaterThan 1
        filterverdier.neringsgrupper.all { næringsgruppe -> næringsgruppe.kode.length == 2 }.shouldBeTrue()
        filterverdier.statuser shouldBe IAProsessStatus.filtrerbareStatuser()
        filterverdier.filtrerbareEiere shouldBe listOf(
            EierDTO(
                navIdent = saksbehandler1.navIdent,
                navn = saksbehandler1.navn
            )
        )
        filterverdier.sektorer.map { it.kode } shouldBe Sektor.values().map { it.kode }
    }

    @Test
    fun `kun superbrukere skal få lov til å se alle saksbehandlere i systemet`() {
        val lesebruker = mockOAuth2Server.lesebruker
        hentFilterverdier(token = lesebruker.token)
            .filtrerbareEiere.map { it.navIdent } shouldBe listOf(lesebruker.navIdent)

        val saksbehandler = mockOAuth2Server.saksbehandler1
        hentFilterverdier(token = saksbehandler.token).filtrerbareEiere
            .also { eiere ->
                eiere.map { it.navIdent } shouldBe listOf(saksbehandler.navIdent)
                eiere.map { it.navn } shouldBe listOf(saksbehandler.navn)
            }

        val superbruker = mockOAuth2Server.superbruker1
        val alleFiltrerBareEiere = hentFilterverdier(token = superbruker.token).filtrerbareEiere
        alleFiltrerBareEiere.map { it.navIdent } shouldBe listOf(
            // -- SIDE 1
            "M12345",
            "S12345",
            "S12346",
            "R12345",
            // -- SIDE 2
            "M54321",
            "S54321",
            "S64321",
            "R54321"
        )
    }

    @Test
    fun `uautorisert kall mot sykefraværendepunktet skal returnere 401`() {
        val request = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
        val (_, response, _) = request.responseString()

        response.statusCode shouldBe 401
    }

    @Test
    fun `skal kunne hente alle virksomheter i Bergen kommune`() {
        val kommunenummer = "4601" // Brønnøy kommune i Bergen
        val virksomhet = BERGEN
        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAtLeastOne { testVirksomhet ->
                testVirksomhet.virksomhetsnavn shouldBe virksomhet.navn
                testVirksomhet.orgnr shouldBe virksomhet.orgnr
            }
        }, kommuner = kommunenummer)
    }

    @Test
    fun `skal kunne hente alle virksomheter i Vestland fylke`() {
        val fylkesnummer = "46"

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { testVirksomhet ->
                testVirksomhet.matcher<String>(kolonne = "kommune") {
                    it shouldBe BERGEN.beliggenhet?.kommune
                }
                testVirksomhet.matcher<String>(kolonne = "kommunenummer") {
                    it shouldStartWith fylkesnummer
                }
            }
        }, fylker = fylkesnummer)
    }

    @Test
    fun `skal kunne filtrere på øst-viken fylke`() {
        val virksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = INDRE_ØSTFOLD))
        lastInnNyVirksomhet(nyVirksomhet = virksomhet)
        val alleKommunenummerIØstViken = GeografiService().hentKommunerFraFylkesnummer(listOf("Ø30")).map { it.nummer }
        hentSykefravær(
            fylker = "Ø30",
            success = { response ->
                response.data.size shouldBeGreaterThan 0
                response.data.forAll { dto ->
                    dto.matcher<String>(kolonne = "kommunenummer") {
                        it shouldBeIn alleKommunenummerIØstViken
                    }
                }
            }
        )
    }

    @Test
    fun `skal kunne filtrere på en enkelt kommune i øst-viken`() {
        val virksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = INDRE_ØSTFOLD))
        lastInnNyVirksomhet(nyVirksomhet = virksomhet)
        hentSykefravær(
            kommuner = INDRE_ØSTFOLD.nummer,
            success = { response ->
                response.data.size shouldBeGreaterThan 0
                response.data.forAll { dto ->
                    dto.matcher<String>(kolonne = "kommunenummer") {
                        it shouldBe INDRE_ØSTFOLD.nummer
                    }
                }
            }
        )
    }

    @Test
    fun `skal kun få treff fra kommuner definert i søkeparemeter og ikke fra hele fylke (hvis man spesifiserer fylke)`() {
        val virksomhet1 = nyVirksomhet(beliggenhet = beliggenhet(kommune = INDRE_ØSTFOLD))
        lastInnNyVirksomhet(nyVirksomhet = virksomhet1)
        val virksomhet2 = nyVirksomhet(beliggenhet = beliggenhet(kommune = LUNNER))
        lastInnNyVirksomhet(nyVirksomhet = virksomhet2)
        hentSykefravær(
            fylker = "Ø30",
            kommuner = LUNNER.nummer,
            success = { response ->
                response.data.size shouldBeGreaterThan 0
                response.data.forAll { dto ->
                    dto.matcher<String>(kolonne = "kommunenummer") {
                        it shouldBe LUNNER.nummer
                    }
                }
            }
        )
    }

    @Test
    fun `skal kunne filtrere på kommuner utenfor øst-viken samt fylke øst-viken`() {
        val virksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = INDRE_ØSTFOLD))
        lastInnNyVirksomhet(nyVirksomhet = virksomhet)
        hentSykefravær(
            kommuner = KOMMUNE_OSLO.nummer,
            fylker = "Ø30",
            success = { response ->
                response.data.size shouldBeGreaterThan 0
                response.data.forAll { dto ->
                    dto.matcher<String>(kolonne = "kommunenummer") {
                        it.substring(0..1) shouldBeIn setOf("30", "03")
                    }
                }
            }
        )
    }


    @Test
    fun `skal kunne hente alle virksomheter i et gitt fylke og en gitt kommune`() {
        val fylkesnummer = "46" // Vestland fylke
        val kommunenummer = "0301" // Oslo kommune

        hentSykefravær(success = { response ->
            response.data.forAll { dto ->
                setOf("46", "03").forAtLeastOne { fylke ->
                    dto.matcher<String>(kolonne = "kommunenummer") {
                        it.substring(0..1) shouldBe fylke
                    }
                }
            }
        }, kommuner = kommunenummer, fylker = fylkesnummer)
    }

    @Test
    fun `skal kunne hente alle virksomheter i en gitt næring`() {
        hentSykefravær(success = { response ->
            response.data.forAll {
                postgresContainer.hentEnkelKolonne<Int>(
                    """
                        SELECT count(*) FROM virksomhet AS v JOIN virksomhet_naring AS vn ON (v.id = vn.virksomhet)
                        WHERE v.orgnr = '${it.orgnr}' AND vn.narings_kode = '${SCENEKUNST.kode}'
                    """.trimIndent()
                ) shouldBeGreaterThanOrEqual 1
            }
        }, næringsgrupper = SCENEKUNST.kode)
    }

    @Test
    fun `tomme søkeparametre skal ikke filtrere på noen parametre`() {
        val resultatMedTommeParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?neringsgrupper=&fylker=&kommuner=")
                .authentication().bearer(mockOAuth2Server.saksbehandler1.token)
                .tilSingelRespons<VirksomhetsoversiktResponsDto>().third


        val resultatUtenParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
                .authentication().bearer(mockOAuth2Server.saksbehandler1.token)
                .tilSingelRespons<VirksomhetsoversiktResponsDto>().third

        resultatMedTommeParametre.get().data shouldContainAll resultatUtenParametre.get().data
    }

    @Test
    fun `skal kunne hente virksomheter filtrert på kommune og næring`() {
        val oslo = "0301"
        val nordreFollo = "3020"

        hentSykefravær(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.forAll { dto ->
                    listOf(oslo, nordreFollo).forAtLeastOne { knr ->
                        dto.matcher<String>(kolonne = "kommunenummer") {
                            it shouldBe knr
                        }
                    }
                }
            },
            kommuner = "$oslo,$nordreFollo",
            næringsgrupper = "${SCENEKUNST.tilTosifret()},${BEDRIFTSRÅDGIVNING.tilTosifret()}",
            token = mockOAuth2Server.saksbehandler1.token
        )
    }

    @Test
    fun `skal bare få statistikk for siste periode hvis periode er uspesifisert`() {
        val gjeldendePeriode = TestData.gjeldendePeriode

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll {
                it.kvartal shouldBe gjeldendePeriode.kvartal
                it.arstall shouldBe gjeldendePeriode.årstall
            }
        })
    }

    @Test
    fun `skal kunne hente virksomheter for et bestemt år og kvartal`() {
        val forrigePeriode = TestData.gjeldendePeriode.forrigePeriode()
        hentSykefravær(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.forAll {
                    it.kvartal shouldBe forrigePeriode.kvartal
                    it.arstall shouldBe forrigePeriode.årstall
                }
            },
            kvartal = forrigePeriode.kvartal.toString(),
            årstall = forrigePeriode.årstall.toString(),
            token = mockOAuth2Server.saksbehandler1.token
        )
    }

    @Test
    fun `skal kunne hente alle virksomheter`() {
        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
        })
    }

    @Test
    fun `kan hente kommuner basert på fylkesnummer`() {
        val fylkesnummer = listOf("46", "03") // Vestland og Oslo fylke
        val geografiService = GeografiService()
        val kommuner = geografiService.hentKommunerFraFylkesnummer(fylkesnummer)
        kommuner shouldHaveSize 44
    }

    @Test
    fun `skal kunne filtrere virksomheter på status`() {
        val orgnummer = TESTVIRKSOMHET_FOR_STATUSFILTER.orgnr
        postgresContainer.performUpdate("DELETE FROM ia_sak WHERE orgnr = '$orgnummer'")

        lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(mockOAuth2Server.superbruker1.token)
            .tilSingelRespons<IASakDto>().third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) })

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll {
                it.status shouldBe IAProsessStatus.VURDERES
            }
        }, iaStatus = IAProsessStatus.VURDERES.name)

        hentSykefravær(success = { response ->
            response.data.forAll {
                it.status shouldBe IAProsessStatus.IKKE_AKTIV
                it.orgnr shouldNotBe orgnummer
            }
        }, iaStatus = IAProsessStatus.IKKE_AKTIV.name)
    }

    @Test
    fun `skal kunne paginere på ett statistikkresultat`() {
        hentSykefravær(success = { response1 ->
            response1.data shouldHaveSize VIRKSOMHETER_PER_SIDE

            val faktiskTotal =
                postgresContainer.hentEnkelKolonne<Int>("SELECT count(*) AS faktiskTotal FROM virksomhet")
            VIRKSOMHETER_PER_SIDE shouldBeLessThanOrEqual faktiskTotal

            hentSykefravær(success = { response2 ->
                response2.data shouldHaveAtLeastSize 1
            }, side = "2")
        }, side = "1")
    }

    @Test
    fun `skal kunne hente totalt antall treff for et søk`() {
        hentTotaltAntallTreffISykefravær() shouldBe hentSykefraværForAlleVirksomheter().size
    }


    @Test
    fun `skal kunne filtrere virksomheter basert på sykefraværsprosent`() {
        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.sykefraversprosent shouldBeGreaterThanOrEqual 3.0
            }
        }, sykefraværsprosentFra = "3.0")

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.sykefraversprosent shouldBeLessThanOrEqual 5.0
            }
        }, sykefraværsprosentTil = "5.0")

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { sykefraversstatistikkVirksomhetDto ->
                sykefraversstatistikkVirksomhetDto.sykefraversprosent shouldBeGreaterThanOrEqual 2.0
                sykefraversstatistikkVirksomhetDto.sykefraversprosent shouldBeLessThanOrEqual 6.0
            }
        }, sykefraværsprosentFra = "2.0", sykefraværsprosentTil = "6.0")

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
        }, sykefraværsprosentFra = "", sykefraværsprosentTil = "")
    }

    @Test
    fun `skal kunne søke på bransjeprogram`() {
        val virksomhet = nyVirksomhet(næringer = listOf(Næringsgruppe("Boligbyggelag", "41.101")))
        lastInnNyVirksomhet(nyVirksomhet = virksomhet)
        hentSykefravær(
            bransjeProgram = "${Bransjer.BYGG}",
            success = {
                it.data.size shouldBeGreaterThanOrEqual 1
                it.data.forExactlyOne { it.orgnr shouldBe virksomhet.orgnr }
            }
        )
    }

    @Test
    fun `skal kunne søke på både næringsgrupper og bransjeprogram samtidig`() {
        val virksomhet = nyVirksomhet(næringer = listOf(Næringsgruppe("Boligbyggelag", "41.101")))
        val virksomhet2 = nyVirksomhet(næringer = listOf(Næringsgruppe("Bygging av havne- og damanlegg", "42.910")))
        val virksomhet3 = nyVirksomhet(næringer = listOf(Næringsgruppe("Sykehus et eller annet", "86.101")))

        lastInnNyVirksomhet(virksomhet)
        lastInnNyVirksomhet(virksomhet2)
        lastInnNyVirksomhet(virksomhet3)
        hentSykefravær(
            bransjeProgram = "${Bransjer.BYGG},${Bransjer.SYKEHUS}",
            næringsgrupper = "42",
            success = {
                it.data.size shouldBeGreaterThanOrEqual 3
                it.data.map { virksomhet -> virksomhet.orgnr } shouldContainAll listOf(
                    virksomhet.orgnr,
                    virksomhet2.orgnr,
                    virksomhet3.orgnr
                )
            }
        )
    }

    @Test
    fun `skal kunne filtrere virksomheter basert på antall ansatte`() {
        val ansatteFra = 5
        val ansatteTil = 100
        hentSykefravær(
            success = { response ->
                response.data.forAll {
                    it.antallPersoner shouldBeInRange (ansatteFra..ansatteTil)
                }
            },
            ansatteFra = ansatteFra.toString(),
            ansatteTil = ansatteTil.toString(),
        )
    }


    @Test
    fun `skal kunne filtrere på bare mine virksomheter`() {
        val testBruker1 = oauth2ServerContainer.superbruker1
        val testBruker2 = oauth2ServerContainer.superbruker2
        val ornummer1 = nyttOrgnummer()
        val ornummer2 = nyttOrgnummer()


        listOf(
            Pair(testBruker1, ornummer1),
            Pair(testBruker2, ornummer2)
        ).forEach { (bruker, virksomhet) ->
            opprettSakForVirksomhet(virksomhet, bruker.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = bruker.token)
        }

        hentSykefravær(
            token = testBruker1.token,
            eiere = testBruker1.navIdent,
            success = { response ->
                response.data
                    .forAll {
                        it.eidAv shouldBe testBruker1.navIdent
                    }
            }
        )
        hentSykefravær(
            token = testBruker1.token,
            iaStatus = IAProsessStatus.VURDERES.name,
            success = { response ->
                val sfStatistikk = response.data
                sfStatistikk
                    .forAtLeastOne {
                        it.eidAv shouldBe testBruker1.navIdent
                        it.orgnr shouldBe ornummer1
                    }
                    .forAtLeastOne {
                        it.eidAv shouldBe testBruker2.navIdent
                        it.orgnr shouldBe ornummer2
                    }
            }
        )
    }

    @Test
    fun `søk - skal kunne filtrere på seg selv`() {
        val superbruker1 = oauth2ServerContainer.superbruker1
        val saksbehandler1 = oauth2ServerContainer.saksbehandler1

        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler1.token)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = superbruker1.token)

        val `sykefravær når saksbehandler filterer på seg selv` = hentSykefravær(
            eiere = saksbehandler1.navIdent,
            token = saksbehandler1.token
        ).data
        val `sykefravær når superbruker filtrerer på seg selv` = hentSykefravær(
            eiere = superbruker1.navIdent,
            token = superbruker1.token
        ).data

        `sykefravær når saksbehandler filterer på seg selv`
            .forAll {
                it.eidAv shouldBe saksbehandler1.navIdent
            }
        `sykefravær når superbruker filtrerer på seg selv`
            .forAll {
                it.eidAv shouldBe superbruker1.navIdent
            }
    }

    @Test
    fun `søk - superbruker skal kunne søke på flere eiere samtidig`() {
        val superbruker1 = oauth2ServerContainer.superbruker1
        val saksbehandler1 = oauth2ServerContainer.saksbehandler1
        val saksbehandler2 = oauth2ServerContainer.saksbehandler2

        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler1.token)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler2.token)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = superbruker1.token)

        val `sykefravær når superbruker filterer på seg selv og saksbehandler1` = hentSykefravær(
            eiere = "${superbruker1.navIdent},${saksbehandler1.navIdent}",
            token = superbruker1.token,
        ).data

        `sykefravær når superbruker filterer på seg selv og saksbehandler1`
            .forNone {
                it.eidAv shouldBe saksbehandler2.navIdent
            }
        `sykefravær når superbruker filterer på seg selv og saksbehandler1`
            .forAll {
                listOf(superbruker1.navIdent, saksbehandler1.navIdent) shouldContain it.eidAv
            }
    }

    @Test
    fun `søk - kun superbruker skal kunne filtrere på andre enn seg selv`() {
        val superbruker1 = oauth2ServerContainer.superbruker1
        val saksbehandler1 = oauth2ServerContainer.saksbehandler1

        opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = superbruker1.token)
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler1.token)

        hentSykefravær(
            eiere = saksbehandler1.navIdent,
            token = superbruker1.token
        ).data.forAll {
            it.eidAv shouldBe saksbehandler1.navIdent
        }
    }

    @Test
    fun `søk - om saksbehandler velger en eier utenom seg selv skal det ikke påvirke resultatet`() {
        val superbruker1 = oauth2ServerContainer.superbruker1
        val saksbehandler1 = oauth2ServerContainer.saksbehandler1

        opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = superbruker1.token)
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler1.token)
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = superbruker1.token)
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = superbruker1.token)

        val ufiltrertSykefravær = hentSykefravær(token = saksbehandler1.token).data
        val `sykefravær filtrert på brukeren selv` = hentSykefravær(
            eiere = saksbehandler1.navIdent,
            token = saksbehandler1.token
        ).data
        val `sykefravær filtrert på en annen eier` = hentSykefravær(
            eiere = superbruker1.navIdent,
            token = saksbehandler1.token
        ).data

        `sykefravær filtrert på en annen eier` shouldBe ufiltrertSykefravær
        `sykefravær filtrert på brukeren selv` shouldNotBe ufiltrertSykefravær
    }

    @Test
    fun `tilgangskontroll - alle med tilgangsroller skal kunne hente sykefraværsstatistikk`() {
        hentSykefraværRespons(
            token = mockOAuth2Server.lesebruker.token
        ).statuskode() shouldBe 200
        hentSykefraværRespons(
            token = mockOAuth2Server.saksbehandler1.token
        ).statuskode() shouldBe 200
        hentSykefraværRespons(
            token = mockOAuth2Server.superbruker1.token
        ).statuskode() shouldBe 200
        hentSykefraværRespons(
            token = mockOAuth2Server.brukerUtenTilgangsrolle.token
        ).statuskode() shouldBe 403
    }

    @Test
    fun `tilgangskontroll - alle med tilgangsroller skal kunne hente sykefraværsstatistikk for en virksomhet`() {
        val orgnr = BERGEN.orgnr
        hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.lesebruker.token
        ).statuskode() shouldBe 200
        hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.saksbehandler1.token
        ).statuskode() shouldBe 200
        hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.superbruker1.token
        ).statuskode() shouldBe 200
        hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer = orgnr,
            token = mockOAuth2Server.brukerUtenTilgangsrolle.token
        ).statuskode() shouldBe 403
    }

    @Test
    fun `skal filtrere bort slettede og fjernede virksomheter`() {
        val virksomheterMedSykefravær = hentSykefraværForAlleVirksomheter().map { it.orgnr }
        val endredeVirksomheter = endredeVirksomheter.map { it.orgnr }
        val slettedeOgFjernedeVirksomheter =
            listOf(slettedeVirksomheter, fjernedeVirksomheter).flatten().map { it.orgnr }

        virksomheterMedSykefravær shouldContainAll endredeVirksomheter
        virksomheterMedSykefravær shouldNotContainAnyOf slettedeOgFjernedeVirksomheter
    }

    @Test
    fun `skal returnere sist endret selv om frist har gått ut`() {
        val testKommune = Kommune(navn = "Yoloooo", nummer = "5555")
        val virksomhet =
            lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1)

        // -- lag en sak som er enda eldre
        opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 10)

        hentSykefravær(kommuner = testKommune.nummer).also {
            it.data.single().sistEndret shouldBe sak.endretTidspunkt?.date
        }

    }

    @Test
    fun `skal kunne søke på IKKE_AKTIV status endret når frist har gått ut (og ikke få de opp på de utløpte statusene)`() {
        val testKommune = Kommune(navn = "YoYoYo", nummer = "6666")
        // -- lag en virksomhet med en IkkeAktuell sak som er gått ut på dato
        val virksomhet1 =
            lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        opprettSakForVirksomhet(orgnummer = virksomhet1.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 10)
        // -- lag en virksomhet med en Slettet sak
        val virksomhet2 =
            lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        opprettSakForVirksomhet(orgnummer = virksomhet2.orgnr)
            .slettSak() // Kan ikke sette tilbake tidspunktet på det vi sletter fra databasen
        // -- lag en virksomhet med en Fullført sak som er gått ut på dato
        val virksomhet3 =
            lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        opprettSakForVirksomhet(orgnummer = virksomhet3.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 8)
        // -- lag en virksomhet med en ViBistår sak
        val virksomhet4 =
            lastInnNyVirksomhet(nyVirksomhet = nyVirksomhet(beliggenhet = beliggenhet(kommune = testKommune)))
        opprettSakForVirksomhet(orgnummer = virksomhet4.orgnr)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 7)

        hentSykefravær(kommuner = testKommune.nummer).data
            .also { it.size shouldBe 4 }
        hentSykefravær(kommuner = testKommune.nummer, iaStatus = IAProsessStatus.IKKE_AKTUELL.name).data
            .also { it.size shouldBe 0 }
        hentSykefravær(kommuner = testKommune.nummer, iaStatus = IAProsessStatus.FULLFØRT.name).data
            .also { it.size shouldBe 0 }
        hentSykefravær(kommuner = testKommune.nummer, iaStatus = IAProsessStatus.SLETTET.name).data
            .also { it.size shouldBe 0 } // Ikke en bra test siden SLETTET blir borte fra databasen

        hentSykefravær(kommuner = testKommune.nummer, iaStatus = IAProsessStatus.IKKE_AKTIV.name).data
            .also { it.size shouldBe 3 }
            .forEach {
                it.status shouldBe IAProsessStatus.IKKE_AKTIV
            }
    }

    @Test
    fun `feil i input skal gi 400 Bad request`() {
        hentSykefraværRespons(sykefraværsprosentFra = "-1").statuskode() shouldBe 400
        hentSykefraværRespons(sykefraværsprosentTil = "101").statuskode() shouldBe 400
        hentSykefraværRespons(sykefraværsprosentFra = "NaN").statuskode() shouldBe 400
        hentSykefraværRespons(sykefraværsprosentFra = "aaa").statuskode() shouldBe 400
        hentSykefraværRespons(side = "side").statuskode() shouldBe 400
        hentSykefraværRespons(kvartal = "5").statuskode() shouldBe 400
        hentSykefraværRespons(kvartal = "kvartal").statuskode() shouldBe 400
        hentSykefraværRespons(årstall = "årstall").statuskode() shouldBe 400
        hentSykefraværRespons(ansatteFra = "ansatteFra").statuskode() shouldBe 400
        hentSykefraværRespons(ansatteTil = "ansatteTil").statuskode() shouldBe 400
    }
}

private fun <T> VirksomhetsoversiktDto.matcher(kolonne: String, test: (kolonne: T) -> Unit) {
    test(
        postgresContainer.hentEnkelKolonne<T>("select $kolonne from virksomhet where orgnr = '$orgnr'")
    )
}
