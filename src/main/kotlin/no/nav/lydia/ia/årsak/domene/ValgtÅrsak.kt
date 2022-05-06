package no.nav.lydia.ia.årsak.domene

import kotlinx.serialization.Serializable

@Serializable
class ValgtÅrsak(val type: ÅrsakType, val begrunnelser: List<BegrunnelseType>)
