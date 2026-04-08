package no.nav.lydia.ia.årsak.domene

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak.Companion
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak.Companion.GYLDIGE_ÅRSAKER_FOR_FERDIG_VURDERT
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak.Companion.GYLDIGE_ÅRSAKER_FOR_IKKE_AKTUELL
import no.nav.lydia.ia.årsak.domene.GyldigÅrsak.Companion.GYLDIGE_ÅRSAKER_FOR_VURDERES_SENERE

@Serializable
class ValgtÅrsak(
    val type: ÅrsakType,
    val begrunnelser: List<BegrunnelseType>,
    val dato: LocalDate? = null,
)

fun ValgtÅrsak.validerBegrunnelser() =
    begrunnelser.all { begrunnelse ->
        GYLDIGE_ÅRSAKER_FOR_IKKE_AKTUELL.find { årsak -> årsak.type == type }
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

        ÅrsakType.VIRKSOMHETEN_SKAL_VURDERES_SENERE -> {
            begrunnelser.all { begrunnelse ->
                GYLDIGE_ÅRSAKER_FOR_VURDERES_SENERE.find { årsak -> årsak.type == type }
                    ?.begrunnelser
                    ?.map { gyldigBegrunnelse -> gyldigBegrunnelse.type }
                    ?.contains(begrunnelse)
                    ?: false
            }
        }

        ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT -> {
            begrunnelser.all { begrunnelse ->
                GYLDIGE_ÅRSAKER_FOR_FERDIG_VURDERT.find { årsak -> årsak.type == type }
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
