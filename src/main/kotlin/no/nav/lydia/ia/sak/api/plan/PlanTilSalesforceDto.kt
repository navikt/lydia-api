package no.nav.lydia.ia.sak.api.plan

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus

@Serializable
data class PlanTilSalesforceDto(
    val orgnr: String,
    val saksnummer: String,
    val samarbeid: SamarbeidDto,
    val plan: PlanDto,
)

@Serializable
data class SamarbeidDto(
    val id: Int,
    val navn: String? = null,
    val status: IAProsessStatus? = null,
)
