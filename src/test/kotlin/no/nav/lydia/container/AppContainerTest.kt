package no.nav.lydia.container

import com.github.kittinunf.fuel.core.isSuccessful
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.string.shouldContain
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import kotlin.test.Test
import kotlin.test.fail

class AppContainerTest {
    @Test
    fun `kaller isAlive`() {
        val (_, response, _) = applikasjon.performGet("internal/isalive")
            .responseString()

        assert(response.isSuccessful)
    }

    @Test
    fun `lydia skal ha satt opp databasen`() {
        val databaseErSattOpp = postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT EXISTS(
                SELECT * 
                     FROM INFORMATION_SCHEMA.TABLES 
                     WHERE TABLE_SCHEMA = 'public' 
                     AND  TABLE_NAME = 'sykefravar_statistikk_virksomhet'
                )
            """.trimIndent(),
        )
        databaseErSattOpp.shouldBeTrue()
    }

    @Test
    fun `lydia skal kunne gi oss metrikker`() {
        val (_, response, result) = applikasjon.performGet("metrics")
            .responseString()

        assert(response.isSuccessful)
        result.fold(
            success = { metrikker ->
                metrikker shouldContain "process_cpu_usage"
                metrikker shouldContain "jvm_memory_used_bytes"
                metrikker shouldContain "ktor_http_server_requests_active"
                metrikker shouldContain "hikaricp_connections_acquire_seconds_count"
            },
            failure = {
                fail("")
            },
        )
    }

    @Test
    fun `skal få egendefinerte metrikker`() {
        val (_, response, result) = applikasjon.performGet("metrics")
            .responseString()

        assert(response.isSuccessful)
        result.fold(
            success = { metrikker ->
                metrikker shouldContain "ia_virksomheter_vurdert_total"
                metrikker shouldContain "ia_virksomheter_vi_bistar_total"
                metrikker shouldContain "ia_virksomheter_fulfort_total"
                metrikker shouldContain "ia_behovsvurdering_opprettet_total"
                metrikker shouldContain "ia_behovsvurdering_startet_total"
                metrikker shouldContain "ia_behovsvurdering_fullfort_total"
                metrikker shouldContain "ia_behovsvurdering_slettet_total"
                metrikker shouldContain "ia_evaluering_opprettet_total"
                metrikker shouldContain "ia_evaluering_startet_total"
                metrikker shouldContain "ia_evaluering_fullfort_total"
                metrikker shouldContain "ia_evaluering_slettet_total"
                metrikker shouldContain "ia_saker_fulgt_total"
                metrikker shouldContain "ia_saker_sluttet_a_folge_total"
                metrikker shouldContain "samarbeidsplan_opprettet_total"
                metrikker shouldContain "ia_dokumenter_publiseres"
            },
            failure = {
                fail("")
            },
        )
    }
}
