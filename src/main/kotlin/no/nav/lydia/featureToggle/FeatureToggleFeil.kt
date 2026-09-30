package no.nav.lydia.featureToggle

import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil

object FeatureToggleFeil {
    val `feature toggle finnes ikke` = Feil("Feature toggle finnes ikke", HttpStatusCode.NotFound)
}
