package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository.SpørreundersøkelseDatabaseRad
import java.util.UUID

data class SpørreundersøkelseDomene(
    val virksomhetsNavn: String,
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val id: UUID,
    val type: Type,
    val status: Status, // Bruke denne til å programmatisk skjule avsluttet?
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val gyldigTilTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val temaer: List<TemaDomene>,
    val publiseringStatus: DokumentPublisering.Status,
) {
    companion object {
        const val ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG = 24L
        const val MINIMUM_ANTALL_DELTAKERE = 3

        fun List<SpørreundersøkelseDatabaseRad>.tilSpørreundersøkelser(): List<SpørreundersøkelseDomene> =
            this.groupBy {
                it.spørreundersøkelseId
            }.mapNotNull { (_, spørreundersøkelseRad) ->
                spørreundersøkelseRad.tilSpørreundersøkelse()
            }

        fun List<SpørreundersøkelseDatabaseRad>.tilSpørreundersøkelse(): SpørreundersøkelseDomene? {
            if (this.isEmpty()) {
                return null
            }

            val spørreundersøkelse = first()
            return SpørreundersøkelseDomene(
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
                    TemaDomene(
                        id = tema.temaId,
                        navn = tema.temaNavn,
                        status = tema.temaStatus,
                        rekkefølge = tema.temaRekkefølge,
                        stengtForSvar = tema.temaStengt,
                        sistEndret = tema.temaEndret.toKotlinLocalDateTime(),
                        undertemaer = temaRader.groupBy { it.undertemaId }.map { (_, undertemaRader) ->
                            val undertema = undertemaRader.first()
                            UndertemaDomene(
                                id = undertema.undertemaId,
                                navn = undertema.undertemaNavn,
                                status = undertema.undertemaStatus,
                                rekkefølge = undertema.undertemaRekkefølge,
                                spørsmål = undertemaRader.groupBy { it.spørsmålId }.map { (_, spørsmålRader) ->
                                    val spørsmål = spørsmålRader.first()
                                    SpørsmålDomene(
                                        id = spørsmål.spørsmålId,
                                        tekst = spørsmål.spørsmålTekst,
                                        rekkefølge = spørsmål.spørsmålRekkefølge,
                                        flervalg = spørsmål.flervalg,
                                        antallSvar = spørsmål.antallSvarPerSpørsmål,
                                        svaralternativer = spørsmålRader.groupBy { it.svaralternativId }
                                            .map { (_, svaralternativRader) ->
                                                val svaralternativ = svaralternativRader.first()
                                                SvaralternativDomene(
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

    fun finnSpørsmål(spørsmålId: UUID): SpørsmålDomene? = temaer.flatMap { it.undertemaer }.flatMap { it.spørsmål }.firstOrNull { it.id == spørsmålId }
}

class TemaDomene(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val stengtForSvar: Boolean,
    val sistEndret: LocalDateTime,
    val undertemaer: List<UndertemaDomene>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}

class UndertemaDomene(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val spørsmål: List<SpørsmålDomene>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}

class SpørsmålDomene(
    val id: UUID,
    val tekst: String,
    val rekkefølge: Int,
    val flervalg: Boolean,
    val antallSvar: Int,
    val svaralternativer: List<SvaralternativDomene>,
) {
    fun svaralternativerHørerTilSpørsmål(svarIder: List<UUID>): Boolean = svaralternativer.map { it.id }.toList().containsAll(svarIder)
}

class SvaralternativDomene(
    val id: UUID,
    val tekst: String,
    val antallSvar: Int,
)
