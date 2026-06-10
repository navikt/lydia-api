package no.nav.lydia.abc.felles

import java.util.UUID

fun String.tilUUID(hvaErJeg: String): UUID =
    try {
        UUID.fromString(this)
    } catch (e: Exception) {
        throw IllegalArgumentException(
            "Kunne ikke konvertere '$this' til UUID for $hvaErJeg",
            e,
        )
    }
