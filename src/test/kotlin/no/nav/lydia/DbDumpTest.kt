package no.nav.lydia

import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldStartWith
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørsmålDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.TemaDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import org.junit.experimental.categories.Category
import java.util.UUID
import kotlin.test.Test

class DbDumpTest {
    @Category(CommandLineOnlyTest::class) // OBS: ikke fjern denne ellers vil denne testen kjøre i CI (GitHub actions)
    @Test
    fun createTestDump() {
        VirksomhetHelper.lastInnStandardTestdata(200)

        opprettVirksomheterIForskjelligeStatuser()

        opprettVirksomhetMedBehovsvurderinger()

        val jdbcUrl = postgresContainerHelper.dataSource.jdbcUrl
        jdbcUrl shouldStartWith "jdbc:postgresql"
        val portOgDbNavn = getPortAndDBnameFromJdbcUrl(jdbcUrl)
        val port = portOgDbNavn.first
        val database = portOgDbNavn.second

        ProcessBuilder("./dump_local_container_db.sh", port, database, "localhost")
            .redirectOutput(ProcessBuilder.Redirect.INHERIT)
            .start()
            .waitFor()
    }

    private fun opprettVirksomhetMedBehovsvurderinger() {
        val orgnr = "123459876"
        lastInnNyVirksomhet(nyVirksomhet = TestVirksomhet.nyVirksomhet(orgnr = orgnr, navn = "SPENSTIG KATTEDYR"))
        val sak = SakHelper.nySakIViBistår(orgnummer = orgnr, navnPåSamarbeid = "Avdeling Pusekatt")

        // -- behovsvurdering, kun opprettet
        sak.opprettBehovsvurdering()

        // -- startet behovsvurdering
        sak.opprettBehovsvurdering().start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        // -- fullført behovsvurdering alle temaer besvart med for få svar
        sak.behovsvurderingAlleSpørsmålBesvart(antallSvarPåSpørsmål = 1)

        // -- fullført behovsvurdering alle temaer besvart med 3 svar
        sak.behovsvurderingAlleSpørsmålBesvart(antallSvarPåSpørsmål = 3)

        // -- fullført behovsvurdering alle temaer besvart med 10 svar
        sak.behovsvurderingAlleSpørsmålBesvart(antallSvarPåSpørsmål = 10)

        // -- fullført behovsvurdering kun ett tema full besvart
        sak.behovsvurderingFørsteTemaBesvart(antallSvarPåSpørsmål = 10)

        // -- fullført behovsvurdering med andre tema halvt besvart
        sak.behovsvurderingMedHalvtBesvartTema(antallSvarPåSpørsmål = 10)

        sak.leggTilFolger(TestContainerHelper.authContainerHelper.saksbehandler3.token)
    }

    private fun IASakDto.behovsvurderingMedHalvtBesvartTema(antallSvarPåSpørsmål: Int = 3) {
        val sesjonsIder = (1..antallSvarPåSpørsmål).map { UUID.randomUUID().toString() }
        val behovsvurdering = this.opprettBehovsvurdering()
        behovsvurdering.start(orgnummer = orgnr, saksnummer = this.saksnummer)
        besvarSpørsmålITemaer(listOf(behovsvurdering.temaer.first()), sesjonsIder, behovsvurdering.id)
        besvarSpørsmålITemaer(listOf(behovsvurdering.temaer[1]), sesjonsIder, behovsvurdering.id) {
            it.chunked(it.size / 2).first()
        }
        behovsvurdering.avslutt(orgnummer = orgnr, saksnummer = this.saksnummer)
    }

    private fun IASakDto.behovsvurderingFørsteTemaBesvart(antallSvarPåSpørsmål: Int = 3) {
        behovsVurderingMedTemaerBesvart(antallSvarPåSpørsmål) { it.temaer.take(1) }
    }

    private fun IASakDto.behovsvurderingAlleSpørsmålBesvart(antallSvarPåSpørsmål: Int = 3) {
        behovsVurderingMedTemaerBesvart(antallSvarPåSpørsmål) { it.temaer }
    }

    private fun IASakDto.behovsVurderingMedTemaerBesvart(
        antallSvarPåSpørsmål: Int,
        block: (SpørreundersøkelseDto) -> List<TemaDto>,
    ) {
        val sesjonsIder = (1..antallSvarPåSpørsmål).map { UUID.randomUUID().toString() }
        val behovsvurdering = this.opprettBehovsvurdering()
        behovsvurdering.start(orgnummer = orgnr, saksnummer = this.saksnummer)
        besvarSpørsmålITemaer(block(behovsvurdering), sesjonsIder, behovsvurdering.id)
        behovsvurdering.avslutt(orgnummer = orgnr, saksnummer = this.saksnummer)
    }

    private fun besvarSpørsmålITemaer(
        temaer: List<TemaDto>,
        sesjonsIder: List<String>,
        spørreundersøkelseId: String,
        filter: (List<SpørsmålDto>) -> List<SpørsmålDto> = { it },
    ) {
        temaer.forEach { temaDto ->
            filter(temaDto.spørsmålOgSvaralternativer).forEach { spørsmålDto ->
                sesjonsIder.forEach { sesjonId ->
                    IASakKartleggingHelper.sendKartleggingSvarTilKafka(
                        kartleggingId = spørreundersøkelseId,
                        spørsmålId = spørsmålDto.id,
                        sesjonId = sesjonId,
                        svarIder = listOf(spørsmålDto.svaralternativer.random().svarId),
                    )
                }
            }
        }
    }

    private fun opprettVirksomheterIForskjelligeStatuser() {
        listOf(
            TestContainerHelper.authContainerHelper.saksbehandler1.token,
            TestContainerHelper.authContainerHelper.saksbehandler2.token,
        ).forEach { token ->
            // -- Prioritert virksomhet
            SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())

            // -- Prioritert virksomhet eierskap tatt
            SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())
                .nyHendelse(TA_EIERSKAP_I_SAK, token = token)

            // -- Virksomhet kontaktes
            SakHelper.nySakIKontaktes(token = token)

            // -- Virksomhet kartlegges
            SakHelper.nySakIKartlegges(token = token)

            // -- Virksomhet biståes med ett samarbeid
            SakHelper.nySakIViBistår(token = token)
        }
    }

    @Test
    fun `finner port og db navn fra en Jdbc url`() {
        val jdbcUrl = "jdbc:postgresql://localhost:49255/lydia-api-container-db?loggerLevel=OFF"
        val results = getPortAndDBnameFromJdbcUrl(jdbcUrl)

        results.first shouldBe "49255"
        results.second shouldBe "lydia-api-container-db"
    }

    companion object {
        fun getPortAndDBnameFromJdbcUrl(jdbcUrl: String): Pair<String?, String?> {
            val regex = """jdbc:postgresql://localhost:(?<port>\d+)/(?<db>([a-z-]+)+)\?*""".toRegex()
            val matchResult = regex.find(jdbcUrl)!!

            val port = matchResult.groups["port"]?.value
            val db = matchResult.groups["db"]?.value

            return Pair(port, db)
        }
    }
}
