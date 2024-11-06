package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.jsonBody
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.integrasjoner.pdfgen.IASamarbeidDto
import no.nav.lydia.integrasjoner.pdfgen.PdfType
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HostPortWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.util.TimeZone
import kotlin.test.fail

class PiaPdfgenContainerHelper(
    network: Network = Network.newNetwork(),
    log: Logger = LoggerFactory.getLogger(PiaPdfgenContainerHelper::class.java),
) {
    val piaPdfgenContainer: GenericContainer<*>
    val piaPdfgenNetworkAlias = "pia-pdfgen"
    val port = "8080"
    val baseUrl = "http://$piaPdfgenNetworkAlias:$port"

    init {
        piaPdfgenContainer = GenericContainer(
            ImageFromDockerfile().withDockerfileFromBuilder { builder ->
                builder.from("ghcr.io/navikt/pia-pdfgen:v1.0.0-rc.4")
                    .env(
                        mapOf(
                            "TZ" to TimeZone.getDefault().id,
                        ),
                    )
            },
        )
            .withLogConsumer(Slf4jLogConsumer(log).withPrefix("pia-pdfgen").withSeparateOutputStreams())
            .withNetwork(network)
            .withExposedPorts(port.toInt())
            .withNetworkAliases(piaPdfgenNetworkAlias)
            .withCreateContainerCmdModifier { cmd -> cmd.withName("$piaPdfgenNetworkAlias-${System.currentTimeMillis()}") }
            .waitingFor(
                HostPortWaitStrategy(),
            ).apply {
                start()
            }
    }

    fun envVars(): Map<String, String> =
        mapOf(
            "PIA_PDFGEN_URL" to baseUrl,
        )

    fun hentBistandPdf(bistand: IASamarbeidDto) = hentPdf(PdfType.IA_SAMARBEID, Json.encodeToString<IASamarbeidDto>(bistand))

    private fun hentPdf(
        pdfType: PdfType,
        json: String,
    ): ByteArray =
        piaPdfgenContainer.performPost("/api/v1/genpdf/pia/${pdfType.type}")
            .jsonBody(json)
            .response().third.fold(
                success = { it },
                failure = { fail(it.message) },
            )
}
