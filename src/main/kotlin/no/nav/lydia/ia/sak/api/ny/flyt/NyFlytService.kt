package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import no.nav.lydia.ia.sak.api.Feil

class NyFlytService {
    fun fullførVurderingAvVirksomhetUtenSamarbeid(
        orgnummer: String,
        årsak: String = "Legg til en årsak senere",
    ): Either<Feil, Any?> {
        // lage hendelsen
        // lagre hendelsen
        // oppdater status, og lagre årsak
        // ..
        TODO("Ikke implementert ennå")
    }
}
