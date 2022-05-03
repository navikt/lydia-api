package no.nav.fia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable
import no.nav.fia.ia.sak.domene.IAProsessStatus
import no.nav.fia.sykefraversstatistikk.api.geografi.Fylke
import no.nav.fia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.fia.virksomhet.domene.Næringsgruppe

@Serializable
data class FilterverdierDto(
    val fylker: List<FylkeOgKommuner>,
    val neringsgrupper: List<Næringsgruppe> = emptyList(),
    val sorteringsnokler: List<String> = Sorteringsnøkkel.alleSorteringsNøkler(),
    val statuser: List<IAProsessStatus> = IAProsessStatus.filtrerbareStatuser()
)

@Serializable
data class FylkeOgKommuner (val fylke: Fylke, val kommuner: List<Kommune>)


