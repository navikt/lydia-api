package no.nav.lydia.abc.tilstandsmaskin

import no.nav.lydia.abc.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.abc.tilstandsmaskin.tilstand.AlleSamarbeidIVirksomhetErAvsluttet
import no.nav.lydia.abc.tilstandsmaskin.tilstand.Tilstand
import no.nav.lydia.abc.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import java.time.LocalDate
import java.util.concurrent.atomic.AtomicReference

class Tilstandsmaskin(
    startTilstand: Tilstand = VirksomhetKlarTilVurdering,
    private val fiaKontekst: FiaKontekst,
) {
    private val tilstandRef = AtomicReference(startTilstand)

    var nåværendeTilstand: Tilstand
        get() = tilstandRef.get()
        set(value) = tilstandRef.set(value)

    val saksnummer: String?
        get() = fiaKontekst.saksnummer

    fun hentTilstandForVirksomhet(orgnr: String): VirksomhetTilstandDto? {
        val eksisterendeTilstand: VirksomhetTilstandDto? = fiaKontekst.tilstandVirksomhetRepository.hentVirksomhetTilstand(orgnr)
        return eksisterendeTilstand
    }

    fun prosesserHendelse(hendelse: no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse): no.nav.lydia.abc.tilstandsmaskin.Konsekvens {
        val konsekvensAvUtførtTransisjon: no.nav.lydia.abc.tilstandsmaskin.Konsekvens = nåværendeTilstand.utførTransisjon(hendelse, fiaKontekst)

        nåværendeTilstand = konsekvensAvUtførtTransisjon.nyTilstand
        return konsekvensAvUtførtTransisjon
    }
}

class TilstandsmaskinBuilder private constructor(
    private val fiaKontekst: FiaKontekst,
) {
    companion object {
        fun medKontekst(fiaKontekst: FiaKontekst): TilstandsmaskinBuilder = TilstandsmaskinBuilder(fiaKontekst)

        fun harAktiveSamarbeid(
            fiaKontekst: FiaKontekst,
            saksnummer: String,
        ): Boolean {
            val aktiveSamarbeid = fiaKontekst.iASamarbeidService.hentAktiveSamarbeid(saksnummer)
            return aktiveSamarbeid.any { samarbeid -> samarbeid.status == IASamarbeid.Status.AKTIV }
        }

        fun harSamarbeidOgAlleErAvsluttet(
            fiaKontekst: FiaKontekst,
            saksnummer: String,
        ): Boolean {
            val alleSamarbeid = fiaKontekst.iASamarbeidService.hentAlleSamarbeidSomIkkeErSlettet(saksnummer = saksnummer)
            return alleSamarbeid.isNotEmpty() && alleSamarbeid
                .all { it.status == IASamarbeid.Status.AVBRUTT || it.status == IASamarbeid.Status.FULLFØRT }
        }

        fun oppdaterTilAlleSamarbeidAvsluttetMedAutomatiskOppdatering(
            orgnr: String,
            fiaKontekst: FiaKontekst,
            planlagtDato: LocalDate? = null,
        ) {
            fiaKontekst.tilstandVirksomhetRepository.lagreEllerOppdaterVirksomhetTilstand(
                orgnr = orgnr,
                tilstand = AlleSamarbeidIVirksomhetErAvsluttet.tilVirksomhetIATilstand(),
            )?.also {
                fiaKontekst.tilstandVirksomhetRepository.opprettAutomatiskOppdatering(
                    orgnr = orgnr,
                    startTilstand = AlleSamarbeidIVirksomhetErAvsluttet.tilVirksomhetIATilstand(),
                    planlagtHendelse = GjørVirksomhetKlarTilNyVurdering::class.simpleName!!,
                    nyTilstand = VirksomhetKlarTilVurdering.tilVirksomhetIATilstand(),
                    planlagtDato = planlagtDato ?: LocalDate.now().plusDays(90),
                )
            }
        }
    }

    fun build(orgnr: String): Tilstandsmaskin {
        val tilstandTilVirksomhet = hentTilstandForVirksomhet(orgnr = orgnr)
        return Tilstandsmaskin(
            startTilstand = tilstandTilVirksomhet,
            fiaKontekst = fiaKontekst,
        )
    }

    private fun hentTilstandForVirksomhet(orgnr: String): Tilstand {
        val eksisterendeTilstand: VirksomhetTilstandDto? = fiaKontekst.tilstandVirksomhetRepository.hentVirksomhetTilstand(orgnr)

        // Før migrering (bare i dev-miljø):
        // Hvis det finnes en lagret tilstand i virksomhet_tilstand tabellen, bruk den.
        // Hvis ikke betyr det at virksomheten er ny og skal starte i Tilstand.VirksomhetKlarTilVurdering
        // OBS: hvis virksomhet har eksisterende sak og samarbeid, IKKE bruk Virksomhet i ny flyt
        // OBS-2: Etter migrering skal alle virksomhet med en IA-sak få en tilstand i virksomhet_tilstand tabellen

        return eksisterendeTilstand?.tilstand?.tilTilstand() ?: VirksomhetKlarTilVurdering
    }
}
