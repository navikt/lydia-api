package no.nav.lydia.container.ia.sak

import ia.felles.integrasjoner.jobbsender.Jobb.ryddeIUrørteSaker
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import org.junit.Test

class UrørteSakerTest {
    @Test
    fun `skal tilbakeføre urørte saker i vurderes uten eier`() {
        val urørtGammelSak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        urørtGammelSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 365)

        val sakFørRydding = hentSak(orgnummer = urørtGammelSak.orgnr, saksnummer = urørtGammelSak.saksnummer)
        sakFørRydding.saksnummer shouldBe urørtGammelSak.saksnummer
        sakFørRydding.status shouldBe IAProsessStatus.VURDERES
        sakFørRydding.eidAv shouldBe null

        kafkaContainerHelper.sendJobbMelding(ryddeIUrørteSaker)

        val sakEtterRydding = hentSak(orgnummer = urørtGammelSak.orgnr, saksnummer = urørtGammelSak.saksnummer)
        sakEtterRydding.saksnummer shouldBe urørtGammelSak.saksnummer
        sakEtterRydding.status shouldBe IAProsessStatus.IKKE_AKTUELL
        sakEtterRydding.eidAv shouldBe null

        val tilbakeføringsHendelse = hentHendelse(sakEtterRydding.endretAvHendelseId)
        tilbakeføringsHendelse.navEnhet shouldBe IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING
        tilbakeføringsHendelse.opprettetAv shouldBe "Fia system"

        hentSamarbeidshistorikk(orgnummer = sakEtterRydding.orgnr).forExactlyOne { sakshistorikk ->
            sakshistorikk.sakshendelser.forExactlyOne { snapshot ->
                snapshot.begrunnelser shouldBe listOf(
                    BegrunnelseType.AUTOMATISK_LUKKET.navn,
                )
            }
        }
    }

    @Test
    fun `skal ikke tilbakeføre andre gamle saker enn de som er i vurderes uten eier`() {
        val sakMedEier = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = authContainerHelper.saksbehandler1.token,
            )
        sakMedEier.oppdaterHendelsesTidspunkter(antallDagerTilbake = 365)

        val sakFørRydding = hentSak(orgnummer = sakMedEier.orgnr, saksnummer = sakMedEier.saksnummer)
        sakFørRydding.saksnummer shouldBe sakMedEier.saksnummer
        sakFørRydding.status shouldBe IAProsessStatus.VURDERES
        sakFørRydding.eidAv shouldBe authContainerHelper.saksbehandler1.navIdent

        kafkaContainerHelper.sendJobbMelding(ryddeIUrørteSaker)

        val sakEtterRydding = hentSak(orgnummer = sakMedEier.orgnr, saksnummer = sakMedEier.saksnummer)
        sakEtterRydding.saksnummer shouldBe sakMedEier.saksnummer
        sakEtterRydding.status shouldBe IAProsessStatus.VURDERES
        sakEtterRydding.eidAv shouldBe authContainerHelper.saksbehandler1.navIdent
    }

    @Test
    fun `skal ikke tilbakeføre saker som er nyere enn 6 måneder i vurderes uten eier`() {
        val urørtNyereSak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        urørtNyereSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 20)

        val sakFørRydding = hentSak(orgnummer = urørtNyereSak.orgnr, saksnummer = urørtNyereSak.saksnummer)
        sakFørRydding.saksnummer shouldBe urørtNyereSak.saksnummer
        sakFørRydding.status shouldBe IAProsessStatus.VURDERES
        sakFørRydding.eidAv shouldBe null

        kafkaContainerHelper.sendJobbMelding(ryddeIUrørteSaker)

        val sakEtterRydding = hentSak(orgnummer = urørtNyereSak.orgnr, saksnummer = urørtNyereSak.saksnummer)
        sakEtterRydding.saksnummer shouldBe urørtNyereSak.saksnummer
        sakEtterRydding.status shouldBe IAProsessStatus.VURDERES
        sakEtterRydding.eidAv shouldBe null
    }

    private fun hentHendelse(hendelsesId: String): IASakshendelse {
        postgresContainerHelper.dataSource.connection.use { connection ->
            val statement = connection.createStatement()
            statement.execute("select * from ia_sak_hendelse where id = '$hendelsesId'")
            val rs = statement.resultSet
            rs.next()
            rs.row shouldBe 1
            return IASakshendelse(
                id = rs.getString("id"),
                opprettetTidspunkt = rs.getTimestamp("opprettet").toLocalDateTime(),
                saksnummer = rs.getString("saksnummer"),
                orgnummer = rs.getString("orgnr"),
                hendelsesType = IASakshendelseType.valueOf(rs.getString("type")),
                opprettetAv = rs.getString("opprettet_av"),
                opprettetAvRolle = Rolle.valueOf(rs.getString("opprettet_av_rolle")),
                navEnhet = NavEnhet(
                    enhetsnummer = rs.getString("nav_enhet_nummer"),
                    enhetsnavn = rs.getString("nav_enhet_navn"),
                ),
                resulterendeStatus = rs.getString("resulterende_status")?.let { IAProsessStatus.valueOf(it) },
            )
        }
    }
}
