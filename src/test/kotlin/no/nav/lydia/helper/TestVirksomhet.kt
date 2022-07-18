package no.nav.lydia.helper

import no.nav.lydia.helper.TestData.Companion.BEDRIFTSRÅDGIVNING
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_RIS
import no.nav.lydia.helper.TestData.Companion.SCENEKUNST
import no.nav.lydia.integrasjoner.brreg.Beliggenhetsadresse
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import kotlin.random.Random

data class TestVirksomhet(
    val orgnr: String,
    val navn: String,
    val næringsundergrupper: List<Næringsgruppe>, //TODO hvorfor kommer samme element to ganger i denne lista?
    val beliggenhet: Beliggenhetsadresse?
) {
    val næringsundergruppe1 = næringsundergrupper.first()
    val næringsundergruppe2 = næringsundergrupper.getOrNull(1)
    val næringsundergruppe3 = næringsundergrupper.getOrNull(2)

    companion object {

        private val NÆRINGER_LISTE = listOf(DYRKING_AV_RIS, SCENEKUNST, BEDRIFTSRÅDGIVNING)
        val KOMMUNE_OSLO = Kommune(navn = "OSLO", nummer = "0301")
        val KOMMUNE_BERGEN = Kommune(navn = "BERGEN", nummer = "4601")
        val INDRE_ØSTFOLD = Kommune(navn = "Indre Østfold", nummer = "3014")
        val LUNNER = Kommune(navn = "Lunner", nummer = "3054")

        val OSLO = TestVirksomhet(
            orgnr = "987654321",
            navn = "Virksomhet Oslo",
            næringsundergrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_OSLO,
                adresse = listOf("Osloveien 1")
            )
        )
        val OSLO_FLERE_ADRESSER = TestVirksomhet(
            orgnr = "555555555",
            navn = "Virksomhet Oslo Flere Adresser",
            næringsundergrupper = listOf(SCENEKUNST, BEDRIFTSRÅDGIVNING),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_OSLO,
                adresse = listOf("c/o Oslo Tigersen", "Osloveien 1", "0977 Oslo")
            )
        )
        val OSLO_MANGLER_ADRESSER = TestVirksomhet(
            orgnr = "666666666",
            navn = "Virksomhet Oslo Mangler Adresser",
            næringsundergrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_OSLO,
                adresse = null
            )
        )
        val UTENLANDSK = TestVirksomhet(
            orgnr = "123123123",
            navn = "Utenlandsk Virksomhet",
            næringsundergrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                land = "Tyskland",
                landkode = "DE",
                kommune = null,
                postnummer = null,
                poststed = "60313 FRANKFURT AM MAIN",
                adresse = listOf("Deutchestrasse 1")
            )
        )
        val NAV_KONTOR = TestVirksomhet(
            orgnr = "984247664",
            navn = "NAV Arbeidslivssenter Oslo",
            næringsundergrupper = listOf(SCENEKUNST),
            beliggenhet = beliggenhet(
                landkode = "NO",
                land = "Norge",
                kommune = KOMMUNE_OSLO,
                adresse = listOf("C. J. Hambros plass 2", "0164 OSLO"),
                postnummer = "0663",
                poststed = "Oslo"
            )
        )
        val MANGLER_BELIGGENHETSADRESSE = TestVirksomhet(
            orgnr = "321321321",
            navn = "Mangler beliggenhetsadresse",
            næringsundergrupper = listOf(SCENEKUNST),
            beliggenhet = null
        )
        val BERGEN = TestVirksomhet(
            orgnr = "123456789",
            navn = "Virksomhet Bærgen",
            næringsundergrupper = listOf(BEDRIFTSRÅDGIVNING, SCENEKUNST),
            beliggenhet = beliggenhet(
                kommune = KOMMUNE_BERGEN,
                adresse = listOf("Bergenveien 1")
            )
        )

        private val tilfeldigGenerator = Random(1)
        val TESTVIRKSOMHET_FOR_IMPORT = nyVirksomhet()
        val TESTVIRKSOMHET_FOR_STATUSFILTER = nyVirksomhet()
        val TESTVIRKSOMHET_FOR_GRUNNLAG = nyVirksomhet()

        fun nyVirksomhet(
            beliggenhet: Beliggenhetsadresse = beliggenhet(kommune = KOMMUNE_OSLO, adresse = listOf("adresse")),
            næringer: List<Næringsgruppe> = tilfeldigeNæringsgrupper(),
            orgnr: String = (800000000 .. 899999999).random(tilfeldigGenerator).toString(), // tilfeldige virksomheter har orgnummer som starter på 8
            navn: String = "Navn $orgnr"
        ): TestVirksomhet {
            return TestVirksomhet(
                orgnr = orgnr,
                navn = navn,
                næringsundergrupper = næringer,
                beliggenhet = beliggenhet
            )
        }

        private fun tilfeldigeNæringsgrupper() =
            when ((1..6).random()) {
                1, 2, 3 -> listOf(NÆRINGER_LISTE[(0..2).random()])
                4, 5 -> listOf(NÆRINGER_LISTE[(0..2).random()], NÆRINGER_LISTE[(0..2).random()]) // TODO
                else -> NÆRINGER_LISTE
            }

        fun beliggenhet(
            land: String = "Norge",
            landkode: String = "NO",
            kommune: Kommune?,
            postnummer: String? = "1234",
            poststed: String? = "POSTSTED",
            adresse: List<String>? = listOf("adresse"),
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