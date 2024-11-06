package no.nav.lydia.ia.eksport

import ia.felles.definisjoner.bransjer.Bransje
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.VirksomhetIkkeAktuellHendelse
import no.nav.lydia.sykefraværsstatistikk.SistePubliseringService
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSiste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraværsstatistikk.import.Kvartal
import no.nav.lydia.tilgangskontroll.fia.Rolle
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
    sistePubliseringService: SistePubliseringService,
) : Observer<IASak> {
    private val allPubliseringsinfo = sistePubliseringService.hentAllPubliseringsinfo()
    private val gjeldendePeriode = sistePubliseringService.hentGjelendePeriode()

    override fun receive(input: IASak) {
        sendTilKafka(input = input)
    }

    fun reEksporter(input: IASak) {
        val hendelse = iaSakshendelseRepository.hentHendelse(input.endretAvHendelseId)!!
        val periode = allPubliseringsinfo.filter { info ->
            hendelse.opprettetTidspunkt.toLocalDate().isAfter(info.sistePubliseringsdato.toJavaLocalDate()) &&
                hendelse.opprettetTidspunkt.toLocalDate().isBefore(info.nestePubliseringsdato.toJavaLocalDate())
        }.map {
            it.gjeldendePeriode.tilPeriode()
        }.firstOrNull() ?: Periode.fraDato(hendelse.opprettetTidspunkt)

        sendTilKafka(input, periode)
    }

    private fun sendTilKafka(
        input: IASak,
        periode: Periode? = gjeldendePeriode,
    ) {
        val hendelse = iaSakshendelseRepository.hentHendelse(input.endretAvHendelseId)
        val virksomhet = virksomhetService.hentVirksomhet(input.orgnr)
        val virksomhetsstatistikkSiste4Kvartal =
            if (periode == gjeldendePeriode) {
                sykefraværsstatistikkService.hentSykefraværForVirksomhetSiste4Kvartal(input.orgnr).getOrNull()
            } else {
                null
            }
        val virksomhetsstatistikkSisteKvartal =
            sykefraværsstatistikkService.hentVirksomhetsstatistikkSisteKvartal(orgnr = input.orgnr, periode = periode)
                .getOrNull()
        val fylkesnummer = virksomhet?.let { geografiService.finnFylke(it.kommunenummer) }
        val kafkaMelding = input.tilKafkaMelding(
            hendelse,
            virksomhet,
            fylkesnummer?.nummer,
            virksomhetsstatistikkSiste4Kvartal,
            virksomhetsstatistikkSisteKvartal,
        )
        produsent.sendMelding(Topic.IA_SAK_STATISTIKK_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
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
                endretAv = hendelse?.opprettetAv,
                endretAvRolle = hendelse?.opprettetAvRolle,
                ikkeAktuelBegrunnelse = if (hendelse is VirksomhetIkkeAktuellHendelse) {
                    hendelse.valgtÅrsak.begrunnelser.toString()
                } else {
                    null
                },
                opprettetTidspunkt = this.opprettetTidspunkt.toKotlinLocalDateTime(),
                endretTidspunkt = this.endretTidspunkt?.toKotlinLocalDateTime()
                    ?: this.opprettetTidspunkt.toKotlinLocalDateTime(),
                avsluttetTidspunkt = if (this.status.regnesSomAvsluttet()) {
                    this.endretTidspunkt?.toKotlinLocalDateTime()
                } else {
                    null
                },
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
            return key to Json.encodeToString(value)
        }

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
        val status: IAProsessStatus,
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

fun finnBransje(næringsgrupper: List<Næringsgruppe>?): Bransje? {
    val næringskoderUtenPunktum = næringsgrupper?.map { it.kode }?.map { kode ->
        kode.replace(".", "")
    }

    return næringskoderUtenPunktum?.firstNotNullOfOrNull {
        Bransje.fra(it)
    }
}
