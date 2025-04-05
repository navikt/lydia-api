package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import kotlinx.datetime.Clock.System.now
import no.nav.lydia.Topic
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Endring
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.OppdateringVirksomhet
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.NæringsundergruppeBrreg
import no.nav.lydia.integrasjoner.salesforce.SalesforceInfoResponse
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.virksomhet.VirksomhetSøkeresultat
import no.nav.lydia.virksomhet.api.SALESFORCE_INFO_PATH
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.lydia.virksomhet.domene.Sektor
import java.net.URLEncoder
import java.nio.charset.Charset
import kotlin.test.fail

class VirksomhetHelper {
    companion object {
        fun sendSlettingForVirksomhet(virksomhet: TestVirksomhet) = sendOppdateringForVirksomhet(virksomhet, Sletting)

        fun sendEndringForVirksomhet(virksomhet: TestVirksomhet) = sendOppdateringForVirksomhet(virksomhet, Endring)

        fun sendFjerningForVirksomhet(virksomhet: TestVirksomhet) = sendOppdateringForVirksomhet(virksomhet, Fjernet)

        fun søkEtterVirksomheter(
            søkestreng: String,
            token: String = authContainerHelper.saksbehandler1.token,
            success: (List<VirksomhetSøkeresultat>) -> Unit,
        ) = applikasjon.performGet(
            url = "$VIRKSOMHET_PATH/finn?q=${
                URLEncoder.encode(
                    søkestreng,
                    Charset.defaultCharset(),
                )
            }",
        )
            .authentication().bearer(token)
            .tilListeRespons<VirksomhetSøkeresultat>()
            .third.fold(success = success, failure = { fail(it.message) })

        fun hentVirksomhetsinformasjonRespons(
            orgnummer: String,
            token: String,
        ) = applikasjon.performGet("$VIRKSOMHET_PATH/$orgnummer")
            .authentication().bearer(token)
            .tilSingelRespons<VirksomhetDto>()

        fun hentVirksomhetsinformasjon(
            orgnummer: String,
            token: String = authContainerHelper.saksbehandler1.token,
        ) = hentVirksomhetsinformasjonRespons(orgnummer = orgnummer, token = token)
            .third.fold(
                success = { response -> response },
                failure = { fail(it.message) },
            )

        private fun hentSalesforceInfoRespons(
            orgnummer: String,
            token: String,
        ) = applikasjon.performGet("$SALESFORCE_INFO_PATH/$orgnummer")
            .authentication().bearer(token)
            .tilSingelRespons<SalesforceInfoResponse>()

        fun hentSalesforceInfo(
            orgnummer: String,
            token: String = authContainerHelper.saksbehandler1.token,
        ) = hentSalesforceInfoRespons(orgnummer = orgnummer, token = token)
            .third.fold(
                success = { response -> response },
                failure = { fail(it.message) },
            )

        fun nyttOrgnummer() = lastInnNyVirksomhet().orgnr

        fun lastInnNyVirksomhet(
            nyVirksomhet: TestVirksomhet = TestVirksomhet.nyVirksomhet(),
            sektor: Sektor = Sektor.STATLIG,
            perioder: List<Periode> = listOf(TestData.gjeldendePeriode, TestData.gjeldendePeriode.forrigePeriode()),
            sykefraværsProsent: Double? = null,
        ): TestVirksomhet {
            lastInnTestdata(
                TestData.fraVirksomhet(
                    virksomhet = nyVirksomhet,
                    sektor = sektor,
                    perioder = perioder,
                    sykefraværsProsent = sykefraværsProsent,
                ),
            )
            return nyVirksomhet
        }

        fun lastInnNyeVirksomheter(vararg virksomheter: TestVirksomhet): List<TestVirksomhet> =
            virksomheter.toList()
                .onEach(this::lastInnNyVirksomhet)

        fun lastInnStandardTestdata(antallTestVirksomheter: Int) {
            lastInnTestdata(
                TestData(
                    inkluderStandardVirksomheter = true,
                    antallTilfeldigeVirksomheter = antallTestVirksomheter,
                ),
            )
        }

        fun lastInnTestdata(testData: TestData) {
            kafkaContainerHelper.sendBrregOppdateringer(
                testData.brregVirksomheter.toList().map {
                    it.tilOppdateringVirksomhet(endringstype = BrregVirksomhetEndringstype.Ny)
                },
            )

            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = testData.sykefraværsstatistikkVirksomhetMeldinger().toList(),
                topic = Topic.STATISTIKK_VIRKSOMHET_TOPIC,
            )

            kafkaContainerHelper.sendStatistikkVirksomhetGraderingOgVentTilKonsumert(
                importDtoer = testData.graderingStatistikkVirksomhetKafkaMeldinger().toList(),
                topic = Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
            )

            kafkaContainerHelper.sendStatistikkMetadataVirksomhetIBulkOgVentTilKonsumert(
                testData.sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger().toList(),
            )

            postgresContainerHelper.performUpdate("REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering")
        }

        private fun sendOppdateringForVirksomhet(
            virksomhet: TestVirksomhet,
            endringstype: BrregVirksomhetEndringstype,
        ) {
            kafkaContainerHelper.sendBrregOppdatering(
                virksomhet.tilOppdateringVirksomhet(endringstype),
            )
            postgresContainerHelper.performUpdate("REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering")
        }

        fun TestVirksomhet.genererEndretNavn() = this.navn.reversed()

        private fun TestVirksomhet.tilOppdateringVirksomhet(endringstype: BrregVirksomhetEndringstype) =
            OppdateringVirksomhet(
                orgnummer = this.orgnr,
                oppdateringsid = this.orgnr.toLong() + 1L,
                endringstype = endringstype,
                metadata = BrregVirksomhetDto(
                    organisasjonsnummer = this.orgnr,
                    oppstartsdato = "2023-01-01",
                    navn = this.navn,
                    beliggenhetsadresse = this.beliggenhet,
                    naeringskode1 = NæringsundergruppeBrreg(
                        kode = this.næringsundergruppe1.kode,
                        beskrivelse = this.næringsundergruppe1.navn,
                    ),
                    naeringskode2 = this.næringsundergruppe2?.let {
                        NæringsundergruppeBrreg(
                            kode = this.næringsundergruppe2.kode,
                            beskrivelse = this.næringsundergruppe2.navn,
                        )
                    },
                    naeringskode3 = this.næringsundergruppe3?.let {
                        NæringsundergruppeBrreg(
                            kode = this.næringsundergruppe3.kode,
                            beskrivelse = this.næringsundergruppe3.navn,
                        )
                    },
                ),
                endringstidspunkt = now(),
            )
    }
}
