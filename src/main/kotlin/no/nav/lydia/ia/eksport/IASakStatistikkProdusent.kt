package no.nav.lydia.ia.eksport

import ia.felles.definisjoner.bransjer.Bransje
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse.Companion.utleddPeriodeForStatistikk
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.sykefraværsstatistikk.SistePubliseringService
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraværsstatistikk.import.Kvartal
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import no.nav.lydia.virksomhet.domene.Virksomhet

class IASakStatistikkProdusent(
    kafka: Kafka,
    topic: Topic = Topic.IA_SAK_STATISTIKK_TOPIC,
    private val virksomhetRepository: VirksomhetRepository,
    private val sykefraværsstatistikkService: SykefraværsstatistikkService,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val geografiService: GeografiService,
    sistePubliseringService: SistePubliseringService,
) : KafkaProdusent<IASak>(kafka, topic),
    Observer<IASak> {
    private val allPubliseringsinfo = sistePubliseringService.hentAllPubliseringsinfo()
    private val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()

    override fun receive(input: IASak) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: IASak): Pair<String, String> {
        val virksomhet = virksomhetRepository.hentVirksomhet(input.orgnr)
        val fylkesnummer = virksomhet?.let { geografiService.finnFylke(it.kommunenummer) }?.nummer

        val hendelse = iaSakshendelseRepository.hentHendelse(input.endretAvHendelseId)
        val periode = hendelse?.utleddPeriodeForStatistikk(allPubliseringsinfo = allPubliseringsinfo)

        val virksomhetsstatistikkSiste4Kvartal = sykefraværsstatistikkService.takeIf { periode == gjeldendePeriode }
            ?.hentSykefraværForVirksomhetSiste4Kvartal(input.orgnr)
            ?.getOrNull()

        val virksomhetsstatistikkSisteKvartal = sykefraværsstatistikkService.hentVirksomhetsstatistikkSisteKvartal(
            orgnr = input.orgnr,
            periode = periode,
        ).getOrNull()

        val nøkkel = input.saksnummer
        val verdi = IASakStatistikkValue(
            saksnummer = input.saksnummer,
            orgnr = input.orgnr,
            eierAvSak = input.eidAv,
            status = input.status,
            endretAvHendelseId = input.endretAvHendelseId,
            hendelse = hendelse?.hendelsesType,
            endretAv = hendelse?.opprettetAv,
            endretAvRolle = hendelse?.opprettetAvRolle,
            ikkeAktuelBegrunnelse = if (hendelse is VirksomhetIkkeAktuellHendelse) hendelse.valgtÅrsak.begrunnelser.toString() else null,
            opprettetTidspunkt = input.opprettetTidspunkt.toKotlinLocalDateTime(),
            endretTidspunkt = input.endretTidspunkt?.toKotlinLocalDateTime() ?: input.opprettetTidspunkt.toKotlinLocalDateTime(),
            avsluttetTidspunkt = if (input.status.regnesSomAvsluttet()) input.endretTidspunkt?.toKotlinLocalDateTime() else null,
            antallPersoner = virksomhetsstatistikkSisteKvartal?.antallPersoner,
            tapteDagsverk = virksomhetsstatistikkSisteKvartal?.tapteDagsverk,
            tapteDagsverkGradert = virksomhetsstatistikkSisteKvartal?.tapteDagsverkGradert,
            muligeDagsverk = virksomhetsstatistikkSisteKvartal?.muligeDagsverk,
            sykefraversprosent = virksomhetsstatistikkSisteKvartal?.sykefraværsprosent,
            graderingsprosent = virksomhetsstatistikkSisteKvartal?.graderingsprosent,
            arstall = virksomhetsstatistikkSisteKvartal?.arstall,
            kvartal = virksomhetsstatistikkSisteKvartal?.kvartal,
            tapteDagsverkSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.tapteDagsverk,
            tapteDagsverkGradertSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.tapteDagsverkGradert,
            muligeDagsverkSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.muligeDagsverk,
            sykefraversprosentSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.sykefraværsprosent,
            graderingsprosentSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.graderingsprosent,
            kvartaler = virksomhetsstatistikkSiste4Kvartal?.kvartaler ?: emptyList(),
            sektor = virksomhet?.sektor,
            neringer = virksomhet?.hentNæringsgrupper() ?: emptyList(),
            bransjeprogram = finnBransje(virksomhet?.hentNæringsgrupper()),
            postnummer = virksomhet?.postnummer,
            kommunenummer = virksomhet?.kommunenummer,
            fylkesnummer = fylkesnummer,
            enhetsnummer = hendelse?.navEnhet?.enhetsnummer,
            enhetsnavn = hendelse?.navEnhet?.enhetsnavn,
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    companion object {
        private fun Virksomhet?.hentNæringsgrupper() =
            listOfNotNull(
                this?.næringsundergruppe1,
                this?.næringsundergruppe2,
                this?.næringsundergruppe3,
            )
    }

    @Serializable
    data class IASakStatistikkValue(
        val saksnummer: String,
        val orgnr: String,
        val eierAvSak: String?,
        val status: IASak.Status,
        val endretAvHendelseId: String,
        val hendelse: IASakshendelseType?,
        val endretAv: String?,
        val endretAvRolle: Rolle?,
        val ikkeAktuelBegrunnelse: String?,
        val opprettetTidspunkt: LocalDateTime,
        val endretTidspunkt: LocalDateTime,
        val avsluttetTidspunkt: LocalDateTime?,
        val antallPersoner: Double?,
        val tapteDagsverk: Double?,
        val tapteDagsverkGradert: Double?,
        val muligeDagsverk: Double?,
        val sykefraversprosent: Double?,
        val graderingsprosent: Double?,
        val arstall: Int?,
        val kvartal: Int?,
        val tapteDagsverkSiste4Kvartal: Double?,
        val tapteDagsverkGradertSiste4Kvartal: Double?,
        val muligeDagsverkSiste4Kvartal: Double?,
        val sykefraversprosentSiste4Kvartal: Double?,
        val graderingsprosentSiste4Kvartal: Double?,
        val kvartaler: List<Kvartal>,
        val sektor: Sektor?,
        val neringer: List<Næringsgruppe>,
        val bransjeprogram: Bransje?,
        val postnummer: String?,
        val kommunenummer: String?,
        val fylkesnummer: String?,
        val enhetsnummer: String?,
        val enhetsnavn: String?,
    )
}

fun finnBransje(næringsgrupper: List<Næringsgruppe>?): Bransje? =
    næringsgrupper?.map { it.kode }?.firstNotNullOfOrNull { kode ->
        Bransje.fra(næringskode = kode)
    }
