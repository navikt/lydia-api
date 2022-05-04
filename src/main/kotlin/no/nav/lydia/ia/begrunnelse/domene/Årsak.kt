package no.nav.lydia.ia.begrunnelse.domene

class Årsak(val navn: String, val begrunnelser: List<Begrunnelse>)

class Begrunnelse(val id: Int, val navn: String)