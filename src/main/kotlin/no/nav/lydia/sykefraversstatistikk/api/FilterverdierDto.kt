package no.nav.lydia.sykefraversstatistikk.api

import ia.felles.definisjoner.bransjer.Bransjer
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.geografi.Fylke
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor

@Serializable
data class FilterverdierDto(
    val fylker: List<FylkeOgKommuner>,
    val neringsgrupper: List<Næringsgruppe> = emptyList(),
    val bransjeprogram: List<Bransjer> = emptyList(),
    val sorteringsnokler: List<String> = Sorteringsnøkkel.alleSorteringsNøkler(),
    val statuser: List<IAProsessStatus> = IAProsessStatus.filtrerbareStatuser(),
    val filtrerbareEiere: List<EierDTO> = emptyList(),
    val sektorer: List<Sektor> = Sektor.values().asList(),
)

@Serializable
data class FylkeOgKommuner (val fylke: Fylke, val kommuner: List<Kommune>)

@Serializable
data class EierDTO (val navIdent: String, val navn: String)
