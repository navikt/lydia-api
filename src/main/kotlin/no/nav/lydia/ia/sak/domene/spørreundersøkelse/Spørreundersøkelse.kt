package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository.SpørreundersøkelseDatabaseRad
import java.util.UUID

data class Spørreundersøkelse(
    val virksomhetsNavn: String,
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val id: UUID,
    val type: Type,
    val status: Status,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val gyldigTilTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val publiseringStatus: DokumentPublisering.Status,
    val temaer: List<Tema>,
) {
    companion object {
        const val ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG = 24L
        const val MINIMUM_ANTALL_DELTAKERE = 3

        fun List<SpørreundersøkelseDatabaseRad>.tilSpørreundersøkelser(): List<Spørreundersøkelse> =
            this.groupBy {
                it.spørreundersøkelseId
            }.mapNotNull { (_, spørreundersøkelseRad) ->
                spørreundersøkelseRad.tilSpørreundersøkelse()
            }

        fun List<SpørreundersøkelseDatabaseRad>.tilSpørreundersøkelse(): Spørreundersøkelse? {
            if (this.isEmpty()) {
                return null
            }

            val spørreundersøkelse = first()
            return Spørreundersøkelse(
                virksomhetsNavn = spørreundersøkelse.virksomhetsNavn,
                orgnummer = spørreundersøkelse.orgnummer,
                saksnummer = spørreundersøkelse.saksnummer,
                samarbeidId = spørreundersøkelse.samarbeidId,
                id = spørreundersøkelse.spørreundersøkelseId,
                type = spørreundersøkelse.type,
                status = spørreundersøkelse.status,
                opprettetAv = spørreundersøkelse.opprettetAv,
                opprettetTidspunkt = spørreundersøkelse.opprettet.toKotlinLocalDateTime(),
                gyldigTilTidspunkt = spørreundersøkelse.gyldigTil.toKotlinLocalDateTime(),
                endretTidspunkt = spørreundersøkelse.endret?.toKotlinLocalDateTime(),
                påbegyntTidspunkt = spørreundersøkelse.påbegynt?.toKotlinLocalDateTime(),
                fullførtTidspunkt = spørreundersøkelse.fullført?.toKotlinLocalDateTime(),
                publiseringStatus = spørreundersøkelse.publiseringStatus,
                temaer = groupBy { it.temaId }.map { (_, temaRader) ->
                    val tema = temaRader.first()
                    Tema(
                        id = tema.temaId,
                        navn = tema.temaNavn,
                        status = tema.temaStatus,
                        rekkefølge = tema.temaRekkefølge,
                        stengtForSvar = tema.temaStengt,
                        sistEndret = tema.temaEndret.toKotlinLocalDateTime(),
                        undertemaer = temaRader.groupBy { it.undertemaId }.map { (_, undertemaRader) ->
                            val undertema = undertemaRader.first()
                            Undertema(
                                id = undertema.undertemaId,
                                navn = undertema.undertemaNavn,
                                status = undertema.undertemaStatus,
                                rekkefølge = undertema.undertemaRekkefølge,
                                spørsmål = undertemaRader.groupBy { it.spørsmålId }.map { (_, spørsmålRader) ->
                                    val spørsmål = spørsmålRader.first()
                                    Spørsmål(
                                        id = spørsmål.spørsmålId,
                                        tekst = spørsmål.spørsmålTekst,
                                        rekkefølge = spørsmål.spørsmålRekkefølge,
                                        flervalg = spørsmål.flervalg,
                                        antallSvar = spørsmål.antallSvarPerSpørsmål,
                                        svaralternativer = spørsmålRader.groupBy { it.svaralternativId }
                                            .map { (_, svaralternativRader) ->
                                                val svaralternativ = svaralternativRader.first()
                                                Svaralternativ(
                                                    id = svaralternativ.svaralternativId,
                                                    tekst = svaralternativ.svaralternativTekst,
                                                    antallSvar = svaralternativ.antallSvar,
                                                )
                                            },
                                    )
                                },
                            )
                        },
                    )
                },
            )
        }
    }

    enum class Status {
        OPPRETTET,
        PÅBEGYNT,
        AVSLUTTET,
        SLETTET,
    }

    enum class Type {
        Evaluering,
        Behovsvurdering,
    }

    fun harMinstEttResultat(): Boolean =
        status == Status.AVSLUTTET && temaer.flatMap { it.undertemaer }.flatMap { it.spørsmål }.any { it.antallSvar >= MINIMUM_ANTALL_DELTAKERE }

    fun finnSpørsmål(spørsmålId: UUID): Spørsmål? = temaer.flatMap { it.undertemaer }.flatMap { it.spørsmål }.firstOrNull { it.id == spørsmålId }
}

class Tema(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val stengtForSvar: Boolean,
    val sistEndret: LocalDateTime,
    val undertemaer: List<Undertema>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}

class Undertema(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val spørsmål: List<Spørsmål>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}

class Spørsmål(
    val id: UUID,
    val tekst: String,
    val rekkefølge: Int,
    val flervalg: Boolean,
    val antallSvar: Int,
    val svaralternativer: List<Svaralternativ>,
) {
    fun svaralternativerHørerTilSpørsmål(svarIder: List<UUID>): Boolean = svaralternativer.map { it.id }.toList().containsAll(svarIder)
}

class Svaralternativ(
    val id: UUID,
    val tekst: String,
    val antallSvar: Int,
)
