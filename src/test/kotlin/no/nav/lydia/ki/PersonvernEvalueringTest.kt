package no.nav.lydia.ki

import arrow.core.Either
import kotlinx.coroutines.runBlocking
import no.nav.lydia.AzureOpenAi
import no.nav.lydia.felles.Feil
import no.nav.lydia.personopplysninger.PersondataFilter
import java.io.File
import kotlin.test.Ignore
import kotlin.test.Test

//TODO:Gjennomgang av tester må fremdeles skje
/**
 * Evaluerer personvernprompten mot ekte Azure OpenAI. Kjøres manuelt når prompt, modell eller parametre endres.
 *
 * Fjern @Ignore lokalt og sett AZURE_OPENAI_ENDPOINT, AZURE_OPENAI_API_KEY og AZURE_OPENAI_DEPLOYMENT.
 * Bruk kun syntetiske tekster, aldri ekte personopplysninger.
 * Rapporten skrives til build/personvernEvalueringResultater.txt.
 */
class PersonvernEvalueringTest {
    companion object {
        private const val PAUSE_MELLOM_KALL_MS = 2_000L
        private const val PAUSE_VED_429_MS = 5_000L
        private const val MAKS_FORSØK = 3
        private const val RAPPORTFIL = "build/personvernEvalueringResultater.txt"

        // Pair(forventet personvernflagget, tekst)
        private val testtekster = listOf(
            // Identifiserbar enkeltperson med helseopplysning: skal flagges
            Pair(true, "Ola har depresjon som fører til sykefravær"),
            Pair(true, "Kari er gravid og har vært sykmeldt i tre måneder"),
            Pair(true, "Lederen på lageret har kreft og er ute av arbeid"),
            Pair(true, "Den eneste sykepleieren på nattskiftet sliter med rusproblemer"),
            Pair(true, "Per i regnskap har ryggplager og trenger tilrettelegging"),
            Pair(true, "Følge opp Anne som er sykmeldt med utbrenthet"),
            Pair(true, "Ansatt med initialene K.L. har angst og møter ikke på jobb"),
            Pair(true, "Daglig leder er langtidssykmeldt etter hjerteinfarkt"),
            Pair(true, "Hjelpe Mohammed tilbake i jobb etter operasjonen i kneet"),
            Pair(true, "Lærlingen vår har ADHD og trenger tettere oppfølging"),

            // Generelle mål uten enkeltperson: skal ikke flagges
            Pair(false, "Redusere sykefraværet i virksomheten"),
            Pair(false, "Redusere sykefraværet med 10 % innen utgangen av året"),
            Pair(false, "Styrke det psykososiale arbeidsmiljøet"),
            Pair(false, "Øke kompetansen til lederne i å følge opp sykmeldte"),
            Pair(false, "Etablere gode rutiner for tilrettelegging ved muskel- og skjelettplager"),
            Pair(false, "Bedre samarbeidet mellom ledelse, tillitsvalgte og verneombud"),
            Pair(false, "Forebygge belastningsskader i produksjonen"),
            Pair(false, "Utarbeide en plan for oppfølging av gravide arbeidstakere"),
            Pair(false, "Gjennomføre medarbeidersamtaler om trivsel og helse"),
            Pair(false, "Ansatte med psykiske plager skal få bedre tilrettelegging"),

            // Grensetilfeller
            Pair(false, "Lederen skal følge opp sykmeldte ansatte tettere"),
            Pair(true, "Ola skal lede arbeidsmiljøgruppen"),
            Pair(true, "En ansatt i kantina har diabetes og må ha faste pauser"),
            Pair(false, "Mange på lageret har vondt i ryggen"),
            Pair(true, "Hun som begynte i mars er sykmeldt på grunn av svangerskapet"),
        )
    }

    private data class Resultat(
        val forventet: Boolean,
        val tekst: String,
        val faktisk: Boolean?,
        val innholdsfiltrert: Boolean,
        val begrunnelse: String?,
        val feil: Feil?,
    )

    @Ignore("Testen skal kun kjøres manuelt ved behov")
    @Test
    fun `evaluer personvernprompten mot ekte modell`() {
        val klient = AzureOpenAiKlient(config = AzureOpenAi())

        val resultater = testtekster.map { (forventet, tekst) ->
            val svar = vurderMedRetry(klient, PersondataFilter.filtrerUtPersonsensitiveData(tekst))
            Thread.sleep(PAUSE_MELLOM_KALL_MS)
            svar.fold(
                ifLeft = {
                    Resultat(forventet, tekst, faktisk = null, innholdsfiltrert = false, begrunnelse = null, feil = it)
                },
                ifRight = {
                    Resultat(
                        forventet = forventet,
                        tekst = tekst,
                        faktisk = it.personvernflagget,
                        innholdsfiltrert = it.stoppetAvInnholdsfilter,
                        begrunnelse = it.begrunnelse,
                        feil = null,
                    )
                },
            )
        }

        skrivRapport(resultater)
    }

    private fun vurderMedRetry(
        klient: AzureOpenAiKlient,
        tekst: String,
    ): Either<Feil, Personvernvurdering> {
        var svar = runBlocking { klient.vurderPersonvern(tekst) }
        var forsøk = 1
        while (svar.leftOrNull() == KiFeil.`for mange forespørsler mot KI` && forsøk < MAKS_FORSØK) {
            Thread.sleep(PAUSE_VED_429_MS)
            svar = runBlocking { klient.vurderPersonvern(tekst) }
            forsøk++
        }
        return svar
    }

    private fun skrivRapport(resultater: List<Resultat>) {
        val vurderte = resultater.filter { it.faktisk != null }
        val riktige = vurderte.filter { it.faktisk == it.forventet }
        val falskePositive = vurderte.filter { it.faktisk == true && !it.forventet }
        val falskeNegative = vurderte.filter { it.faktisk == false && it.forventet }
        val innholdsfiltrerte = resultater.filter { it.innholdsfiltrert }
        val feilet = resultater.filter { it.feil != null }
        val treffsikkerhet = if (vurderte.isEmpty()) 0.0 else riktige.size * 100.0 / vurderte.size

        val rapport = buildString {
            appendLine("Personvernevaluering")
            appendLine("Prompt: versjon ${PersonvernPrompt.VERSJONSNUMMER}, hash ${PersonvernPrompt.HASH}")
            appendLine("API-versjon: ${AzureOpenAiKlient.API_VERSION}")
            appendLine()
            appendLine("Antall tekster: ${resultater.size}")
            appendLine("Vurdert: ${vurderte.size}, riktige: ${riktige.size}")
            appendLine("Treffsikkerhet: ${"%.1f".format(treffsikkerhet)} %")
            appendLine()
            appendLine("Falske positive (${falskePositive.size}):")
            falskePositive.forEach { appendLine("  - ${it.tekst}") }
            appendLine("Falske negative (${falskeNegative.size}):")
            falskeNegative.forEach { appendLine("  - ${it.tekst}") }
            appendLine("Stoppet av innholdsfilter (${innholdsfiltrerte.size}):")
            innholdsfiltrerte.forEach { appendLine("  - ${it.tekst}: ${it.begrunnelse}") }
            appendLine("Feilet (${feilet.size}):")
            feilet.forEach { appendLine("  - ${it.tekst}: ${it.feil?.feilmelding}") }
        }

        File(RAPPORTFIL).apply { parentFile.mkdirs() }.writeText(rapport)
        println(rapport)
    }
}
