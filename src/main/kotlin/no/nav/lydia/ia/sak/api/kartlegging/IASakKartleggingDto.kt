package no.nav.lydia.ia.sak.api.kartlegging

import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import java.util.UUID

@Serializable
data class IASakKartleggingDto (
    val id: String,
    val status: String,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>
)

fun List<IASakKartlegging>.toDto() = map { it.toDto() }
fun IASakKartlegging.toDto() = IASakKartleggingDto(
    id = id.toString(),
    status = status,
    spørsmålOgSvaralternativer = spørsmålOgSvaralternativerTest
)

// -- for test
private val spørsmålOgSvaralternativerTest = listOf(
    SpørsmålOgSvaralternativerDto(
        id = UUID.randomUUID().toString(),
        spørsmål = "Hvilke av disse faktorene tror du har størst innflytelse på sykefraværet der du jobber?",
        kategori = "PARTSSAMARBEID",
        svaralternativer = listOf(
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Arbeidsbelstning"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Arbeidstid"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Arbeidsforhold"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Ledelse"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Noe annet"),
        )
    ),
    SpørsmålOgSvaralternativerDto(
        id = UUID.randomUUID().toString(),
        spørsmål = "Velg det tiltaket som du mener best kan bidra til å forebygge sykefraværet",
        kategori = "PARTSSAMARBEID",
        svaralternativer = listOf(
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Bedre oppfølging av ansatte"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Tilrettelegging av arbeidsoppgaver"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Kompetanseutvikling"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Helsefremmende aktiviteter"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Noe annet"),
        )
    ),
    SpørsmålOgSvaralternativerDto(
        id = UUID.randomUUID().toString(),
        spørsmål = "Vi har kunnskap og ferdigheter til å gjennomføre forbedringstiltak i virksomheten (planlegge tiltak, gjennomføre og evaluere måloppnåelse)",
        kategori = "PARTSSAMARBEID",
        svaralternativer = listOf(
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Helt uening"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Litt uening"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Litt enig"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Veldig enig"),
            SvaralternativDto(id = UUID.randomUUID().toString(), tekst = "Vet ikke"),
        )
    )
)
//
