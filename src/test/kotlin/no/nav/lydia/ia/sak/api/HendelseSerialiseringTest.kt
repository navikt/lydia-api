package no.nav.lydia.ia.sak.api

import com.github.guepardoapps.kulid.ULID
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.types.shouldBeTypeOf
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import kotlin.test.Test

class HendelseSerialiseringTest {


    @Test
    fun `skal kunne dekode en serialisert sakshendelse som en VirksomhetIkkeAktuellHendelse når payload er gyldig`() {
        val hendelseDto = IASakshendelseDto(
            orgnummer = "123456789",
            saksnummer = ULID.random(),
            hendelsesType = VIRKSOMHET_ER_IKKE_AKTUELL,
            endretAvHendelseId = ULID.random(),
            payload = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = listOf(BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT, BegrunnelseType.HAR_IKKE_KAPASITET)
            ).toJson()
        )
        val hendelseJson = Json.encodeToString(hendelseDto)
        val hendelseDeserialisert = Json.decodeFromString<IASakshendelseDto>(hendelseJson)

        val navIdent = "R12345"
        val virksomhetIkkeAktuellHendelse = IASakshendelse.fromDto(hendelseDeserialisert, navIdent)
        virksomhetIkkeAktuellHendelse.isRight().shouldBeTrue()
        virksomhetIkkeAktuellHendelse.map {
            it.shouldBeTypeOf<VirksomhetIkkeAktuellHendelse>()
        }

    }

}
