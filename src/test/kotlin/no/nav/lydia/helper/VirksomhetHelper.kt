package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import kotlinx.datetime.Clock.System.now
import no.nav.lydia.Kafka
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Endring
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.OppdateringVirksomhet
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.NæringsundergruppeBrreg
import no.nav.lydia.integrasjoner.salesforce.SalesforceUrlResponse
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.virksomhet.VirksomhetSøkeresultat
import no.nav.lydia.virksomhet.api.SALESFORCE_LENKE_PATH
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.VirksomhetDto
import no.nav.lydia.virksomhet.domene.Sektor
import java.net.URLEncoder
import java.nio.charset.Charset
import kotlin.test.fail

class VirksomhetHelper {
    companion object {
        fun sendSlettingForVirksomhet(virksomhet: TestVirksomhet) =
            sendOppdateringForVirksomhet(virksomhet, Sletting)

        fun sendEndringForVirksomhet(virksomhet: TestVirksomhet) =
            sendOppdateringForVirksomhet(virksomhet, Endring)

        fun sendFjerningForVirksomhet(virksomhet: TestVirksomhet) =
            sendOppdateringForVirksomhet(virksomhet, Fjernet)

        fun søkEtterVirksomheter(
            søkestreng: String,
            token: String = TestContainerHelper.oauth2ServerContainer.saksbehandler1.token,
            success: (List<VirksomhetSøkeresultat>) -> Unit,
        ) =
            TestContainerHelper.lydiaApiContainer.performGet(url = "$VIRKSOMHET_PATH/finn?q=${
                URLEncoder.encode(
                    søkestreng,
                    Charset.defaultCharset()
                )
            }")
                .authentication().bearer(token)
                .tilListeRespons<VirksomhetSøkeresultat>()
                .third.fold(success = success, failure = { fail(it.message) })

        fun hentVirksomhetsinformasjonRespons(orgnummer: String, token: String) =
            TestContainerHelper.lydiaApiContainer.performGet("$VIRKSOMHET_PATH/$orgnummer")
                .authentication().bearer(token)
                .tilSingelRespons<VirksomhetDto>()

        fun hentVirksomhetsinformasjon(
            orgnummer: String,
            token: String = TestContainerHelper.oauth2ServerContainer.saksbehandler1.token) =
            hentVirksomhetsinformasjonRespons(orgnummer = orgnummer, token = token)
                .third.fold(
                    success = { response -> response },
                    failure = { fail(it.message) }
                )

        fun hentSalesforceUrlRespons(orgnummer: String, token: String) =
            TestContainerHelper.lydiaApiContainer.performGet("$SALESFORCE_LENKE_PATH/$orgnummer")
                .authentication().bearer(token)
                .tilSingelRespons<SalesforceUrlResponse>()

        fun hentSalesforceUrl(
            orgnummer: String,
            token: String = TestContainerHelper.oauth2ServerContainer.saksbehandler1.token) =
            hentSalesforceUrlRespons(orgnummer = orgnummer, token = token)
                .third.fold(
                    success = { response -> response },
                    failure = { fail(it.message) }
                )

        fun nyttOrgnummer() = lastInnNyVirksomhet().orgnr

        fun lastInnNyVirksomhet(
            nyVirksomhet: TestVirksomhet = TestVirksomhet.nyVirksomhet(),
            sektor: Sektor = Sektor.STATLIG,
            perioder: List<Periode> = listOf(TestData.gjeldendePeriode, TestData.gjeldendePeriode.forrigePeriode()),
            sykefraværsProsent: Double? = null
        ): TestVirksomhet {
            lastInnTestdata(TestData.fraVirksomhet(
                virksomhet = nyVirksomhet,
                sektor = sektor,
                perioder = perioder,
                sykefraværsProsent = sykefraværsProsent
            ))
            return nyVirksomhet
        }

        fun lastInnNyeVirksomheter(vararg virksomheter: TestVirksomhet): List<TestVirksomhet> {
            return virksomheter.toList()
                .onEach(this::lastInnNyVirksomhet)
        }

        fun lastInnStandardTestdata() {
            lastInnTestdata(TestData(inkluderStandardVirksomheter = true, antallTilfeldigeVirksomheter = 500))
        }

        fun lastInnTestdata(testData: TestData) {
            kafkaContainerHelper.sendBrregOppdateringer(
                testData.brregVirksomheter.toList().map {
                    it.tilOppdateringVirksomhet(endringstype = BrregVirksomhetEndringstype.Ny)
                }
            )

            kafkaContainerHelper.sendSykefraversstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = testData.sykefraværsstatistikkVirksomhetMeldinger().toList(),
                topic = KafkaContainerHelper.statistikkVirksomhetTopic,
                groupId = Kafka.statistikkVirksomhetGroupId
            )

            kafkaContainerHelper.sendStatistikkVirksomhetGraderingOgVentTilKonsumert(
                    importDtoer = testData.graderingStatistikkVirksomhetKafkaMeldinger().toList(),
                    topic = KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
                    groupId = Kafka.statistikkVirksomhetGraderingGroupId
            )

            kafkaContainerHelper.sendStatistikkMetadataVirksomhetIBulkOgVentTilKonsumert(
                testData.sykefraværsstatistikkMetadataVirksomhetKafkaMeldinger().toList()
            )

            TestContainerHelper.postgresContainer.performUpdate("REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering")
        }

        private fun sendOppdateringForVirksomhet(
            virksomhet: TestVirksomhet,
            endringstype: BrregVirksomhetEndringstype
        ) {
            kafkaContainerHelper.sendBrregOppdatering(
                virksomhet.tilOppdateringVirksomhet(endringstype)
            )
            TestContainerHelper.postgresContainer.performUpdate("REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering")
        }

        fun TestVirksomhet.genererEndretNavn() = this.navn.reversed()

        fun TestVirksomhet.tilOppdateringVirksomhet(endringstype: BrregVirksomhetEndringstype) =
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
                        beskrivelse = this.næringsundergruppe1.navn
                    ),
                    naeringskode2 = this.næringsundergruppe2?.let {
                        NæringsundergruppeBrreg(
                            kode = this.næringsundergruppe2.kode,
                            beskrivelse = this.næringsundergruppe2.navn
                        )
                    },
                    naeringskode3 = this.næringsundergruppe3?.let {
                        NæringsundergruppeBrreg(
                            kode = this.næringsundergruppe3.kode,
                            beskrivelse = this.næringsundergruppe3.navn
                        )
                    },
                ),
                endringstidspunkt = now()
            )
    }
}
