package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.jsonBody
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.integrasjoner.pdfgen.IASamarbeidDto
import no.nav.lydia.integrasjoner.pdfgen.PdfType
import org.slf4j.Logger
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.utility.DockerImageName
import java.util.TimeZone
import kotlin.test.fail

class PiaPdfgenContainerHelper(
    network: Network,
    log: Logger,
) {
    private val networkAlias = "pia-pdfgen"
    private val port = 8080
    private val baseUrl = "http://$networkAlias:$port"

    val container: GenericContainer<*> = GenericContainer(DockerImageName.parse("ghcr.io/navikt/pia-pdfgen:latest"))
        .withNetwork(network)
        .withExposedPorts(port)
        .withNetworkAliases(networkAlias)
        .withCreateContainerCmdModifier { cmd -> cmd.withName("$networkAlias-${System.currentTimeMillis()}") }
        .waitingFor(
            HostPortWaitStrategy(),
        )
        .withLogConsumer(
            Slf4jLogConsumer(log)
                .withPrefix("pia-pdfgen")
                .withSeparateOutputStreams(),
        )
        .withEnv(
            mapOf(
                "TZ" to TimeZone.getDefault().id,
            ),
        )
        .apply { start() }

    fun envVars(): Map<String, String> =
        mapOf(
            "PIA_PDFGEN_URL" to baseUrl,
        )

    fun hentBistandPdf(bistand: IASamarbeidDto) = hentPdf(PdfType.IA_SAMARBEID, Json.encodeToString<IASamarbeidDto>(bistand))

    private fun hentPdf(
        pdfType: PdfType,
        json: String,
    ): ByteArray =
        container.performPost("/api/v1/genpdf/pia/${pdfType.type}")
            .jsonBody(json)
            .response().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )
}
