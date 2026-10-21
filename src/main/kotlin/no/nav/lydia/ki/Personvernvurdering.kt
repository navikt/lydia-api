package no.nav.lydia.ki

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonObject

@Serializable
data class Personvernvurdering(
    val identifiserbarEnkeltperson: Boolean,
    val helseopplysningOmEnkeltperson: Boolean,
    val personvernflagget: Boolean,
    val begrunnelse: String,
    // Ikke en del av schemaet, så modellen setter den aldri. Settes av klienten når Azure sitt innholdsfilter stopper teksten.
    val stoppetAvInnholdsfilter: Boolean = false,
)

//TODO: Diskuter om dette er dataen vi skal lagre, og undersøk om det finnes noe bedre måte å gjøre dette på
// Strict json_schema krever at alle felter står i "required" og "additionalProperties": false
internal val personvernSchema: JsonObject =
    Json
        .parseToJsonElement(
            """
            {
              "type": "object",
              "properties": {
                "identifiserbarEnkeltperson": { "type": "boolean" },
                "helseopplysningOmEnkeltperson": { "type": "boolean" },
                "personvernflagget": { "type": "boolean" },
                "begrunnelse": { "type": "string" }
              },
              "required": [
                "identifiserbarEnkeltperson",
                "helseopplysningOmEnkeltperson",
                "personvernflagget",
                "begrunnelse"
              ],
              "additionalProperties": false
            }
            """.trimIndent(),
        ).jsonObject

@Serializable
internal data class PromptMelding(
    val role: String,
    val content: String,
)

@Serializable
internal data class JsonSchemaSpesifikasjon(
    val name: String,
    val strict: Boolean,
    val schema: JsonObject,
)

@Serializable
internal data class Svarformat(
    val type: String,
    @SerialName("json_schema") val jsonSchema: JsonSchemaSpesifikasjon,
)

@Serializable
internal data class AzureOpenAiForespørsel(
    val messages: List<PromptMelding>,
    @SerialName("max_completion_tokens") val maksTokens: Int,
    @SerialName("reasoning_effort") val reasoningEffort: String,
    @SerialName("response_format") val svarformat: Svarformat,
)

@Serializable
internal data class AzureOpenAiSvar(
    val choices: List<ChatValg> = emptyList(),
)

@Serializable
internal data class ChatValg(
    @SerialName("finish_reason") val finishReason: String? = null,
    val message: AssistentMelding,
)

@Serializable
internal data class AssistentMelding(
    val content: String? = null,
    val refusal: String? = null,
)

// Body-en Azure sender ved 400 Bad Request. Brukes kun for å oppdage om innholdsfilteret stoppet teksten.
@Serializable
internal data class AzureFeilSvar(
    val error: AzureFeil? = null,
)

// Selve feilen fra Azure. Detaljene om innholdsfilteret ligger i innererror.
@Serializable
internal data class AzureFeil(
    val code: String? = null,
    val innererror: AzureIndreFeil? = null,
)

// Detaljer om feilen. content_filter_result finnes bare når innholdsfilteret stoppet teksten.
@Serializable
internal data class AzureIndreFeil(
    val code: String? = null,
    // Rå JsonObject med vilje: Azure kan legge til kategorier eller endre formatet.
    // Da hopper vi over verdier vi ikke forstår, i stedet for at hele tolkingen feiler.
    @SerialName("content_filter_result") val contentFilterResult: JsonObject? = null,
)
