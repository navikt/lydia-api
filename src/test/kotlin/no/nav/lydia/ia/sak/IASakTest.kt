package no.nav.lydia.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.shouldBe
import no.nav.lydia.ADGrupper
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.utførHendelsePåSak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.nyFørsteHendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.ENDRE_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TILBAKE
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.FOR_FÅ_TAPTE_DAGSVERK
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.IKKE_DIALOG_MELLOM_PARTENE
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_HAR_IKKE_RESPONDERT
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Saksbehandler
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime
import kotlin.test.Test

class IASakTest {
    companion object {
        const val ORGNUMMER = "123456789"

        private val adGrupper = ADGrupper(
            superbrukerGruppe = "123",
            saksbehandlerGruppe = "456",
            lesebrukerGruppe = "789",
            teamPiaGruppe = "136",
        )

        val superbruker1 = Superbruker(
            navIdent = "A123456",
            navn = "Super Bruker 1",
            token = "token",
            ansattesGrupper = setOf(adGrupper.superbrukerGruppe),
        )

        val superbruker2 = Superbruker(
            navIdent = "A999111",
            navn = "Super Bruker 2",
            token = "token",
            ansattesGrupper = setOf(adGrupper.superbrukerGruppe),
        )

        val saksbehandler1 = Saksbehandler(
            navIdent = "B123456",
            navn = "Saks Behandler 1",
            token = "token",
            ansattesGrupper = setOf(adGrupper.saksbehandlerGruppe),
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
            navAnsatt = superbruker2,
        )
        superbruker1.utførHendelsePåSak(sak, vurderingsHendelse, false)
        sak.endretAv shouldBe vurderingsHendelse.opprettetAv
        sak.endretTidspunkt shouldBe vurderingsHendelse.opprettetTidspunkt
        sak.saksnummer shouldBe vurderingsHendelse.saksnummer
        sak.endretAvHendelseId shouldBe vurderingsHendelse.id
        sak.status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `skal kunne bygge sak fra en serie med hendelser`() {
        val h1 = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val h2 = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navAnsatt = superbruker2,
        )
        val h3 = nyHendelse(
            VIRKSOMHET_ER_IKKE_AKTUELL,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navAnsatt = superbruker2,
        )
        val sak = IASak.fraHendelser(listOf(h1, h2, h3))
        sak.status shouldBe IASak.Status.IKKE_AKTUELL
        sak.opprettetAv shouldBe h1.opprettetAv
        sak.endretAv shouldBe h3.opprettetAv
        sak.endretAvHendelseId shouldBe h3.id
    }

