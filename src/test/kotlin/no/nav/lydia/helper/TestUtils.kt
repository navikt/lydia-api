package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.ResponseResultOf
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import io.kotest.inspectors.forExactly
import no.nav.lydia.ia.sak.api.LocalDateTimeTypeAdapter
import java.time.LocalDateTime

inline fun <T, C : Collection<T>> C.forExactlyOne(fn: (T) -> Unit): C = this.forExactly(1, fn)

val localDateTimeTypeAdapter: Gson = GsonBuilder()
    .registerTypeAdapter(LocalDateTime::class.java, LocalDateTimeTypeAdapter.nullSafe())
    .create()

fun <T> ResponseResultOf<T>.statuskode() = this.second.statusCode
