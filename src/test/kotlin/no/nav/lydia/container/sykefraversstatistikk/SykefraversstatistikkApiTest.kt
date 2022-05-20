package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.responseObject
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.*
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
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhet
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetRespons
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværRespons
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestVirksomhet.Companion.BERGEN
import no.nav.lydia.helper.TestVirksomhet.Companion.KOMMUNE_OSLO
import no.nav.lydia.helper.TestVirksomhet.Companion.SCENEKUNST
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_STATUSFILTER
import no.nav.lydia.helper.localDateTimeTypeAdapter
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.*
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.VIRKSOMHETER_PER_SIDE
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkApiTest {
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer
    private val mockOAuth2Server = TestContainerHelper.oauth2ServerContainer

    @Test
    fun `skal kunne hente sykefraværsstatistikk for en enkelt bedrift`() {
        val orgnr = BERGEN.orgnr
        hentSykefraværForVirksomhet(orgnummer = orgnr)
            .also { it.size shouldBeGreaterThanOrEqual 1 }
            .forEach {
                it.orgnr shouldBe orgnr
                it.kvartal shouldBeOneOf listOf(1, 2, 3, 4)
                it.kommune.navn shouldBe BERGEN.beliggenhet?.kommune
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
    fun `frontend skal kunne hente filterverdier til prioriteringssiden`() {
        val (_, _, result) = lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
            .authentication().bearer(mockOAuth2Server.saksbehandler1.token)
            .responseObject<FilterverdierDto>(localDateTimeTypeAdapter)

        result.fold(
            success = { filterverdier ->
                filterverdier.fylker[0].fylke.navn shouldBe "Oslo"
                filterverdier.fylker[0].fylke.nummer shouldBe "03"
                filterverdier.fylker[0].kommuner.size shouldBe 1
                filterverdier.neringsgrupper.find { it.kode == Næringsgruppe.UOPPGITT.kode }
                    .shouldNotBeNull() // Vi forventer en næringsgruppe av verdien Uoppgitt med kode 00.000
                filterverdier.neringsgrupper.size shouldBeGreaterThan 1
                filterverdier.neringsgrupper.all { næringsgruppe -> næringsgruppe.kode.length == 6 }.shouldBeTrue()
                filterverdier.statuser shouldBe IAProsessStatus.filtrerbareStatuser()
            }, failure = { fail(it.message) })
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
                testVirksomhet.kommune.navn shouldBe virksomhet.beliggenhet?.kommune
                testVirksomhet.kommune.nummer shouldBe virksomhet.beliggenhet?.kommunenummer
            }
        }, kommuner = kommunenummer)
    }

    @Test
    fun `skal kunne hente alle virksomheter i Vestland fylke`() {
        val fylkesnummer = "46"

        hentSykefravær(success = { response ->
            response.data shouldHaveAtLeastSize 1
            response.data.forAll { testVirksomhet ->
                testVirksomhet.kommune.navn shouldBe BERGEN.beliggenhet?.kommune
                testVirksomhet.kommune.nummer shouldStartWith fylkesnummer
            }
        }, fylker = fylkesnummer)
    }

    @Test
    fun `skal kunne hente alle virksomheter i et gitt fylke og en gitt kommune`() {
        val fylkesnummer = "46" // Vestland fylke
        val kommunenummer = "0301" // Oslo kommune

        hentSykefravær(success = { response ->
            response.data.forAll {
                setOf("46", "03").forAtLeastOne { fylke ->
                    it.kommune.nummer.substring(0..1) shouldBe fylke
                }
            }
        }, kommuner = kommunenummer, fylker = fylkesnummer)
    }

    @Test
    fun `skal kunne hente alle virksomheter i en gitt næring`() {
        hentSykefravær(success = { response ->
            response.data.forAll {
                postgresContainer.performQuery("""
                        SELECT * FROM virksomhet AS v JOIN virksomhet_naring AS vn ON (v.id = vn.virksomhet)
                        WHERE v.orgnr = '${it.orgnr}' AND vn.narings_kode = '${SCENEKUNST.kode}'
                    """.trimIndent()
                ).row shouldBe 1
            }
        }, næringsgrupper = SCENEKUNST.kode)
    }

    @Test
    fun `tomme søkeparametre skal ikke filtrere på noen parametre`() {
        val resultatMedTommeParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/?neringsgrupper=&fylker=&kommuner=")
                .authentication().bearer(mockOAuth2Server.saksbehandler1.token)
                .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(localDateTimeTypeAdapter).third


        val resultatUtenParametre =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/")
                .authentication().bearer(mockOAuth2Server.saksbehandler1.token)
                .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(localDateTimeTypeAdapter).third

        resultatMedTommeParametre.get().data shouldContainAll resultatUtenParametre.get().data
    }

    @Test
    fun `skal kunne hente virksomheter filtrert på kommune og næring`() {
        val oslo = "0301"
        val nordreFollo = "3020"

        hentSykefravær(
            success = { response ->
                response.data shouldHaveAtLeastSize 1
                response.data.forAll {
                    listOf(oslo, nordreFollo).forAtLeastOne { knr ->
                        it.kommune.nummer shouldBe knr
                    }
                }
            },
            kommuner = "$oslo,$nordreFollo",
            næringsgrupper = "${SCENEKUNST.kode},${BEDRIFTSRÅDGIVNING.kode}",
            token = mockOAuth2Server.saksbehandler1.token
        )
    }

    @Test
    fun `skal bare få statistikk for siste periode hvis periode er uspesifisert`() {
        val gjeldendePeriode = Periode.gjeldendePeriode()
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
        val forrigePeriode = Periode.forrigePeriode()
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
            .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(
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
        hentSykefravær(success = { response ->
            val total = response.total
            total shouldBeGreaterThan VIRKSOMHETER_PER_SIDE
            response.data shouldHaveSize VIRKSOMHETER_PER_SIDE

            val faktiskTotal = postgresContainer.performQuery("SELECT count(*) AS faktiskTotal FROM virksomhet")
                .getInt("faktiskTotal")
            total shouldBeLessThanOrEqual faktiskTotal

            val antallSider = total/50
            (2..antallSider).map { it.toString() }.forEach { side ->
                hentSykefravær(success = { response ->
                    response.total shouldBeGreaterThan VIRKSOMHETER_PER_SIDE
                    response.data shouldHaveAtLeastSize 1
                }, side = side)
            }
        }, side = "1")
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
    fun `skal ikke kunne hente sykefravær for navenheter`() {
        hentSykefravær(success = {
            it.data.map { it.orgnr } shouldNotContain TestVirksomhet.NAV_KONTOR.orgnr
            val rs = postgresContainer.performQuery("select * from sykefravar_statistikk_virksomhet where orgnr = '${TestVirksomhet.NAV_KONTOR.orgnr}'")
            rs.row shouldBe 1
        }, ansatteFra = "999", kommuner = "${KOMMUNE_OSLO.nummer}}")
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
    fun `tilgangskontroll - alle med tilgangsroller skal kunne hente sykefraværsstatistikk`() {
        hentSykefraværRespons(token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
        hentSykefraværRespons(token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
        hentSykefraværRespons(token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
        hentSykefraværRespons(token = mockOAuth2Server.brukerUtenTilgangsrolle.token).statuskode() shouldBe 403
    }

    @Test
    fun `tilgangskontroll - alle med tilgangsroller skal kunne hente sykefraværsstatistikk for en virksomhet`() {
        val orgnr = BERGEN.orgnr
        hentSykefraværForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.lesebruker.token).statuskode() shouldBe 200
        hentSykefraværForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.saksbehandler1.token).statuskode() shouldBe 200
        hentSykefraværForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.superbruker1.token).statuskode() shouldBe 200
        hentSykefraværForVirksomhetRespons(orgnummer = orgnr, token = mockOAuth2Server.brukerUtenTilgangsrolle.token).statuskode() shouldBe 403
    }
}
