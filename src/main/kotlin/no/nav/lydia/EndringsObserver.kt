package no.nav.lydia

interface EndringsObserver<T, U> {
    fun recieve(
        før: T,
        endring: U,
        etter: T,
    )
}
