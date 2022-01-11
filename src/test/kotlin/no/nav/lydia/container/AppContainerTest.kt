package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import org.testcontainers.containers.GenericContainer
import org.testcontainers.images.builder.ImageFromDockerfile
import kotlin.io.path.Path
import kotlin.test.Test

class AppContainerTest {
    private val container = GenericContainer(ImageFromDockerfile()
        .withDockerfile(Path("./Dockerfile")))
        .withExposedPorts(8080)
        .apply {
            start()
        }

    @Test
    fun `Starter docker`() {
        assert(container.isRunning)
    }

    @Test
    fun `Kaller isAlive`() {
        val (_, response, _) = "http://${container.host}:${container.getMappedPort(8080)}/isAlive"
            .httpGet()
            .responseString()

        assert(response.isSuccessful)
    }
}