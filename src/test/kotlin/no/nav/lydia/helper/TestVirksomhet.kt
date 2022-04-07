package no.nav.lydia.helper

import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.random.Random

class TestVirksomhet(
    val orgnr: String,
    val navn: String,
    val næringsgrupper: List<Næringsgruppe>,
    val beliggenhet: Beliggenhetsadresse?
) {
    val næringskode1 = næringsgrupper.first()
    val næringskode2 = næringsgrupper.getOrNull(1)
    val næringskode3 = næringsgrupper.getOrNull(2)

    companion object {
        val DYRKING_AV_RIS = Næringsgruppe(kode = "01.120", navn = "Dyrking av ris")
        val SCENEKUNST =
            Næringsgruppe(kode = "90.012", navn = "Utøvende kunstnere og underholdningsvirksomhet innen scenekunst")
        val BEDRIFTSRÅDGIVNING =
            Næringsgruppe(kode = "70.220", navn = "Bedriftsrådgivning og annen administrativ rådgivning")
        val KOMMUNE_OSLO = Kommune(navn = "OSLO", nummer = "0301")
        val KOMMUNE_BERGEN = Kommune(navn = "BERGEN", nummer = "4601")

        val OSLO = TestVirksomhet(
            orgnr = "987654321",
            navn = "Virksomhet Oslo",
            næringsgrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_OSLO,
                adresse = listOf("Osloveien 1")
            )
        )
        val OSLO_FLERE_ADRESSER = TestVirksomhet(
            orgnr = "555555555",
            navn = "Virksomhet Oslo Flere Adresser",
            næringsgrupper = listOf(SCENEKUNST, BEDRIFTSRÅDGIVNING),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_OSLO,
                adresse = listOf("c/o Oslo Tigersen", "Osloveien 1", "0977 Oslo")
            )
        )
        val OSLO_MANGLER_ADRESSER = TestVirksomhet(
            orgnr = "666666666",
            navn = "Virksomhet Oslo Mangler Adresser",
            næringsgrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_OSLO,
                adresse = null
            )
        )
        val UTENLANDSK = TestVirksomhet(
            orgnr = "123123123",
            navn = "Utenlandsk Virksomhet",
            næringsgrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                land = "Tyskland",
                landkode = "DE",
                kommune = null,
                postnummer = null,
                poststed = "60313 FRANKFURT AM MAIN",
                adresse = listOf("Deutchestrasse 1")
            )
        )
        val MANGLER_BELIGGENHETSADRESSE = TestVirksomhet(
            orgnr = "321321321",
            navn = "Mangler beliggenhetsadresse",
            næringsgrupper = listOf(SCENEKUNST),
            beliggenhet = null
        )
        val BERGEN = TestVirksomhet(
            orgnr = "123456789",
            navn = "Virksomhet Bærgen",
            næringsgrupper = listOf(BEDRIFTSRÅDGIVNING, SCENEKUNST),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_BERGEN,
                adresse = listOf("Bergenveien 1")
            )
        )

        val tilfeldigGenerator = Random(1)
        fun nyVirksomhet(): TestVirksomhet {
            val orgnr = (800000000 .. 899999999).random(tilfeldigGenerator).toString() // tilfeldige virksomheter har orgnummer som starter på 8
            return TestVirksomhet(
                orgnr = orgnr,
                navn = "Navn $orgnr",
                næringsgrupper = listOf(DYRKING_AV_RIS),
                beliggenhet = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse"))
            )
        }

        private fun beliggenhet(
            land: String = "Norge",
            landkode: String = "NO",
            kommune: Kommune?,
            postnummer: String? = "1234",
            poststed: String? = "POSTSTED",
            adresse: List<String>?,
        ) =
            Beliggenhetsadresse(
                land = land,
                landkode = landkode,
                postnummer = postnummer,
                poststed = poststed,
                adresse = adresse,
                kommunenummer = kommune?.nummer,
                kommune = kommune?.navn
            )
    }
}