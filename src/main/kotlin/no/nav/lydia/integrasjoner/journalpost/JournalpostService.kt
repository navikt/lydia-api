package no.nav.lydia.integrasjoner.journalpost

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpPost
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.integrasjoner.pdfgen.ArbeidsgiverDto
import no.nav.lydia.integrasjoner.pdfgen.BistandDto
import no.nav.lydia.integrasjoner.pdfgen.PiaPdfgenService
import no.nav.lydia.integrasjoner.pdfgen.SakDto
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.obo.OboTokenUtveksler
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.domene.Virksomhet
import org.slf4j.LoggerFactory
import java.time.ZonedDateTime

class JournalpostService(
	naisEnvironment: NaisEnvironment,
	val pdfgenService: PiaPdfgenService,
	val oboTokenUtveksler: OboTokenUtveksler,
	val virksomhetRepository: VirksomhetRepository,
) {
	private val log = LoggerFactory.getLogger(this::class.java)
	private val url = naisEnvironment.integrasjoner.journalpostUrl
	private val json = Json {
		ignoreUnknownKeys = true
	}

	fun journalfør(sakshendelse: IASakshendelse, navAnsattMedSaksbehandlerRolle: NavAnsatt.NavAnsattMedSaksbehandlerRolle): Either<Feil, JournalpostResultatDto> {
		val virksomhet = virksomhetRepository.hentVirksomhet(sakshendelse.orgnummer)
			?: return JournalpostFeil.FantIkkeVirksomhet.left()

		val pdf = pdfgenService.genererBase64EnkodetBistandPdf(bistand = BistandDto(
			dato = ZonedDateTime.now().toString(),
			arbeidsgiver = ArbeidsgiverDto(
				orgnummer = virksomhet.orgnr,
				navn = virksomhet.navn
			),
			sak = SakDto(
				saksnummer = sakshendelse.saksnummer,
				eier = navAnsattMedSaksbehandlerRolle.navIdent
			)
		))

		return pdf.flatMap { base64EnkodetPdf ->
			oboTokenUtveksler.veksleTokenTil(navAnsattMedSaksbehandlerRolle.token, "").flatMap { oboToken ->
				val journalpostDto = journalpostDto(sakshendelse, virksomhet, base64EnkodetPdf)
				journalfør(journalpostDto, oboToken.access_token)
			}
		}
	}

	private fun journalpostDto(
		sakshendelse: IASakshendelse,
		virksomhet: Virksomhet,
		pdf: String
	): JournalpostDto {
		val journalpostDto = JournalpostDto(
			eksternReferanseId = sakshendelse.id,
			tittel = "IA-bistand",
			journalposttype = JournalpostType.UTGAAENDE,
			journalfoerendeEnhet = sakshendelse.navEnhet.enhetsnummer,
			kanal = Kanal.NAV_NO,
			avsenderMottaker = AvsenderMottaker(
				id = sakshendelse.orgnummer,
				idType = IdType.ORGNR,
				navn = virksomhet.navn,
			),
			bruker = Bruker(
				id = sakshendelse.orgnummer,
				idType = IdType.ORGNR,
			),
			sak = Sak(
				sakstype = Sakstype.FAGSAK,
				fagsakId = sakshendelse.saksnummer,
			),
			dokumenter = listOf(
				Dokument(
					tittel = "",
					dokumentvarianter = listOf(
						DokumentVariant(
							filtype = FilType.PDFA,
							variantformat = Variantformat.ARKIV,
							fysiskDokument = pdf
						)
					)
				)
			)
		)
		return journalpostDto
	}

	private fun journalfør(
		journalpostDto: JournalpostDto,
		accessToken: String
	) =
		url.httpPost(listOf("forsoekFerdigstill" to true))
			.jsonBody(Json.encodeToString<JournalpostDto>(journalpostDto))
			.authentication().bearer(accessToken)
			.response().third.fold(
				success = {
					val resultat = json.decodeFromString<JournalpostResultatDto>(it.toString(charset = Charsets.UTF_8))
					log.info("Journalførte $resultat")
					resultat.right()
				},
				failure = {
					log.error("Klarte ikke å journalføre", it)
					JournalpostFeil.FeillendeJournalpost.left()
				}
			)

	object JournalpostFeil {
		val FeillendeJournalpost = Feil(
			feilmelding = "Klarte ikke å journalføre",
			httpStatusCode = HttpStatusCode.InternalServerError
		)
		val FantIkkeVirksomhet = Feil(
			feilmelding = "Fant ikke virksomhet",
			httpStatusCode = HttpStatusCode.InternalServerError
		)
	}
}
