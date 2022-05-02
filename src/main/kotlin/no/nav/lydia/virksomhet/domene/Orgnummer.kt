package no.nav.lydia.virksomhet.domene

import no.nav.lydia.exceptions.UgyldigFormatException

class Orgnummer(val orgnummer: String?) {
    init {
        if (orgnummer.isNullOrBlank() || orgnummer.length != 9)
            throw UgyldigFormatException("Feil format på orgnummer")
    }

    override fun toString() = orgnummer!!
}