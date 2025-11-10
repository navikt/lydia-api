package no.nav.lydia.appstatus

import io.ktor.server.application.log
import io.ktor.server.response.respond
import io.ktor.server.routing.Routing
import io.ktor.server.routing.get
import io.micrometer.prometheusmetrics.PrometheusConfig
import io.micrometer.prometheusmetrics.PrometheusMeterRegistry
import io.prometheus.metrics.core.metrics.Counter
import io.prometheus.metrics.core.metrics.Gauge
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringRepository
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

private const val NAMESPACE = "pia"

class Metrics {
    companion object {
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

        private val antallDokumenterIPubliseringsKø = Gauge.builder()
            .name("${NAMESPACE}_ia_dokumenter_publiseres")
            .help("Antall dokumenter i publiseringskø")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val behovsvurderingerOpprettet: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_opprettet")
            .help("Antall behovsvurderinger opprettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val behovsvurderingerStartet: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_startet")
            .help("Antall behovsvurderinger startet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val behovsvurderingerFullført: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_fullfort")
            .help("Antall behovsvurderinger fullfort")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val behovsvurderingerSlettet: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_behovsvurdering_slettet")
            .help("Antall behovsvurderinger slettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val evalueringerOpprettet: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_evaluering_opprettet")
            .help("Antall evalueringer opprettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val evalueringerStartet: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_evaluering_startet")
            .help("Antall evalueringer startet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val evalueringerFullført: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_evaluering_fullfort")
            .help("Antall evalueringer fullfort")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val evalueringerSlettet: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_evaluering_slettet")
            .help("Antall evalueringer slettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        val virksomheterPrioritert: Counter = Counter.builder()
            .name("${NAMESPACE}_ia_virksomheter_vurdert")
            .help("Antall virksomheter som blir vurdert for ia-samarbeid")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterSattTilBistår = Counter.builder()
            .name("${NAMESPACE}_ia_virksomheter_vi_bistar")
            .help("Antall virksomheter som blir bistått med ia-samarbeid")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val virksomheterFulført = Counter.builder()
            .name("${NAMESPACE}_ia_virksomheter_fulfort")
            .help("Antall virksomheter som har fullført ia-samarbeid")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val iaSakFulgt = Counter.builder()
            .name("${NAMESPACE}_ia_saker_fulgt")
            .help("Antall saker som har blitt fulgt")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val iaSakSluttetÅFølge = Counter.builder()
            .name("${NAMESPACE}_ia_saker_sluttet_a_folge")
            .help("Antall saker som har blitt unfollowed")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        private val samarbeidsplanOpprettet: Counter = Counter.builder()
            .name("${NAMESPACE}_samarbeidsplan_opprettet")
            .help("Antall samarbeidsplan opprettet")
            .withoutExemplars().register(appMicrometerRegistry.prometheusRegistry)

        fun loggHendelse(hendelsesType: IASakshendelseType) {
            when (hendelsesType) {
                IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS -> virksomheterSattTilBistår.inc()
                IASakshendelseType.FULLFØR_BISTAND -> virksomheterFulført.inc()
                else -> {}
            }
        }

        fun loggBehovsvurdering(status: Spørreundersøkelse.Status) {
            when (status) {
                Spørreundersøkelse.Status.OPPRETTET -> behovsvurderingerOpprettet.inc()
                Spørreundersøkelse.Status.PÅBEGYNT -> behovsvurderingerStartet.inc()
                Spørreundersøkelse.Status.AVSLUTTET -> behovsvurderingerFullført.inc()
                Spørreundersøkelse.Status.SLETTET -> behovsvurderingerSlettet.inc()
            }
        }

        fun loggEvaluering(status: Spørreundersøkelse.Status) {
            when (status) {
                Spørreundersøkelse.Status.OPPRETTET -> evalueringerOpprettet.inc()
                Spørreundersøkelse.Status.PÅBEGYNT -> evalueringerStartet.inc()
                Spørreundersøkelse.Status.AVSLUTTET -> evalueringerFullført.inc()
                Spørreundersøkelse.Status.SLETTET -> evalueringerSlettet.inc()
            }
        }

        fun loggFølging(begyntÅFølge: Boolean) {
            if (begyntÅFølge) {
                iaSakFulgt.inc()
            } else {
                iaSakSluttetÅFølge.inc()
            }
        }

        fun loggOpprettSamarbeidsplan(plan: Plan) {
            if (plan.temaer.isNotEmpty()) {
                samarbeidsplanOpprettet.inc()
            }
        }

        fun loggAntallDokumenterIPubliseringsKø(antall: Int) {
            antallDokumenterIPubliseringsKø.set(antall.toDouble())
        }
    }
}

data class ObservedPlan(
    val plan: Plan,
    val hendelsesType: PlanHendelseType,
)

enum class PlanHendelseType {
    OPPRETT,
    OPPDATER,
    ENDRE_STATUS,
}

fun Routing.metrics(dokumentPubliseringRepository: DokumentPubliseringRepository) {
    get("/metrics") {
        val antall = dokumentPubliseringRepository.hentAntallDokumenterIPubliseringsKø()
        call.application.log.info("Metrics endepunk kalt. Antall dokumenter i kø: $antall")
        Metrics.loggAntallDokumenterIPubliseringsKø(
            antall,
        )
        call.respond(Metrics.appMicrometerRegistry.scrape())
    }
}

private fun DokumentPubliseringRepository.hentAntallDokumenterIPubliseringsKø() =
    using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                "SELECT count(*) AS antall FROM dokument_til_publisering",
            ).map { it.int("antall") }.asSingle,
        ) ?: 0
    }
