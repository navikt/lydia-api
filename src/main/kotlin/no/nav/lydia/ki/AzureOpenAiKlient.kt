package no.nav.lydia.ki

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.client.statement.HttpResponse
import io.ktor.client.statement.bodyAsText
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.jsonPrimitive
import no.nav.lydia.AzureOpenAi
import no.nav.lydia.felles.Feil
import org.slf4j.LoggerFactory

//TODO: Burde deles opp fra domenelogikk slik at klienten kan gjenbrukes senere
class AzureOpenAiKlient(
    private val config: AzureOpenAi,
) {
    companion object {
        const val API_VERSION = "2025-04-01-preview"
        //TODO: sjekk MAKS_TOKENS
        private const val MAKS_TOKENS = 4000
        //TODO: sjekk om det skal være medium eller low
        private const val REASONING_EFFORT = "low"
        private const val TIMEOUT_MS = 30_000L

        // Samme oversettelser som team toi
        private val INNHOLDSFILTER_KATEGORIER = mapOf(
            "hate" to "hatefull tekst",
            "jailbreak" to "tekst som prøver å forbigå retningslinjene",
            "self_harm" to "tekst om selvskading",
            "sexual" to "seksuelt innhold",
            "violence" to "voldelig innhold",
        )
    }

    private val log = LoggerFactory.getLogger(this::class.java)

    private val json = Json {
        ignoreUnknownKeys = true
        encodeDefaults = true
    }

    private val httpClient = HttpClient(CIO) {
        install(ContentNegotiation) { json(json) }
        install(HttpTimeout) { requestTimeoutMillis = TIMEOUT_MS }
        expectSuccess = false
    }

    private val url = "${config.endpoint.trimEnd('/')}/openai/deployments/${config.deployment}/chat/completions"

    suspend fun vurderPersonvern(filtrertTekst: String): Either<Feil, Personvernvurdering> =
        systemMelding().flatMap { systemMelding ->
            Either
                .catch {
                    httpClient.post(url) {
                        parameter("api-version", API_VERSION)
                        header("api-key", config.apiKey)
                        contentType(ContentType.Application.Json)
                        setBody(lagForespørsel(systemMelding, filtrertTekst))
                    }
                }.mapLeft {
                    log.warn("Kall mot Azure OpenAI feilet: ${it::class.simpleName}")
                    KiFeil.`kall mot KI feilet`
                }.flatMap { respons -> tolkRespons(respons) }
        }

    // Hashen sjekkes per forespørsel (som toi), så en feil hash bare gir 500 fra KI-sjekken i stedet for å stoppe oppstarten av appen
    private fun systemMelding(): Either<Feil, String> =
        Either
            .catch { PersonvernPrompt.systemMelding() }
            .mapLeft {
                log.error("Ugyldig hash for personvernprompten, KI-sjekken svarer med 500 til HASH er rettet")
                KiFeil.`ugyldig systemprompt`
            }

    private fun lagForespørsel(systemMelding: String, filtrertTekst: String) =
        AzureOpenAiForespørsel(
            messages = listOf(
                PromptMelding(role = "system", content = systemMelding),
                PromptMelding(role = "user", content = filtrertTekst),
            ),
            maksTokens = MAKS_TOKENS,
            reasoningEffort = REASONING_EFFORT,
            svarformat = Svarformat(
                type = "json_schema",
                jsonSchema = JsonSchemaSpesifikasjon(
                    name = "personvernvurdering",
                    strict = true,
                    schema = personvernSchema,
                ),
            ),
        )

    private suspend fun tolkRespons(respons: HttpResponse): Either<Feil, Personvernvurdering> =
        when (respons.status) {
            HttpStatusCode.OK ->
                Either
                    .catch { json.decodeFromString<AzureOpenAiSvar>(respons.bodyAsText()) }
                    .mapLeft { KiFeil.`ugyldig svar fra KI` }
                    .flatMap { it.tilPersonvernvurdering() }

            //TODO: burde personvernflagget kanskje ikke være true her men heller endres til eget flagg for badrequest?
            HttpStatusCode.BadRequest -> {
                val kategorier = innholdsfilterKategorier(respons.bodyAsText())
                if (kategorier != null) {
                    Personvernvurdering(
                        identifiserbarEnkeltperson = false,
                        helseopplysningOmEnkeltperson = false,
                        personvernflagget = true,
                        begrunnelse = "Teksten ble stoppet av innholdsfilteret til KI-leverandøren og trigger: " +
                            "${kategorier.joinToString(", ")}. Den kan derfor ikke vurderes av KI.",
                        stoppetAvInnholdsfilter = true,
                    ).right()
                } else {
                    log.warn("Azure OpenAI svarte med 400 uten innholdsfilter")
                    KiFeil.`kall mot KI feilet`.left()
                }
            }

            HttpStatusCode.TooManyRequests -> {
                log.warn("Azure OpenAI svarte med 429 For mange forespørsler")
                KiFeil.`for mange forespørsler mot KI`.left()
            }

            else -> {
                log.warn("Azure OpenAI svarte med uventet status ${respons.status.value}")
                KiFeil.`kall mot KI feilet`.left()
            }
        }

    // Returnerer null når 400-svaret ikke kommer fra innholdsfilteret
    private fun innholdsfilterKategorier(body: String): List<String>? =
        Either
            .catch { json.decodeFromString<AzureFeilSvar>(body) }
            .getOrNull()
            ?.error
            ?.innererror
            ?.contentFilterResult
            ?.let { resultat ->
                resultat
                    .filter { (_, kategori) -> kategori.erFiltrert() }
                    .map { (navn, _) -> INNHOLDSFILTER_KATEGORIER[navn] ?: navn }
                    .ifEmpty { listOf("ukjent kategori") }
            }

    private fun JsonElement.erFiltrert() =
        (this as? JsonObject)?.get("filtered")?.jsonPrimitive?.booleanOrNull == true

    private fun AzureOpenAiSvar.tilPersonvernvurdering(): Either<Feil, Personvernvurdering> {
        val valg = choices.firstOrNull() ?: return KiFeil.`ugyldig svar fra KI`.left()
        if (valg.message.refusal != null) return KiFeil.`KI avslo å vurdere teksten`.left()
        if (valg.finishReason != "stop") return KiFeil.`ufullstendig svar fra KI`.left()
        val innhold = valg.message.content ?: return KiFeil.`ugyldig svar fra KI`.left()
        return Either
            .catch { json.decodeFromString<Personvernvurdering>(innhold) }
            .mapLeft { KiFeil.`ugyldig svar fra KI` }
    }
}
