package no.nav.lydia.container.integrasjoner.kvittering

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.sendKvittering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
import no.nav.lydia.helper.PlanHelper.Companion.hentPlan
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.kvittering.KvitteringDto
import java.time.LocalDateTime
import java.util.UUID
import kotlin.test.Test

class KvitteringConsumerTest {
    val json = Json {
        ignoreUnknownKeys = true
    }

    @Test
    fun `skal lagre kvittering for publisert dokument`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)
        val dokumentRefId = fullførtBehovsvurdering.id
        val dokument = publiserDokument(
            dokumentReferanseId = dokumentRefId,
            token = authContainerHelper.saksbehandler1.token,
        ).third.get()

        val kvittering = dokument.tilKvittering(sak.hentAlleSamarbeid().first().id)
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = kvittering.dokumentId,
            topic = Topic.DOKUMENT_KVITTERING_TOPIC,
            melding = json.encodeToString(kvittering),
        )

        sak.hentAlleSamarbeid().first()

        val spørreundersøkelse = IASakSpørreundersøkelseHelper.hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).first()

        spørreundersøkelse.publiseringStatus shouldBe DokumentPubliseringDto.Status.PUBLISERT
        spørreundersøkelse.publisertTidspunkt shouldNotBe null
    }

    @Test
    fun `skal kunne publisere samarbeidsplan flere ganger`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        val dokument = publiserDokument(
            dokumentReferanseId = plan.id,
            dokumentType = DokumentPubliseringDto.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        ).third.get()
        sendKvittering(dokument, sak.hentAlleSamarbeid().first().id)

        val planEtterPublisering = sak.hentPlan()
        planEtterPublisering.publiseringStatus shouldBe DokumentPubliseringDto.Status.PUBLISERT

        val dokumentV2 = publiserDokument(
            dokumentReferanseId = plan.id,
            dokumentType = DokumentPubliseringDto.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        ).third.get()
        sendKvittering(dokumentV2, sak.hentAlleSamarbeid().first().id)

        val planEtterRePublisering = sak.hentPlan()
        planEtterRePublisering.publiseringStatus shouldBe DokumentPubliseringDto.Status.PUBLISERT

        TestContainerHelper.postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select dokument_id from kvittert_dokument where referanse_id = '${plan.id}'",
        ) shouldHaveSize 2
    }
}

internal fun DokumentPubliseringDto.tilKvittering(samarbeidId: Int) =
    KvitteringDto(
        referanseId = referanseId,
        samarbeidId = samarbeidId,
        dokumentId = UUID.randomUUID().toString(),
        journalpostId = UUID.randomUUID().toString(),
        publisertDato = LocalDateTime.now().toKotlinLocalDateTime(),
        type = dokumentType.name,
    )
