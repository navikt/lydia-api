package no.nav.lydia.container.integrasjoner.kvittering

import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.hentDokumentPublisering
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.sendKvittering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
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

        val kvittering = dokument.tilKvittering()
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = kvittering.dokumentId,
            topic = Topic.DOKUMENT_KVITTERING_TOPIC,
            melding = json.encodeToString(kvittering),
        )

        val dokumentEtterPublisering = hentDokumentPublisering(dokument.referanseId)
        dokumentEtterPublisering.dokumentId shouldBe kvittering.dokumentId
        dokumentEtterPublisering.status shouldBe DokumentPublisering.Status.PUBLISERT
    }

    @Test
    fun `skal kunne publisere samarbeidsplan flere ganger`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())

        val dokument = publiserDokument(
            dokumentReferanseId = plan.id,
            dokumentType = DokumentPublisering.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        ).third.get()
        sendKvittering(dokument)

        val dokumentEtterPublisering = hentDokumentPublisering(
            dokumentReferanseId = dokument.referanseId,
            dokumentType = DokumentPublisering.Type.SAMARBEIDSPLAN,
        )
        dokumentEtterPublisering.status shouldBe DokumentPublisering.Status.PUBLISERT

        val dokumentV2 = publiserDokument(
            dokumentReferanseId = plan.id,
            dokumentType = DokumentPublisering.Type.SAMARBEIDSPLAN,
            token = authContainerHelper.saksbehandler1.token,
        ).third.get()
        sendKvittering(dokumentV2)

        val dokumentEtterRePublisering = hentDokumentPublisering(
            dokumentReferanseId = dokumentV2.referanseId,
            dokumentType = DokumentPublisering.Type.SAMARBEIDSPLAN,
        )
        dokumentEtterRePublisering.status shouldBe DokumentPublisering.Status.PUBLISERT

        val dokumenter = TestContainerHelper.postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select dokument_id from dokument_til_publisering where referanse_id = '${plan.id}'",
        )
        dokumenter.forAtLeastOne { it shouldBe dokumentEtterPublisering.dokumentId }
        dokumenter.forAtLeastOne { it shouldBe dokumentEtterRePublisering.dokumentId }
    }
}

internal fun DokumentPubliseringDto.tilKvittering() =
    KvitteringDto(
        referanseId = referanseId,
        samarbeidId = samarbeidId,
        dokumentId = UUID.randomUUID().toString(),
        journalpostId = UUID.randomUUID().toString(),
        publisertDato = LocalDateTime.now().toKotlinLocalDateTime(),
        type = dokumentType.name,
    )
