package no.nav.lydia.helper

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.Network

class SalesforceMockContainerHelper(
    val httpMock: HttpMock,
    val network: Network = Network.newNetwork(),
    val log: Logger = LoggerFactory.getLogger(SalesforceMockContainerHelper::class.java)
) {

    init {
        httpMock.wireMockServer.
    }

    fun start() =
        httpMock.start()
}
