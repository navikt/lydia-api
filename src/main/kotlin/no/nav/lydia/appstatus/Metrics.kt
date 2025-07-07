package no.nav.lydia.appstatus

import io.ktor.server.response.respond
import io.ktor.server.routing.Routing
import io.ktor.server.routing.get
import io.micrometer.prometheusmetrics.PrometheusConfig
import io.micrometer.prometheusmetrics.PrometheusMeterRegistry
import io.prometheus.metrics.core.metrics.Counter
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene

private const val NAMESPACE = "pia"

class Metrics {
    companion object {
        val appMicrometerRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

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

        fun loggBehovsvurdering(status: SpørreundersøkelseDomene.Status) {
            when (status) {
                SpørreundersøkelseDomene.Status.OPPRETTET -> behovsvurderingerOpprettet.inc()
                SpørreundersøkelseDomene.Status.PÅBEGYNT -> behovsvurderingerStartet.inc()
                SpørreundersøkelseDomene.Status.AVSLUTTET -> behovsvurderingerFullført.inc()
                SpørreundersøkelseDomene.Status.SLETTET -> behovsvurderingerSlettet.inc()
            }
        }

        fun loggEvaluering(status: SpørreundersøkelseDomene.Status) {
            when (status) {
                SpørreundersøkelseDomene.Status.OPPRETTET -> evalueringerOpprettet.inc()
                SpørreundersøkelseDomene.Status.PÅBEGYNT -> evalueringerStartet.inc()
                SpørreundersøkelseDomene.Status.AVSLUTTET -> evalueringerFullført.inc()
                SpørreundersøkelseDomene.Status.SLETTET -> evalueringerSlettet.inc()
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

fun Routing.metrics() {
    get("/metrics") {
        call.respond(Metrics.appMicrometerRegistry.scrape())
    }
}
