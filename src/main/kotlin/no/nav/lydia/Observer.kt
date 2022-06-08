package no.nav.lydia

interface Observer<T> {
    fun receive(input: T)
}