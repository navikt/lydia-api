package no.nav.lydia.helper

import io.kotest.inspectors.forExactly

inline fun <T, C : Collection<T>> C.forExactlyOne(fn: (T) -> Unit): C = this.forExactly(1, fn)

fun <T> TestResponseTriple<T>.statuskode() = this.second.statusCode

fun <T> TestResponseTriple<T>.body(): String = this.second.body().asString("text/plain; charset=utf-8")
