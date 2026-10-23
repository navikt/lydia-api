package no.nav.lydia.personopplysninger

object PersondataFilter {
    private val emailRegex = "[a-zA-Z0-9_+.%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}".toRegex()

    // Tall med 5 eller flere sifre, med eller uten mellomrom eller bindestrek
    private val numberRegex = "\\d(?:[ -]?\\d){4,}".toRegex()

    fun filtrerUtPersonsensitiveData(tekst: String): String =
        tekst
            .let { emailRegex.replace(it, "") }
            .let { numberRegex.replace(it, "") }

    fun inneholderEpost(tekst: String): Boolean = emailRegex.containsMatchIn(tekst)

    fun inneholderTall(tekst: String): Boolean = numberRegex.containsMatchIn(tekst)
}
