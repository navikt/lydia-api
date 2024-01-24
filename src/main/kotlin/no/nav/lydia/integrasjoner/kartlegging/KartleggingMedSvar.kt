package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakKartlegging

@Serializable
data class Svar(
    val svarId: String,
    val tekst: String,
    val antallSvar: Int
)

@Serializable
data class SpørsmålMedSvar(
    val spørsmålId: String,
    val tekst: String,
    val svarListe: List<Svar>
)

@Serializable
data class KartleggingMedSvar(
    val kartleggingId: String,
    val spørsmålMedSvar: List<SpørsmålMedSvar>
) {
    constructor(kartlegging: IASakKartlegging, spørsmålMedSvarListe: List<KartleggingSvarDto>) :
            this(
                kartleggingId = kartlegging.kartleggingId.toString(),
                spørsmålMedSvar = kartlegging.spørsmålOgSvaralternativer.map { spørsmålOgSvaralternativ ->
                    SpørsmålMedSvar(
                        spørsmålId = spørsmålOgSvaralternativ.spørsmålId.toString(),
                        tekst = spørsmålOgSvaralternativ.spørsmåltekst,
                        svarListe = spørsmålOgSvaralternativ.svaralternativer.map { svaralternativ ->
                            Svar(
                                svarId = svaralternativ.svarId.toString(),
                                tekst = svaralternativ.svartekst,
                                antallSvar = spørsmålMedSvarListe.filter { spørsmålOgSvar ->
                                    spørsmålOgSvar.svarId == svaralternativ.svarId.toString()
                                }.size
                            )
                        }
                    )
                }
            )
}