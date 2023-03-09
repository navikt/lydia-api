package no.nav.lydia.ia.eksport

import ia.felles.definisjoner.bransjer.Bransjer
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraversstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraversstatistikk.import.Kvartal
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import no.nav.lydia.virksomhet.domene.Sektor
import no.nav.lydia.virksomhet.domene.Virksomhet

class IASakStatistikkProdusent(
    private val produsent: KafkaProdusent,
    private val virksomhetService: VirksomhetService,
    private val sykefraværsstatistikkService: SykefraværsstatistikkService,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val geografiService: GeografiService,
    private val topic: String,
) : Observer<IASak> {

    override fun receive(input: IASak) {
        val hendelse = iaSakshendelseRepository.hentHendelse(input.endretAvHendelseId)
        val virksomhet = virksomhetService.hentVirksomhet(input.orgnr)
        val virksomhetsstatistikkSiste4Kvartal =
            sykefraværsstatistikkService.hentSykefraværForVirksomhetSiste4Kvartal(input.orgnr).orNull()
        val virksomhetsstatistikkSisteKvartal =
            sykefraværsstatistikkService.hentVirksomhetsstatistikkSisteKvartal(input.orgnr).orNull()
        val fylkesnummer = virksomhet?.let { geografiService.finnFylke(it.kommunenummer) }
        val kafkaMelding = input.tilKafkaMelding(
            hendelse,
            virksomhet,
            fylkesnummer?.nummer,
            virksomhetsstatistikkSiste4Kvartal,
            virksomhetsstatistikkSisteKvartal
        )
        produsent.sendMelding(topic, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun IASak.tilKafkaMelding(
            hendelse: IASakshendelse?,
            virksomhet: Virksomhet?,
            fylkesnummer: String?,
            virksomhetsstatistikkSiste4Kvartal: VirksomhetsstatistikkSiste4Kvartal?,
            virksomhetsstatistikkSisteKvartal: VirksomhetsstatistikkSisteKvartal?,
        ): Pair<String, String> {
            val key = this.saksnummer
            val value = IASakStatistikkValue(
                saksnummer = this.saksnummer,
                orgnr = this.orgnr,
                eierAvSak = this.eidAv,
                status = this.status,
                endretAvHendelseId = this.endretAvHendelseId,
                hendelse = hendelse?.hendelsesType,
                ikkeAktuelBegrunnelse = if (hendelse is VirksomhetIkkeAktuellHendelse) hendelse.valgtÅrsak.begrunnelser.toString() else null,
                opprettetTidspunkt = this.opprettetTidspunkt.toKotlinLocalDateTime(),
                endretTidspunkt = this.endretTidspunkt?.toKotlinLocalDateTime()
                    ?: this.opprettetTidspunkt.toKotlinLocalDateTime(),
                avsluttetTidspunkt = if (this.status.ansesSomAvsluttet()) this.endretTidspunkt?.toKotlinLocalDateTime() else null,
                antallPersoner = virksomhetsstatistikkSisteKvartal?.antallPersoner,
                tapteDagsverk = virksomhetsstatistikkSisteKvartal?.tapteDagsverk,
                muligeDagsverk = virksomhetsstatistikkSisteKvartal?.muligeDagsverk,
                sykefraversprosent = virksomhetsstatistikkSisteKvartal?.sykefraversprosent,
                arstall = virksomhetsstatistikkSisteKvartal?.arstall,
                kvartal = virksomhetsstatistikkSisteKvartal?.kvartal,
                tapteDagsverkSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.tapteDagsverk,
                muligeDagsverkSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.tapteDagsverk,
                sykefraversprosentSiste4Kvartal = virksomhetsstatistikkSiste4Kvartal?.tapteDagsverk,
                kvartaler = virksomhetsstatistikkSiste4Kvartal?.kvartaler ?: emptyList(),
                sektor = virksomhet?.sektor,
                næringer = virksomhet?.næringsgrupper ?: emptyList(),
                hovedbransje = finnBransje(virksomhet?.næringsgrupper),
                postnummer = virksomhet?.postnummer,
                kommuneNummer = virksomhet?.kommunenummer,
                fylkesnummer = fylkesnummer
            )
            return key to Json.encodeToString(value)

        }
    }

    @Serializable
    private data class IASakStatistikkValue(
        val saksnummer: String,
        val orgnr: String,
        val eierAvSak: String?,
        val status: IAProsessStatus,
        val endretAvHendelseId: String,
        val hendelse: IASakshendelseType?,
        val ikkeAktuelBegrunnelse: String?,
        val opprettetTidspunkt: LocalDateTime,
        val endretTidspunkt: LocalDateTime,
        val avsluttetTidspunkt: LocalDateTime?,
        val antallPersoner: Double?,
        val tapteDagsverk: Double?,
        val muligeDagsverk: Double?,
        val sykefraversprosent: Double?,
        val arstall: Int?,
        val kvartal: Int?,
        val tapteDagsverkSiste4Kvartal: Double?,
        val muligeDagsverkSiste4Kvartal: Double?,
        val sykefraversprosentSiste4Kvartal: Double?,
        val kvartaler: List<Kvartal>,
        val sektor: Sektor?,
        val næringer: List<Næringsgruppe>,
        val hovedbransje: Bransjer?,
        val postnummer: String?,
        val kommuneNummer: String?,
        val fylkesnummer: String?,
    )
}

fun finnBransje(næringsgrupper: List<Næringsgruppe>?): Bransjer? {
    val hovedkode = næringsgrupper?.firstOrNull()?.kode ?: return null
    val utenPunktum = if (hovedkode.length > 5) "${hovedkode.take(2)}${hovedkode.takeLast(3)}" else hovedkode
    return Bransjer.values()
        .firstOrNull { bransje -> bransje.næringskoder.any { næringskode -> utenPunktum.startsWith(næringskode) } }
}