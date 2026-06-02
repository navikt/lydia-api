package no.nav.lydia.ia.årsak.domene

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak.Companion

@Serializable
class ValgtÅrsak(
    val type: ÅrsakType,
    val begrunnelser: List<BegrunnelseType>,
    val dato: LocalDate? = null,
)

fun ValgtÅrsak.validerBegrunnelserForVurderingAvVirksomhet() =
    type == ÅrsakType.BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET &&
        begrunnelser.size == 1 &&
        begrunnelser.all { begrunnelse ->
            Companion.GYLDIGE_ÅRSAKER_FOR_BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET.find { årsak -> årsak.type == type }
                ?.begrunnelser
                ?.map { gyldigBegrunnelse -> gyldigBegrunnelse.type }
                ?.contains(begrunnelse)
                ?: false
        }

fun ValgtÅrsak.validerBegrunnelserForVurdering() =
    when (type) {
        ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT -> {
            begrunnelser.all { begrunnelse ->
                Companion.GYLDIGE_ÅRSAKER_FOR_VURDERES_PÅ_ET_SENERE_TIDSPUNKT.find { årsak -> årsak.type == type }
                    ?.begrunnelser
                    ?.map { gyldigBegrunnelse -> gyldigBegrunnelse.type }
                    ?.contains(begrunnelse)
                    ?: false
            }
        }

        ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING -> {
            begrunnelser.all { begrunnelse ->
                Companion.GYLDIGE_ÅRSAKER_FOR_FERDIG_VURDERT_MED_INTERN_VURDERING.find { årsak -> årsak.type == type }
                    ?.begrunnelser
                    ?.map { gyldigBegrunnelse -> gyldigBegrunnelse.type }
                    ?.contains(begrunnelse)
                    ?: false
            }
        }

        ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI -> {
            begrunnelser.all { begrunnelse ->
                Companion.GYLDIGE_ÅRSAKER_FOR_FERDIG_VURDERT_OG_TAKKET_NEI.find { årsak -> årsak.type == type }
                    ?.begrunnelser
                    ?.map { gyldigBegrunnelse -> gyldigBegrunnelse.type }
                    ?.contains(begrunnelse)
                    ?: false
            }
        }

        else -> {
            false
        }
    }
