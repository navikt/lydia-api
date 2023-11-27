package no.nav.lydia.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.shouldBe
import no.nav.lydia.ADGrupper
import no.nav.lydia.ia.sak.domene.IAProsessStatus.*
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelsePåSak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyFørsteHendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.*
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.NavAnsatt
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler
import no.nav.lydia.tilgangskontroll.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime
import kotlin.test.Test

class IASakTest {
    companion object {
        const val ORGNUMMER = "123456789"

        private val adGrupper = ADGrupper(
            superbrukerGruppe = "123",
            saksbehandlerGruppe = "456",
            lesebrukerGruppe = "789",
        )

        val superbruker1 = Superbruker(
            navIdent = "A123456",
            navn = "Super Bruker 1",
            ansattesGrupper = setOf(adGrupper.superbrukerGruppe)
        )

        val superbruker2 = Superbruker(
            navIdent = "A999111",
            navn = "Super Bruker 2",
            ansattesGrupper = setOf(adGrupper.superbrukerGruppe)
        )

        val saksbehandler1 = Saksbehandler(
            navIdent = "B123456",
            navn = "Saks Behandler 1",
            ansattesGrupper = setOf(adGrupper.saksbehandlerGruppe)
        )

        val navEnhet = NavEnhet(
            enhetsnummer = "2900",
            enhetsnavn = "IT-Utvikling",
        )
    }

