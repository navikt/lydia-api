package no.nav.lydia.ia.årsak.domene

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak.Companion.GYLDIGE_ÅRSAKER_FOR_IKKE_AKTUELL

@Serializable
class ValgtÅrsak(val type: ÅrsakType, val begrunnelser: List<BegrunnelseType>)

fun ValgtÅrsak.validerBegrunnelser() =
    begrunnelser.all {
        GYLDIGE_ÅRSAKER_FOR_IKKE_AKTUELL.find { it.type == type }?.begrunnelser?.map { it.type }?.contains(it) ?: false
    }
