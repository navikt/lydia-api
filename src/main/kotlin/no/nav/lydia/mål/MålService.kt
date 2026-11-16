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
        lagreOgHentMål(
            samarbeidId = samarbeidId,
            valider = {
                validerSykefraværsmålMotLagrede(samarbeidId, mål.sykefraværsmål)
                    ?: validerSamarbeidsmålMotLagrede(samarbeidId, mål.samarbeidsmål)
            },
            lagre = {
                MålTransactional.lagreSykefraværsmål(samarbeidId, mål.sykefraværsmål, endretAv)
                MålTransactional.lagreSamarbeidsmål(samarbeidId, mål.samarbeidsmål, endretAv)
            },
        )

    fun lagreSykefraværsmål(
        samarbeidId: Int,
        sykefraværsmål: List<SykefraværsmålDto>,
        endretAv: String,
    ): Either<Feil, MålDto> =
        lagreOgHentMål(
            samarbeidId = samarbeidId,
            valider = { validerSykefraværsmålMotLagrede(samarbeidId, sykefraværsmål) },
            lagre = { MålTransactional.lagreSykefraværsmål(samarbeidId, sykefraværsmål, endretAv) },
        )

    fun lagreSamarbeidsmål(
        samarbeidId: Int,
        samarbeidsmål: List<SamarbeidsmålDto>,
        endretAv: String,
    ): Either<Feil, MålDto> =
        lagreOgHentMål(
            samarbeidId = samarbeidId,
            valider = { validerSamarbeidsmålMotLagrede(samarbeidId, samarbeidsmål) },
            lagre = { MålTransactional.lagreSamarbeidsmål(samarbeidId, samarbeidsmål, endretAv) },
        )

    private fun lagreOgHentMål(
        samarbeidId: Int,
        valider: context(TransactionalSession) () -> Feil?,
        lagre: context(TransactionalSession) () -> Unit,
    ): Either<Feil, MålDto> =
        Either.catch {
            Transaction(dataSource).transactional {
                valider()?.left() ?: run {
                    lagre()
                    hentMål(samarbeidId).right()
                }
            }
        }.mapLeft {
            log.error("Feil ved lagring av mål for samarbeid $samarbeidId", it)
            MålFeil.`feil ved lagring av mål`
        }.flatMap { it }

    context(tx: TransactionalSession)
    private fun validerSykefraværsmålMotLagrede(
        samarbeidId: Int,
        sykefraværsmål: List<SykefraværsmålDto>,
    ): Feil? {
        val lagredeTyper = hentSykefraværsmål(samarbeidId).associate { it.id to it.type }
        val sykefraværsmålMedId = sykefraværsmål.filter { it.id != null }
        return when {
            sykefraværsmålMedId.any { it.id !in lagredeTyper } -> MålFeil.`ugyldig id på sykefraværsmål`
            sykefraværsmålMedId.any { lagredeTyper[it.id] != it.type } -> MålFeil.`endret type på sykefraværsmål`
            else -> null
        }
    }

    context(tx: TransactionalSession)
    private fun validerSamarbeidsmålMotLagrede(
        samarbeidId: Int,
        samarbeidsmål: List<SamarbeidsmålDto>,
    ): Feil? {
        val lagredeIder = hentSamarbeidsmål(samarbeidId).mapNotNull { it.id }.toSet()
        return if (samarbeidsmål.any { it.id != null && it.id !in lagredeIder }) {
            MålFeil.`ugyldig id på samarbeidsmål`
        } else {
            null
        }
    }
}