    @Test
    fun `skal få en liste over gyldige begrunnelser for når en virksomhet ikke er aktuell`() {
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderesHendelse = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = nySakHendelse.saksnummer,
            orgnummer = nySakHendelse.orgnummer,
            navAnsatt = superbruker1,
        )
        val taEierskapHendelse = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = nySakHendelse.saksnummer,
            orgnummer = nySakHendelse.orgnummer,
            navAnsatt = saksbehandler1,
        )
        val sak = IASak.fraHendelser(listOf(nySakHendelse, vurderesHendelse, taEierskapHendelse))
        sak.gyldigeNesteHendelser(navAnsatt = saksbehandler1, false)
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
                        VIRKSOMHETEN_HAR_IKKE_RESPONDERT,
                    )
                }
            }.shouldForAtLeastOne {
                it.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                it.gyldigeÅrsaker.shouldBeEmpty()
            }
    }

    @Test
    fun `en sak skal inneholde alle sine hendelser`() {
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderesHendelse = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = nySakHendelse.saksnummer,
            orgnummer = nySakHendelse.orgnummer,
            navAnsatt = superbruker1,
        )
        val taEierskapHendelse = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = nySakHendelse.saksnummer,
            orgnummer = nySakHendelse.orgnummer,
            navAnsatt = saksbehandler1,
        )
        val hendelserPåSak = listOf(nySakHendelse, vurderesHendelse, taEierskapHendelse)
        val sak = IASak.fraHendelser(hendelserPåSak)
        sak.hendelser.map { it.id } shouldBe hendelserPåSak.map { it.id }
    }

    @Test
    fun `det skal gå an å angre på en sak`() {
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = nySakHendelse.nesteHendelse(VIRKSOMHET_VURDERES)
        val eierskap = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = eierskap.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val tilbakeMidtI = kontaktes.nesteHendelse(TILBAKE)
        val kontaktesAllikevel = tilbakeMidtI.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val ikkeAktuell = kontaktesAllikevel.nesteHendelse(VIRKSOMHET_ER_IKKE_AKTUELL)
        val hendelserPåSak =
            listOf(nySakHendelse, vurderes, eierskap, kontaktes, tilbakeMidtI, kontaktesAllikevel, ikkeAktuell)
        val sak = IASak.fraHendelser(hendelserPåSak)
        sak.status shouldBe IASak.Status.IKKE_AKTUELL

        val tilbakeTilKontaktes = ikkeAktuell.nesteHendelse(TILBAKE)
        superbruker1.utførHendelsePåSak(sak, tilbakeTilKontaktes, false)
        sak.endretAvHendelseId shouldBe tilbakeTilKontaktes.id
        sak.status shouldBe IASak.Status.KONTAKTES
        sak.hendelser shouldContain tilbakeTilKontaktes

        val tilbakeTilVurderes = tilbakeTilKontaktes.nesteHendelse(TILBAKE)
        superbruker1.utførHendelsePåSak(sak, tilbakeTilVurderes, false)
        sak.endretAvHendelseId shouldBe tilbakeTilVurderes.id
        sak.hendelser shouldContain tilbakeTilVurderes
        sak.status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `det skal gå ann å fullføre en sak`() {
        // TODO Testrydding: Kva tester denne, eigentleg? Kan vi bruke sakIViBistår til å lage sak her, eller blir det feil?
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = nySakHendelse.nesteHendelse(VIRKSOMHET_VURDERES)
        val eierskap = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = eierskap.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val kartlegges = kontaktes.nesteHendelse(VIRKSOMHET_KARTLEGGES)
        val viBistår = kartlegges.nesteHendelse(VIRKSOMHET_SKAL_BISTÅS)
        val fullfør = viBistår.nesteHendelse(FULLFØR_BISTAND)

        val sak = IASak.fraHendelser(
            listOf(
                nySakHendelse,
                vurderes,
                eierskap,
                kontaktes,
                kartlegges,
                viBistår,
                fullfør,
            ),
        )

        sak.status shouldBe IASak.Status.FULLFØRT
        sak.hendelser shouldContainInOrder listOf(
            nySakHendelse,
            vurderes,
            eierskap,
            kontaktes,
            kartlegges,
            viBistår,
            fullfør,
        )
        val gyldigeNesteHendelser = sak.gyldigeNesteHendelser(superbruker1, false)
        gyldigeNesteHendelser.size shouldBe 1
        gyldigeNesteHendelser.map { it.saksHendelsestype } shouldContainAll listOf(TILBAKE)
    }

    @Test
    fun `teste utenTilbake finnforrigetilstand`() {
        val utenTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_KARTLEGGES,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(utenTilbake) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste utenTilbakeMedIkkeAktuell finnforrigetilstand`() {
        val utenTilbakeMedIkkeAktuell = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_ER_IKKE_AKTUELL,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(utenTilbakeMedIkkeAktuell) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste medIrrelevantTilbake finnforrigetilstand`() {
        val medIrrelevantTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES,
            TILBAKE,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_ER_IKKE_AKTUELL,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medIrrelevantTilbake) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste medEnRelevantTilbake finnforrigetilstand`() {
        val medEnRelevantTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            TILBAKE,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medEnRelevantTilbake) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste medEnRelevantTilbakeNestSist finnforrigetilstand`() {
        val medEnRelevantTilbakeNestSist = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_KARTLEGGES,
            TILBAKE,
            VIRKSOMHET_KARTLEGGES,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medEnRelevantTilbakeNestSist) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste medToRelevanteTilbake finnforrigetilstand`() {
        val medToRelevanteTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            VIRKSOMHET_ER_IKKE_AKTUELL,
            TILBAKE,
            TILBAKE,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medToRelevanteTilbake) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste medTreRelevanteTilbake finnforrigetilstand`() {
        val medTreRelevanteTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES, // VI SKAL HIT!
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES,
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            VIRKSOMHET_ER_IKKE_AKTUELL,
            TILBAKE,
            TILBAKE,
            TILBAKE,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medTreRelevanteTilbake) shouldBe VIRKSOMHET_VURDERES
    }

    @Test
    fun `teste medFremOgTilbake finnforrigetilstand`() {
        val medFremOgTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_KARTLEGGES,
            TILBAKE,
            VIRKSOMHET_KARTLEGGES,
            TILBAKE,
            VIRKSOMHET_KARTLEGGES,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medFremOgTilbake) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `teste medFremOgTilbakeMedTilbakeSiste finnforrigetilstand`() {
        val medFremOgTilbake = listOf(
            OPPRETT_SAK_FOR_VIRKSOMHET,
            VIRKSOMHET_VURDERES,
            TA_EIERSKAP_I_SAK,
            VIRKSOMHET_SKAL_KONTAKTES, // VI SKAL HIT!
            VIRKSOMHET_KARTLEGGES,
            VIRKSOMHET_SKAL_BISTÅS,
            TILBAKE,
            VIRKSOMHET_SKAL_BISTÅS,
            TILBAKE,
            VIRKSOMHET_SKAL_BISTÅS,
            TILBAKE,
        )
        IASak.finnForrigeTilstandBasertPåHendelsesrekke(medFremOgTilbake) shouldBe VIRKSOMHET_SKAL_KONTAKTES
    }

    @Test
    fun `skal kunne endre navn på prosess to ganger etter hverandre`() {
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = nySakHendelse.nesteHendelse(VIRKSOMHET_VURDERES)
        val medEier = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = medEier.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val kartlegges = kontaktes.nesteHendelse(VIRKSOMHET_KARTLEGGES)
        val førsteNavngivning = kartlegges.nesteHendelse(ENDRE_PROSESS)
        val andreNavngivning = førsteNavngivning.nesteHendelse(ENDRE_PROSESS)

        val hendelsesRekke =
            listOf(nySakHendelse, vurderes, medEier, kontaktes, kartlegges, førsteNavngivning, andreNavngivning)
        val sak = IASak.fraHendelser(hendelsesRekke)
        sak.status shouldBe IASak.Status.KARTLEGGES
    }

    @Test
    fun `nye versjoner av tilstandsmaskinen skal ikke gi andre statuser for gammel eventrekke`() {
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = nySakHendelse.nesteHendelse(VIRKSOMHET_VURDERES)
        val medEier = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = medEier.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val tilbake1 = kontaktes.nesteHendelse(TILBAKE)
        val kontaktesAllikevel = tilbake1.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val kartlegges = kontaktesAllikevel.nesteHendelse(VIRKSOMHET_KARTLEGGES)
        val tilbake2 = kartlegges.nesteHendelse(TILBAKE)
        val kartleggesAllikevel = tilbake2.nesteHendelse(VIRKSOMHET_KARTLEGGES)
        val ikkeAktuellHendelse = kartleggesAllikevel.nesteHendelse(VIRKSOMHET_ER_IKKE_AKTUELL)
        val tilbake3 = ikkeAktuellHendelse.nesteHendelse(TILBAKE)
        val bistå = tilbake3.nesteHendelse(VIRKSOMHET_SKAL_BISTÅS)
        val fullfør = bistå.nesteHendelse(FULLFØR_BISTAND)
        val liste = listOf(
            nySakHendelse,
            vurderes,
            medEier,
            kontaktes,
            tilbake1,
            kontaktesAllikevel,
            kartlegges,
            tilbake2,
            kartleggesAllikevel,
            ikkeAktuellHendelse,
            tilbake3,
            bistå,
            fullfør,
        )
        IASak.fraHendelser(liste).status shouldBe IASak.Status.FULLFØRT
    }

    @Test
    fun `ytelse test`() {
        val nySakHendelse = nyFørsteHendelse(orgnummer = ORGNUMMER, superbruker = superbruker1, navEnhet = navEnhet)
        val vurderes = nySakHendelse.nesteHendelse(VIRKSOMHET_VURDERES)
        val medEier = vurderes.nesteHendelse(TA_EIERSKAP_I_SAK)
        val kontaktes = medEier.nesteHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        val kartlegges = kontaktes.nesteHendelse(VIRKSOMHET_KARTLEGGES)
        val liste = mutableListOf(
            nySakHendelse,
            vurderes,
            medEier,
            kontaktes,
            kartlegges,
        )
        var hendelse = kartlegges
        repeat(300) {
            val viBistår = hendelse.nesteHendelse(VIRKSOMHET_SKAL_BISTÅS)
            hendelse = viBistår.nesteHendelse(TILBAKE)
            liste.add(viBistår)
            liste.add(hendelse)
        }
        IASak.fraHendelser(liste).status shouldBe IASak.Status.KARTLEGGES
    }

    private fun nyHendelse(
        type: IASakshendelseType,
        saksnummer: String,
        orgnummer: String,
        navAnsatt: NavAnsatt,
        navEnhet: NavEnhet = IASakTest.navEnhet,
    ) = IASakshendelse(
        id = ULID.random(),
        opprettetTidspunkt = LocalDateTime.now(),
        saksnummer = saksnummer,
        hendelsesType = type,
        orgnummer = orgnummer,
        opprettetAv = navAnsatt.navIdent,
        opprettetAvRolle = navAnsatt.rolle,
        navEnhet = navEnhet,
        resulterendeStatus = null,
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
                valgtÅrsak = ValgtÅrsak(
                    type = NAV_IGANGSETTER_IKKE_TILTAK,
                    begrunnelser = listOf(FOR_FÅ_TAPTE_DAGSVERK),
                ),
                navEnhet = navEnhet,
                resulterendeStatus = null,
            )

            ENDRE_PROSESS, SLETT_PROSESS -> ProsessHendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = iaSakshendelseType,
                orgnummer = orgnummer,
                opprettetAv = opprettetAv,
                opprettetAvRolle = opprettetAvRolle,
                samarbeidDto = IASamarbeidDto(1, saksnummer, "Navn"),
                navEnhet = navEnhet,
                resulterendeStatus = null,
            )

            else -> IASakshendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                hendelsesType = iaSakshendelseType,
                orgnummer = orgnummer,
                opprettetAv = opprettetAv,
                opprettetAvRolle = opprettetAvRolle,
                navEnhet = navEnhet,
                resulterendeStatus = null,
            )
        }

    private fun nyIASak(
        orgnummer: String,
        superbruker: Superbruker,
        navEnhet: NavEnhet = IASakTest.navEnhet,
    ): IASak = IASak.fraFørsteHendelse(nyFørsteHendelse(orgnummer, superbruker, navEnhet))
}
