package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import no.nav.lydia.ia.sak.MINIMUM_ANTALL_DELTAKERE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvar
import java.util.UUID

data class SpørsmålResultat(
    val spørsmålId: UUID,
    val undertemanavn: String,
    val spørsmåltekst: String,
    val antallDeltakereSomHarSvart: Int,
    val svaralternativer: List<SvaralternativResultat>,
    val flervalg: Boolean,
)

data class SvaralternativResultat(
    val svarId: UUID,
    val svartekst: String,
    val antallSvar: Int,
)

fun Spørsmål.tilResultat(alleSvar: List<SpørreundersøkelseSvar>): SpørsmålResultat {
    val filtrerteSvar = filtrerVekkSvarMedForFåBesvarelser(alleSvar)
    return SpørsmålResultat(
        spørsmålId = this.spørsmålId,
        spørsmåltekst = this.spørsmåltekst,
        flervalg = this.flervalg,
        antallDeltakereSomHarSvart =
            filtrerteSvar.filter { besvarelse ->
                besvarelse.spørsmålId ==
                    this.spørsmålId.toString()
            }.map { it.sesjonId }.distinct().size,
        svaralternativer = this.svaralternativer.map { svar ->
            SvaralternativResultat(
                svarId = svar.svarId,
                svartekst = svar.svartekst,
                antallSvar = filtrerteSvar.filter { besvarelse ->
                    besvarelse.spørsmålId == this.spørsmålId.toString() &&
                        besvarelse.svarIder.contains(svar.svarId.toString())
                }.size,
            )
        },
        undertemanavn = undertemanavn,
    )
}

private fun filtrerVekkSvarMedForFåBesvarelser(alleSvar: List<SpørreundersøkelseSvar>): List<SpørreundersøkelseSvar> {
    val spørsmålMedNokSvar = alleSvar.groupBy { it.spørsmålId }
        .filter { it.value.size >= MINIMUM_ANTALL_DELTAKERE }
        .map { it.key }
    return alleSvar.filter { it.spørsmålId in spørsmålMedNokSvar }
}
