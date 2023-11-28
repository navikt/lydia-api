package no.nav.lydia.leveranseoversikt

import arrow.core.Either
import ia.felles.definisjoner.bransjer.Bransjer
import io.ktor.client.utils.EmptyContent.status
import io.ktor.http.*
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraværsstatistikk.api.SnittFilter
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsnøkkel
import no.nav.lydia.sykefraværsstatistikk.api.Sorteringsretning
import no.nav.lydia.sykefraværsstatistikk.api.Sykefraværsprosent
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere
import no.nav.lydia.tilgangskontroll.NavAnsatt
import no.nav.lydia.virksomhet.domene.Sektor

class LeveranseoversiktService(val sykefraværsstatistikkService: SykefraværsstatistikkService) {
    fun hentMineLeveranser(saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle): Either<Feil, LeveranseoversiktDto> {
        // hent mine virksomheter
        val mineVirksomheter = sykefraværsstatistikkService.søkEtterVirksomheter(søkeparametere = Søkeparametere(
            navIdenter = setOf(saksbehandler.navIdent),
            kommunenummer= emptySet(),
            næringsgruppeKoder= emptySet(),
            sorteringsnøkkel= Sorteringsnøkkel.TAPTE_DAGSVERK,
            sorteringsretning= Sorteringsretning.SYNKENDE,
            sykefraværsprosentFra= null,
            sykefraværsprosentTil= null,
            snittFilter= null,
            ansatteFra= null,
            ansatteTil= null,
            status= null,
            side= 1,
            bransjeprogram= emptySet(),
            sektor= emptySet(),
            ))

        // hent leveranser på mine virksomheter


        // returner heile rakla



        return Either.Left(Feil("Vi har ikke implementert dette endepunktet ennå", HttpStatusCode.InternalServerError));
    }


}
