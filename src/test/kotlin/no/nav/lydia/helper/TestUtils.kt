package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.ResponseResultOf
import io.kotest.inspectors.forExactly

inline fun <T, C : Collection<T>> C.forExactlyOne(fn: (T) -> Unit): C = this.forExactly(1, fn)

fun <T> ResponseResultOf<T>.statuskode() = this.second.statusCode

fun <T> ResponseResultOf<T>.body(): String = this.second.body().asString(contentType = "text/plain; charset=utf-8")
