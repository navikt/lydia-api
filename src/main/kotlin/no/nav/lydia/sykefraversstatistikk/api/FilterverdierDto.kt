package no.nav.lydia.sykefraversstatistikk.api

import ia.felles.definisjoner.bransjer.Bransjer
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.geografi.Fylke
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.virksomhet.domene.Næringsgruppe

@Serializable
data class FilterverdierDto(
    val fylker: List<FylkeOgKommuner>,
    val neringsgrupper: List<Næringsgruppe> = emptyList(),
    val bransjeProgram: List<Bransjer> = emptyList(),
    val sorteringsnokler: List<String> = Sorteringsnøkkel.alleSorteringsNøkler(),
    val statuser: List<IAProsessStatus> = IAProsessStatus.filtrerbareStatuser()
)

@Serializable
data class FylkeOgKommuner (val fylke: Fylke, val kommuner: List<Kommune>)


