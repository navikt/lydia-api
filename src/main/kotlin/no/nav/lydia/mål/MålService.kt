package no.nav.lydia.mål

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import no.nav.lydia.felles.Feil
import no.nav.lydia.mål.MålTransactional.Companion.hentMål
import no.nav.lydia.mål.MålTransactional.Companion.hentSamarbeidsmål
import no.nav.lydia.mål.MålTransactional.Companion.lagreSamarbeidsmål
import no.nav.lydia.mål.MålTransactional.Companion.lagreSykefraværsmål
import no.nav.lydia.tilstandsmaskin.Transaction
import org.slf4j.LoggerFactory
import javax.sql.DataSource

class MålService(
    private val dataSource: DataSource,
) {
    private val log = LoggerFactory.getLogger(this::class.java)

    fun hent(samarbeidId: Int): Either<Feil, MålDto> =
        Either.catch {
            Transaction(dataSource).transactional { hentMål(samarbeidId) }
        }.mapLeft {
            log.error("Feil ved henting av mål for samarbeid $samarbeidId", it)
            MålFeil.`feil ved henting av mål`
        }

    fun lagre(
        samarbeidId: Int,
        mål: MålDto,
        endretAv: String,
    ): Either<Feil, MålDto> =
        Either.catch {
            Transaction(dataSource).transactional {
                val eksisterendeIder = hentSamarbeidsmål(samarbeidId).mapNotNull { it.id }.toSet()
                val harUkjenteIder = mål.samarbeidsmål.mapNotNull { it.id }.any { it !in eksisterendeIder }
                if (harUkjenteIder) {
                    MålFeil.`ugyldig id på samarbeidsmål`.left()
                } else {
                    lagreSykefraværsmål(samarbeidId, mål.sykefraværsmål, endretAv)
                    lagreSamarbeidsmål(samarbeidId, mål.samarbeidsmål, endretAv)
                    hentMål(samarbeidId).right()
                }
            }
        }.mapLeft {
            log.error("Feil ved lagring av mål for samarbeid $samarbeidId", it)
            MålFeil.`feil ved lagring av mål`
        }.flatMap { it }
}
