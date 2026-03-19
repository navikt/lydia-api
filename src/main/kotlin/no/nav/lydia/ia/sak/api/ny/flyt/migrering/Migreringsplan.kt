package no.nav.lydia.ia.sak.api.ny.flyt.migrering

import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.AlleSamarbeidIVirksomhetErAvsluttet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.Tilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetErVurdert
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetHarAktiveSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetVurderes
import no.nav.lydia.ia.sak.domene.IASak

sealed class Migreringsplan {
    abstract fun kanGjennomføres(): Boolean

    data class Gjennomførbar(
        val nåværendeSakStatus: IASak.Status,
        val resulterendeSakStatus: IASak.Status,
        val tilstand: Tilstand,
        val gjørVirksomhetKlarTilVurderingSenere: Boolean = false,
    ) : Migreringsplan() {
        override fun kanGjennomføres(): Boolean = true
    }

    object IkkeGjennomførbar : Migreringsplan() {
        override fun kanGjennomføres(): Boolean = false
    }

    companion object {
        fun utledMigreringsplan(
            iaSakDto: IASakDto,
            samarbeidUseCase: SamarbeidUseCase,
            sakSakUseCase: SakUseCase,
        ): Migreringsplan =
            when (iaSakDto.status) {
                IASak.Status.VURDERES -> {
                    Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.VURDERES,
                        tilstand = VirksomhetVurderes,
                    )
                }

                IASak.Status.KONTAKTES -> {
                    Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.VURDERES,
                        tilstand = VirksomhetVurderes,
                    )
                }

                IASak.Status.KARTLEGGES -> {
                    when (samarbeidUseCase) {
                        SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.VURDERES,
                            tilstand = VirksomhetVurderes,
                        )

                        SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AKTIV,
                            tilstand = VirksomhetHarAktiveSamarbeid,
                        )

                        SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                        SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                        -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AVSLUTTET,
                            tilstand = AlleSamarbeidIVirksomhetErAvsluttet,
                            gjørVirksomhetKlarTilVurderingSenere = true,
                        )
                    }
                }

                IASak.Status.VI_BISTÅR -> {
                    when (samarbeidUseCase) {
                        SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.VURDERES,
                            tilstand = VirksomhetVurderes,
                        )

                        SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AKTIV,
                            tilstand = VirksomhetHarAktiveSamarbeid,
                        )

                        SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                        -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AVSLUTTET,
                            tilstand = VirksomhetKlarTilVurdering,
                        )

                        SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                        -> Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AVSLUTTET,
                            tilstand = AlleSamarbeidIVirksomhetErAvsluttet,
                            gjørVirksomhetKlarTilVurderingSenere = true,
                        )
                    }
                }

                IASak.Status.FULLFØRT -> {
                    when (sakSakUseCase) {
                        SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN,
                        -> {
                            Gjennomførbar(
                                nåværendeSakStatus = iaSakDto.status,
                                resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                tilstand = VirksomhetKlarTilVurdering,
                            )
                        }

                        SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN,
                        -> {
                            Gjennomførbar(
                                nåværendeSakStatus = iaSakDto.status,
                                resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                tilstand = AlleSamarbeidIVirksomhetErAvsluttet,
                                gjørVirksomhetKlarTilVurderingSenere = true,
                            )
                        }
                    }
                }

                IASak.Status.IKKE_AKTUELL -> {
                    when (sakSakUseCase) {
                        SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN,
                        -> {
                            when (samarbeidUseCase) {
                                SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET,
                                -> {
                                    Gjennomførbar(
                                        nåværendeSakStatus = iaSakDto.status,
                                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                        tilstand = VirksomhetErVurdert,
                                        gjørVirksomhetKlarTilVurderingSenere = true,
                                    )
                                }

                                SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                                SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                                -> {
                                    Gjennomførbar(
                                        nåværendeSakStatus = iaSakDto.status,
                                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                        tilstand = AlleSamarbeidIVirksomhetErAvsluttet,
                                        gjørVirksomhetKlarTilVurderingSenere = true,
                                    )
                                }

                                else -> {
                                    IkkeGjennomførbar
                                }
                            }
                        }

                        SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN,
                        -> {
                            when (samarbeidUseCase) {
                                SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET,
                                -> {
                                    Gjennomførbar(
                                        nåværendeSakStatus = iaSakDto.status,
                                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                        tilstand = VirksomhetKlarTilVurdering,
                                    )
                                }

                                SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                                SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                                -> {
                                    Gjennomførbar(
                                        nåværendeSakStatus = iaSakDto.status,
                                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                        tilstand = VirksomhetKlarTilVurdering,
                                    )
                                }

                                else -> {
                                    IkkeGjennomførbar
                                }
                            }
                        }
                    }
                }

                else -> {
                    IkkeGjennomførbar
                }
            }
    }
}

enum class SamarbeidUseCase {
    INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET,
    MINST_ETT_AKTIVT_SAMARBEID,
    INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
    INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
}

enum class SakUseCase {
    SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN,
    SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN,
}
