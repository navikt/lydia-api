package no.nav.lydia.container

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.TestContainerHelper
import org.junit.Test
import org.openqa.selenium.By

class GuiTest {
    val driver = TestContainerHelper.chromeWebDriverContainer.webDriver

    @Test
    fun testKotlinOrg() {
        // Visit kotlinlang.org website
        driver.get("http://${TestContainerHelper.frackendNetworkAlias}:${TestContainerHelper.frackendPort}")

        // Find element with "global-header-logo" class name
        val element = driver.findElement(By.className("global-header-logo"))

        // Test, if the found element's text is "Kotlin"
        element.text shouldBe "Kotlin"
    }
}