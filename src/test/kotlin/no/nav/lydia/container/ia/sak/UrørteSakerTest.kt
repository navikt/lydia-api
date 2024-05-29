package no.nav.lydia.container.ia.sak

import ia.felles.integrasjoner.jobbsender.Jobb.ryddeIUrørteSaker
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.hentSaker
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
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
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    @Test
    fun `skal tilbakeføre urørte saker i vurderes uten eier`() {
        val urørtGammelSak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        urørtGammelSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 365)

        val sakerFørRydding = hentSaker(orgnummer = urørtGammelSak.orgnr)
        sakerFørRydding shouldHaveSize 1
        sakerFørRydding.forExactlyOne {
            it.saksnummer shouldBe urørtGammelSak.saksnummer
            it.status shouldBe IAProsessStatus.VURDERES
            it.eidAv shouldBe null
        }

        kafkaContainer.sendJobbMelding(ryddeIUrørteSaker)

        val sakerEtterRydding = hentSaker(orgnummer = urørtGammelSak.orgnr)
        sakerEtterRydding shouldHaveSize 1
        sakerEtterRydding.forExactlyOne { sak ->
            sak.saksnummer shouldBe urørtGammelSak.saksnummer
            sak.status shouldBe IAProsessStatus.IKKE_AKTUELL
            sak.eidAv shouldBe null

            val tilbakeføringsHendelse = hentHendelse(sak.endretAvHendelseId)
            tilbakeføringsHendelse.navEnhet shouldBe IASakStatusOppdaterer.NAV_ENHET_FOR_TILBAKEFØRING
            tilbakeføringsHendelse.opprettetAv shouldBe "Fia system"

            hentSamarbeidshistorikk(orgnummer = sak.orgnr).forExactlyOne { sakshistorikk ->
                sakshistorikk.sakshendelser.forExactlyOne { snapshot ->
                    snapshot.begrunnelser shouldBe listOf(
                        BegrunnelseType.AUTOMATISK_LUKKET.navn
                    )
                }
            }
        }
    }

    @Test
    fun `skal ikke tilbakeføre andre gamle saker enn de som er i vurderes uten eier`() {
        val sakMedEier = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = oauth2ServerContainer.saksbehandler1.token
            )
        sakMedEier.oppdaterHendelsesTidspunkter(antallDagerTilbake = 365)

        val sakerFørRydding = hentSaker(orgnummer = sakMedEier.orgnr)
        sakerFørRydding shouldHaveSize 1
        sakerFørRydding.forExactlyOne {
            it.saksnummer shouldBe sakMedEier.saksnummer
            it.status shouldBe IAProsessStatus.VURDERES
            it.eidAv shouldBe oauth2ServerContainer.saksbehandler1.navIdent
        }

        kafkaContainer.sendJobbMelding(ryddeIUrørteSaker)

        val sakerEtterRydding = hentSaker(orgnummer = sakMedEier.orgnr)
        sakerEtterRydding shouldHaveSize 1
        sakerEtterRydding.forExactlyOne { sak ->
            sak.saksnummer shouldBe sakMedEier.saksnummer
            sak.status shouldBe IAProsessStatus.VURDERES
        }
    }

    @Test
    fun `skal ikke tilbakeføre saker som er nyere enn 6 måneder i vurderes uten eier`() {
        val urørtNyereSak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
        urørtNyereSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 20)

        val sakerFørRydding = hentSaker(orgnummer = urørtNyereSak.orgnr)
        sakerFørRydding shouldHaveSize 1
        sakerFørRydding.forExactlyOne {
            it.saksnummer shouldBe urørtNyereSak.saksnummer
            it.status shouldBe IAProsessStatus.VURDERES
            it.eidAv shouldBe null
        }

        kafkaContainer.sendJobbMelding(ryddeIUrørteSaker)

        val sakerEtterRydding = hentSaker(orgnummer = urørtNyereSak.orgnr)
        sakerEtterRydding shouldHaveSize 1
        sakerEtterRydding.forExactlyOne { sak ->
            sak.saksnummer shouldBe urørtNyereSak.saksnummer
            sak.status shouldBe IAProsessStatus.VURDERES
        }
    }

    private fun hentHendelse(hendelsesId: String): IASakshendelse {
        postgresContainer.dataSource.connection.use { connection ->
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
                )
            )
        }
    }
}