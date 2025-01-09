package no.nav.lydia

interface EndringsObserver<T, U> {
    fun receive(
        før: T,
        endring: U,
        etter: T,
    )
}
