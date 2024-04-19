package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.kartlegging.SpørreundersøkelseAntallSvarDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedSpørsmålOgSvar

class ResultaterForTema(
	spørreundersøkelseId: String,
	resultaterForTema: TemaMedSpørsmålOgSvar
): SpørreundersøkelseOppdatering<TemaMedSpørsmålOgSvar>(
	spørreundersøkelseId = spørreundersøkelseId,
	oppdateringsType = OppdateringsType.RESULTATER_FOR_TEMA,
	data = resultaterForTema
)

class AntallSvar(
	spørreundersøkelseId: String,
	antallSvar: SpørreundersøkelseAntallSvarDto
): SpørreundersøkelseOppdatering<SpørreundersøkelseAntallSvarDto>(
	spørreundersøkelseId = spørreundersøkelseId,
	oppdateringsType = OppdateringsType.ANTALL_SVAR,
	data = antallSvar
)

@Serializable
sealed class SpørreundersøkelseOppdatering<T>(
	val spørreundersøkelseId: String,
	val oppdateringsType: OppdateringsType,
	val data: T
) {
	fun tilNøkkel() =
		Json.encodeToString(SpørreundersøkelseOppdateringNøkkel(spørreundersøkelseId ,oppdateringsType))
	fun tilMelding() =
		when(this) {
			is ResultaterForTema -> Json.encodeToString(data)
			is AntallSvar -> Json.encodeToString(data)
		}
}

@Serializable
data class SpørreundersøkelseOppdateringNøkkel(
	val spørreundersøkelseId: String,
	val oppdateringsType: OppdateringsType
)

enum class OppdateringsType {
	RESULTATER_FOR_TEMA,
	ANTALL_SVAR
}