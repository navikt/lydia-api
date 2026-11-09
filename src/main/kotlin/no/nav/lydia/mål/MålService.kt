package no.nav.lydia.mål

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import kotliquery.TransactionalSession
import no.nav.lydia.felles.Feil
import no.nav.lydia.mål.MålTransactional.Companion.hentMål
import no.nav.lydia.mål.MålTransactional.Companion.hentSamarbeidsmål
import no.nav.lydia.mål.MålTransactional.Companion.hentSykefraværsmål
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
                valider(samarbeidId, mål)?.left() ?: run {
                    lagreSykefraværsmål(samarbeidId, mål.sykefraværsmål, endretAv)
                    lagreSamarbeidsmål(samarbeidId, mål.samarbeidsmål, endretAv)
                    hentMål(samarbeidId).right()
                }
            }
        }.mapLeft {
            log.error("Feil ved lagring av mål for samarbeid $samarbeidId", it)
            MålFeil.`feil ved lagring av mål`
        }.flatMap { it }

    context(tx: TransactionalSession)
    private fun valider(
        samarbeidId: Int,
        mål: MålDto,
    ): Feil? {
        val lagredeTyper = hentSykefraværsmål(samarbeidId).associate { it.id to it.type }
        val sykefraværsmålMedId = mål.sykefraværsmål.filter { it.id != null }
        val lagredeSamarbeidsmålider = hentSamarbeidsmål(samarbeidId).mapNotNull { it.id }.toSet()
        return when {
            sykefraværsmålMedId.any { it.id !in lagredeTyper } -> MålFeil.`ugyldig id på sykefraværsmål`
            sykefraværsmålMedId.any { lagredeTyper[it.id] != it.type } -> MålFeil.`endret type på sykefraværsmål`
            mål.samarbeidsmål.any { it.id != null && it.id !in lagredeSamarbeidsmålider } -> MålFeil.`ugyldig id på samarbeidsmål`
            else -> null
        }
    }
}