    @Test
    fun `skal kunne merke at en virksomhet skal vurderes`() {
        val sak = nyIASak(orgnummer = ORGNUMMER, superbruker = superbruker1)

        val vurderingsHendelse = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            navAnsatt = superbruker2
        )
        superbruker1.utførHendelsePåSak(sak, vurderingsHendelse)
        sak.endretAv shouldBe vurderingsHendelse.opprettetAv
        sak.endretTidspunkt shouldBe vurderingsHendelse.opprettetTidspunkt
        sak.saksnummer shouldBe vurderingsHendelse.saksnummer
        sak.endretAvHendelseId shouldBe vurderingsHendelse.id
        sak.status shouldBe VURDERES
    }

    @Test
    fun `skal kunne bygge sak fra en serie med hendelser`() {
        val h1 = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val h2 = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navAnsatt = superbruker2
        )
        val h3 = nyHendelse(
            VIRKSOMHET_ER_IKKE_AKTUELL,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navAnsatt = superbruker2
        )
        val sak = IASak.fraHendelser(listOf(h1, h2, h3))
        sak.status shouldBe IKKE_AKTUELL
        sak.opprettetAv shouldBe h1.opprettetAv
        sak.endretAv shouldBe h3.opprettetAv
        sak.endretAvHendelseId shouldBe h3.id
    }

    @Test
    fun `skal få en liste over gyldige begrunnelser for når en virksomhet ikke er aktuell`() {
        val h1_ny_sak = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val h2_vurderes = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navAnsatt = superbruker1
        )
        val h3_ta_eierskap = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navAnsatt = saksbehandler1
        )
        val sak = IASak.fraHendelser(listOf(h1_ny_sak, h2_vurderes, h3_ta_eierskap))
        sak.gyldigeNesteHendelser(navAnsatt = saksbehandler1)
            .shouldForAtLeastOne { gyldigHendelse ->
                gyldigHendelse.saksHendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                gyldigHendelse.gyldigeÅrsaker.shouldForAtLeastOne { gyldigÅrsak ->
                    gyldigÅrsak.type shouldBe NAV_IGANGSETTER_IKKE_TILTAK
                    gyldigÅrsak.navn shouldBe NAV_IGANGSETTER_IKKE_TILTAK.navn
                    gyldigÅrsak.begrunnelser.somBegrunnelseType().shouldContainAll(
                        IKKE_DIALOG_MELLOM_PARTENE,
                        FOR_FÅ_TAPTE_DAGSVERK,
                    )
                }
                gyldigHendelse.gyldigeÅrsaker.shouldForAtLeastOne { gyldigÅrsak ->
                    gyldigÅrsak.type shouldBe VIRKSOMHETEN_TAKKET_NEI
                    gyldigÅrsak.navn shouldBe VIRKSOMHETEN_TAKKET_NEI.navn
                    gyldigÅrsak.begrunnelser.somBegrunnelseType().shouldContainAll(
                        VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                        VIRKSOMHETEN_HAR_IKKE_RESPONDERT
                    )
                }
            }.shouldForAtLeastOne {
                it.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                it.gyldigeÅrsaker.shouldBeEmpty()
            }
    }

    @Test
    fun `en sak skal inneholde alle sine hendelser`(){
        val h1_ny_sak = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val h2_vurderes = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navAnsatt = superbruker1
        )
        val h3_ta_eierskap = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navAnsatt = saksbehandler1
        )
        val hendelserPåSak = listOf(h1_ny_sak, h2_vurderes, h3_ta_eierskap)
        val sak = IASak.fraHendelser(hendelserPåSak)
        sak.hendelser.map { it.id } shouldBe hendelserPåSak.map { it.id }
    }


    @Test
    fun `det skal gå an å angre på en sak`(){
        val ny_sak = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = ny_sak.nesteHendelse(VIRKSOMHET_VURDERES)
        val eierskap = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = eierskap.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val tilbakeMidtI = kontaktes.nesteHendelse(TILBAKE)
        val kontaktesAllikevel = tilbakeMidtI.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val ikkeAktuell = kontaktesAllikevel.nesteHendelse(VIRKSOMHET_ER_IKKE_AKTUELL)
        val hendelserPåSak = listOf(ny_sak, vurderes, eierskap, kontaktes, tilbakeMidtI, kontaktesAllikevel,  ikkeAktuell)
        val sak = IASak.fraHendelser(hendelserPåSak)
        sak.status shouldBe IKKE_AKTUELL

        val tilbakeTilKontaktes = ikkeAktuell.nesteHendelse(TILBAKE)
        superbruker1.utførHendelsePåSak(sak, tilbakeTilKontaktes)
        sak.endretAvHendelseId shouldBe tilbakeTilKontaktes.id
        sak.status shouldBe KONTAKTES
        sak.hendelser shouldContain tilbakeTilKontaktes

        val tilbakeTilVurderes = tilbakeTilKontaktes.nesteHendelse(TILBAKE)
        superbruker1.utførHendelsePåSak(sak, tilbakeTilVurderes)
        sak.endretAvHendelseId shouldBe tilbakeTilVurderes.id
        sak.hendelser shouldContain tilbakeTilVurderes
        sak.status shouldBe VURDERES
    }

    @Test
    fun `det skal gå ann å fullføre en sak`() {
        // TODO Testrydding: Kva tester denne, eigentleg? Kan vi bruke sakIViBistår til å lage sak her, eller blir det feil?
        val ny_sak = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = ny_sak.nesteHendelse(VIRKSOMHET_VURDERES)
        val eierskap = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = eierskap.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val kartlegges = kontaktes.nesteHendelse(VIRKSOMHET_KARTLEGGES)
        val viBistår = kartlegges.nesteHendelse(VIRKSOMHET_SKAL_BISTÅS)
        val fullfør = viBistår.nesteHendelse(FULLFØR_BISTAND)

        val sak = IASak.fraHendelser(listOf(
            ny_sak,
            vurderes,
            eierskap,
            kontaktes,
            kartlegges,
            viBistår,
            fullfør,
        ))

        sak.status shouldBe FULLFØRT
        sak.hendelser shouldContainInOrder listOf(
            ny_sak,
            vurderes,
            eierskap,
            kontaktes,
            kartlegges,
            viBistår,
            fullfør,
        )
        val gyldigeNesteHendelser = sak.gyldigeNesteHendelser(superbruker1)
        gyldigeNesteHendelser.size shouldBe 1
        gyldigeNesteHendelser.map { it.saksHendelsestype } shouldContainAll listOf(TILBAKE)
    }

    private fun nyHendelse(type: IASakshendelseType, saksnummer: String, orgnummer: String, navAnsatt: NavAnsatt, navEnhet: NavEnhet = IASakTest.navEnhet) =
        IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = type,
            orgnummer = orgnummer,
            opprettetAv = navAnsatt.navIdent,
            opprettetAvRolle = navAnsatt.rolle,
            navEnhet = navEnhet
        )

    private fun IASakshendelse.nesteHendelse(iaSakshendelseType: IASakshendelseType) =
        when (iaSakshendelseType) {
            VIRKSOMHET_ER_IKKE_AKTUELL -> VirksomhetIkkeAktuellHendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                orgnummer = orgnummer,
                opprettetAv = opprettetAv,
                opprettetAvRolle = opprettetAvRolle,
                valgtÅrsak = ValgtÅrsak(type =  NAV_IGANGSETTER_IKKE_TILTAK, begrunnelser = listOf(FOR_FÅ_TAPTE_DAGSVERK)),
                navEnhet = navEnhet
            )
            else -> IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = iaSakshendelseType,
                orgnummer = orgnummer,
                opprettetAv = opprettetAv,
                opprettetAvRolle = opprettetAvRolle,
                navEnhet = navEnhet
            )
        }

    private fun nyIASak(orgnummer: String, superbruker: Superbruker, navEnhet: NavEnhet = IASakTest.navEnhet): IASak =
        IASak.fraFørsteHendelse(nyFørsteHendelse(orgnummer, superbruker, navEnhet))
}
