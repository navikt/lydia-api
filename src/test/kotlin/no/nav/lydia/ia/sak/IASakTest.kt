package no.nav.lydia.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainInOrder
import io.kotest.matchers.shouldBe
import no.nav.lydia.FiaRoller
import no.nav.lydia.ia.sak.domene.IAProsessStatus.*
import no.nav.lydia.ia.sak.domene.IASak
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
import no.nav.lydia.tilgangskontroll.Rådgiver
import java.time.LocalDateTime
import kotlin.test.Test

class IASakTest {
    companion object {
        const val orgnummer = "123456789"
        const val navIdent1 = "A123456"
        const val navIdent2 = "B123456"

        val fiaroller = FiaRoller(
            superbrukerGroupId = "123",
            saksbehandlerGroupId = "456",
            lesetilgangGroupId = "789",
            teamPiaGroupId = "1011"
        )

        val superbruker1 = Rådgiver(
            navIdent = navIdent1,
            navn = "Super Bruker",
            fiaRoller = fiaroller,
            rådgiversGrupper = listOf(fiaroller.superbrukerGroupId)
        )

        val saksbehandler2 = Rådgiver(
            navIdent = navIdent2,
            navn = "Saks Behandler",
            fiaRoller = fiaroller,
            rådgiversGrupper = listOf(fiaroller.saksbehandlerGroupId)
        )
    }

    @Test
    fun `skal kunne merke at en virksomhet skal vurderes`() {
        val sak = nyIASak(orgnummer = orgnummer, navIdent = navIdent1)

        val vurderingsHendelse = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            navIdent = navIdent2
        )
        sak.behandleHendelse(vurderingsHendelse)
        sak.endretAv shouldBe vurderingsHendelse.opprettetAv
        sak.endretTidspunkt shouldBe vurderingsHendelse.opprettetTidspunkt
        sak.saksnummer shouldBe vurderingsHendelse.saksnummer
        sak.endretAvHendelseId shouldBe vurderingsHendelse.id
        sak.status shouldBe VURDERES
    }

    @Test
    fun `skal kunne bygge sak fra en serie med hendelser`() {
        val h1 = nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = navIdent1)
        val h2 = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val h3 = nyHendelse(
            VIRKSOMHET_ER_IKKE_AKTUELL,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val sak = IASak.fraHendelser(listOf(h1, h2, h3))
        sak.status shouldBe IKKE_AKTUELL
        sak.opprettetAv shouldBe h1.opprettetAv
        sak.endretAv shouldBe h3.opprettetAv
        sak.endretAvHendelseId shouldBe h3.id
    }

    @Test
    fun `skal få en liste over gyldige begrunnelser for når en virksomhet ikke er aktuell`() {
        val h1_ny_sak = nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = superbruker1.navIdent)
        val h2_vurderes = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navIdent = superbruker1.navIdent
        )
        val h3_ta_eierskap = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navIdent = saksbehandler2.navIdent
        )
        val sak = IASak.fraHendelser(listOf(h1_ny_sak, h2_vurderes, h3_ta_eierskap))
        sak.gyldigeNesteHendelser(rådgiver = saksbehandler2)
            .shouldForAtLeastOne {
                it.saksHendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                it.gyldigeÅrsaker.shouldForAtLeastOne {
                    it.type shouldBe NAV_IGANGSETTER_IKKE_TILTAK
                    it.navn shouldBe NAV_IGANGSETTER_IKKE_TILTAK.navn
                    it.begrunnelser.somBegrunnelseType().shouldContainAll(
                        MANGLER_PARTSGRUPPE,
                        IKKE_TILFREDSSTILLENDE_SAMARBEID,
                        FOR_LAVT_SYKEFRAVÆR,
                        IKKE_TID,
                        MINDRE_VIRKSOMHET
                    )
                }
                it.gyldigeÅrsaker.shouldForAtLeastOne {
                    it.type shouldBe VIRKSOMHETEN_TAKKET_NEI
                    it.navn shouldBe VIRKSOMHETEN_TAKKET_NEI.navn
                    it.begrunnelser.somBegrunnelseType().shouldContainAll(
                        HAR_IKKE_KAPASITET,
                        GJENNOMFØRER_TILTAK_PÅ_EGENHÅND,
                        GJENNOMFØRER_TILTAK_MED_BHT
                    )
                }
            }.shouldForAtLeastOne {
                it.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                it.gyldigeÅrsaker.shouldBeEmpty()
            }
    }

    @Test
    fun `en sak skal inneholde alle sine hendelser`(){
        val h1_ny_sak = nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = superbruker1.navIdent)
        val h2_vurderes = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navIdent = superbruker1.navIdent
        )
        val h3_ta_eierskap = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navIdent = saksbehandler2.navIdent
        )
        val hendelserPåSak = listOf(h1_ny_sak, h2_vurderes, h3_ta_eierskap)
        val sak = IASak.fraHendelser(hendelserPåSak)
        sak.hendelser.map { it.id } shouldBe hendelserPåSak.map { it.id }
    }


    @Test
    fun `det skal gå an å angre på en sak`(){
        val ny_sak = nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = superbruker1.navIdent)
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
        sak.behandleHendelse(tilbakeTilKontaktes)
        sak.endretAvHendelseId shouldBe tilbakeTilKontaktes.id
        sak.status shouldBe KONTAKTES
        sak.hendelser shouldContain tilbakeTilKontaktes

        val tilbakeTilVurderes = tilbakeTilKontaktes.nesteHendelse(TILBAKE)
        sak.behandleHendelse(tilbakeTilVurderes)
        sak.endretAvHendelseId shouldBe tilbakeTilVurderes.id
        sak.hendelser shouldContain tilbakeTilVurderes
        sak.status shouldBe VURDERES
    }

    @Test
    fun `det skal gå ann å fullføre en sak`() {
        val ny_sak = nyFørsteHendelse(orgnummer = orgnummer, opprettetAv = superbruker1.navIdent)
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

    private fun nyHendelse(type: IASakshendelseType, saksnummer: String, orgnummer: String, navIdent: String) =
        IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = type,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )

    private fun IASakshendelse.nesteHendelse(iaSakshendelseType: IASakshendelseType) =
        when (iaSakshendelseType) {
            VIRKSOMHET_ER_IKKE_AKTUELL -> VirksomhetIkkeAktuellHendelse(
                id = ULID.random(),
                opprettetTidspunkt = LocalDateTime.now(),
                saksnummer = saksnummer,
                orgnummer = orgnummer,
                opprettetAv = this.opprettetAv,
                valgtÅrsak = ValgtÅrsak(type =  NAV_IGANGSETTER_IKKE_TILTAK, begrunnelser = listOf(IKKE_TID))
            )
            else -> nyHendelse(iaSakshendelseType, saksnummer = this.saksnummer, orgnummer = this.orgnummer, navIdent = this.opprettetAv)
        }

    private fun nyIASak(orgnummer: String, navIdent: String): IASak =
        IASak.fraFørsteHendelse(nyFørsteHendelse(orgnummer, navIdent))
}
