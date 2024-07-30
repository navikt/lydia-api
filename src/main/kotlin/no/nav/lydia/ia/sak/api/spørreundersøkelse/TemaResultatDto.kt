package no.nav.lydia.ia.sak.api.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.oppdatering.SpørsmålResultatMelding
import ia.felles.integrasjoner.kafkameldinger.oppdatering.SvarResultatMelding
import ia.felles.integrasjoner.kafkameldinger.oppdatering.TemaResultatMelding
import kotlinx.serialization.Serializable

@Serializable
data class TemaResultatDto(
    override val temaId: Int,
    override val navn: String,
    override val tema: String?=null,
    override val beskrivelse: String?=null,
    override val spørsmålMedSvar: List<SpørsmålResultatDto>,
) : TemaResultatMelding

@Serializable
data class SpørsmålResultatDto(
    override val spørsmålId: String,
    override val tekst: String,
    override val flervalg: Boolean,
    override val svarListe: List<SvarResultatDto>,
) : SpørsmålResultatMelding

@Serializable
data class SvarResultatDto(
    override val svarId: String,
    override val tekst: String,
    override val antallSvar: Int,
) : SvarResultatMelding
