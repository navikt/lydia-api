package no.nav.lydia.container.integrasjoner.kvittering

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.hentDokumentPublisering
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
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
