package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.SLETTET
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.OppdaterBehovsvurderingDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseAntallSvar
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaInfo
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaStatus
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class SpørreundersøkelseRepository(
    private val dataSource: DataSource,
) {
    private val gson: Gson = GsonBuilder().create()

    fun hentAlleSvar(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                    ),
                ).map(this::mapRowToSpørreundersøkelseSvarDto).asList,
            )
        }

    fun hentEnSpørreundersøkelseUtenInnhold(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak_kartlegging
                    WHERE kartlegging_id = :sporreundersokelseId
                    AND status != '$SLETTET'
                    """.trimMargin(),
                    mapOf(
                        "sporreundersokelseId" to spørreundersøkelseId,
                    ),
                ).map(this::mapRowToSpørreundersøkelseUtenInnhold).asSingle,
            )
        }

    fun hentSpørreundersøkelser(
        prosess: IAProsess,
        type: String = "Behovsvurdering",
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                    SELECT *
                    FROM ia_sak_kartlegging
                    WHERE ia_prosess = :prosessId
                    AND status != '$SLETTET'
                    AND type = '$type'
                """.trimMargin(),
                mapOf(
                    "prosessId" to prosess.id,
                ),
            ).map(this::mapRowToSpørreundersøkelseUtenInnhold).asList,
        )
    }

    fun hentSpørreundersøkelse(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT ia_sak_kartlegging.*,
                         ia_sak.saksnummer,
                         virksomhet.orgnr,
                         virksomhet.navn,
                         ia_prosess.id AS prosessId
                        FROM ia_sak_kartlegging
                        JOIN ia_prosess on (ia_sak_kartlegging.ia_prosess = ia_prosess.id)
                        JOIN ia_sak using (saksnummer, orgnr)
                        JOIN virksomhet using (orgnr)
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                    ),
                ).map(this::mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer).asSingle,
            )
        }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        spørreundersøkelseId: UUID,
        prosessId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        temaer: List<TemaInfo>,
        type: String,
    ): Either<Feil, Spørreundersøkelse> {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                            INSERT INTO ia_sak_kartlegging (
                                kartlegging_id,
                                orgnr,
                                ia_prosess,
                                status,
                                opprettet_av,
                                type
                            )
                            VALUES (
                                :kartlegging_id,
                                :orgnr,
                                :prosessId,
                                :status,
                                :opprettet_av,
                                :sporreundersokelseType
                            )
                        """.trimMargin(),
                        mapOf(
                            "kartlegging_id" to spørreundersøkelseId,
                            "orgnr" to orgnummer,
                            "prosessId" to prosessId,
                            "status" to "OPPRETTET",
                            "opprettet_av" to saksbehandler.navIdent,
                            "sporreundersokelseType" to type,
                        ),
                    ).asUpdate,
                )

                temaer.sortedBy { it.rekkefølge }.forEach { tema ->
                    tx.run(
                        queryOf(
                            """
                    INSERT INTO ia_sak_kartlegging_kartlegging_til_tema (
                        kartlegging_id,
                        tema_id
                    )
                    VALUES (
                        :kartlegging_id,
                        :tema_id
                    )
                            """.trimMargin(),
                            mapOf(
                                "kartlegging_id" to spørreundersøkelseId,
                                "tema_id" to tema.id,
                            ),
                        ).asUpdate,
                    )
                }
            }
        }

        return hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId.toString())?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette kartlegging",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
    }

    private fun mapRowToSpørreundersøkelseUtenInnhold(row: Row): SpørreundersøkelseUtenInnhold = row.tilSpørreundersøkelseUtenInnhold()

    private fun Row.tilSpørreundersøkelseUtenInnhold(): SpørreundersøkelseUtenInnhold {
        val spørreundersøkelseId = UUID.fromString(this.string("kartlegging_id"))
        return SpørreundersøkelseUtenInnhold(
            id = spørreundersøkelseId,
            samarbeidId = this.int("ia_prosess"),
            status = SpørreundersøkelseStatus.valueOf(this.string("status")),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet"),
            endretTidspunkt = this.localDateTimeOrNull("endret"),
        )
    }

    private fun mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer(row: Row): Spørreundersøkelse =
        row.tilIASakKartleggingMedSpørsmålOgSvaralternativer()

    private fun Row.tilIASakKartleggingMedSpørsmålOgSvaralternativer(): Spørreundersøkelse {
        val spørreundersøkelseId = UUID.fromString(this.string("kartlegging_id"))
        return Spørreundersøkelse(
            id = spørreundersøkelseId,
            saksnummer = this.string("saksnummer"),
            samarbeidId = this.int("prosessId"),
            orgnummer = this.string("orgnr"),
            virksomhetsNavn = this.string("navn"),
            status = SpørreundersøkelseStatus.valueOf(this.string("status")),
            tema = hentTema(spørreundersøkelseId),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet"),
            type = this.string("type"),
            endretTidspunkt = this.localDateTimeOrNull("endret"),
        )
    }

    fun hentTema(spørreundersøkelseId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak_kartlegging_sporsmal
                    JOIN ia_sak_kartlegging_tema_til_spørsmål USING (sporsmal_id)
                    JOIN ia_sak_kartlegging_svaralternativer USING (sporsmal_id)
                    JOIN ia_sak_kartlegging_tema USING (tema_id)
                    JOIN ia_sak_kartlegging_kartlegging_til_tema USING (tema_id)
                    WHERE kartlegging_id = :kartlegging_id
                    ORDER BY ia_sak_kartlegging_tema.rekkefolge
                    """.trimIndent(),
                    mapOf(
                        "kartlegging_id" to spørreundersøkelseId.toString(),
                    ),
                ).map {
                    SpørsmålsRad(
                        spørreundersøkelseId = UUID.fromString(it.string("kartlegging_id")),
                        tema = mapTilTema(it),
                        erTemaStengt = it.boolean("stengt"),
                        spørsmålId = UUID.fromString(it.string("sporsmal_id")),
                        spørsmåltekst = it.string("sporsmal_tekst"),
                        flervalg = it.boolean("flervalg"),
                        svaralternativ = mapTilSvaralternativ(it),
                    )
                }.asList,
            ).tilTemaMedSpørsmålOgSvaralternativer()
        }

    private data class SpørsmålsRad(
        val spørreundersøkelseId: UUID,
        val tema: TemaInfo,
        val erTemaStengt: Boolean,
        val spørsmålId: UUID,
        val spørsmåltekst: String,
        val flervalg: Boolean,
        val svaralternativ: Svaralternativ,
    )

    private fun List<SpørsmålsRad>.tilTemaMedSpørsmålOgSvaralternativer() =
        this.groupBy {
            it.tema
        }.map {
            val tema = it.key
            val erTemaStengt = it.value.any { spørsmålsRad -> spørsmålsRad.erTemaStengt }
            val spørsmål = it.value.groupBy { spørsmålsRad ->
                spørsmålsRad.spørsmålId
            }.map {
                val spørsmålId = it.key
                val spørsmåltekst = it.value.first().spørsmåltekst
                val flervalg = it.value.first().flervalg
                val svaralternativer = it.value.map {
                    it.svaralternativ
                }
                Spørsmål(
                    spørsmålId = spørsmålId,
                    spørsmåltekst = spørsmåltekst,
                    flervalg = flervalg,
                    svaralternativer = svaralternativer,
                )
            }
            Tema(
                tema = tema,
                stengtForSvar = erTemaStengt,
                spørsmål = spørsmål,
            )
        }

    private fun mapTilSvaralternativ(row: Row) =
        Svaralternativ(
            svarId = UUID.fromString(row.string("svaralternativ_id")),
            svartekst = row.string("svaralternativ_tekst"),
        )

    fun hentAntallSvar(
        spørreundersøkelseId: UUID,
        spørsmålId: UUID,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                        SELECT COUNT(*) AS antallSvar
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                        AND sporsmal_id = :sporsmalId
                """.trimMargin(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                    "sporsmalId" to spørsmålId.toString(),
                ),
            ).map { rad ->
                SpørreundersøkelseAntallSvar(
                    spørreundersøkelseId = spørreundersøkelseId,
                    spørsmålId = spørsmålId,
                    antallSvar = rad.int("antallSvar"),
                )
            }.asSingle,
        )
    } ?: SpørreundersøkelseAntallSvar(
        spørreundersøkelseId = spørreundersøkelseId,
        spørsmålId = spørsmålId,
        antallSvar = 0,
    )

    private fun mapRowToSpørreundersøkelseSvarDto(row: Row): SpørreundersøkelseSvarDto = row.tilSpørreundersøkelseSvarDto()

    private val svarIderType = object : TypeToken<List<String>>() {}.type

    private fun Row.tilSpørreundersøkelseSvarDto(): SpørreundersøkelseSvarDto =
        SpørreundersøkelseSvarDto(
            spørreundersøkelseId = this.string("kartlegging_id"),
            sesjonId = this.string("sesjon_id"),
            spørsmålId = this.string("sporsmal_id"),
            svarIder = gson.fromJson(this.string("svar_ider"), svarIderType),
        )

    fun lagreSvar(karleggingSvarDto: SpørreundersøkelseSvarDto) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_sak_kartlegging_svar (
                            kartlegging_id,
                            sesjon_id,
                            sporsmal_id,
                            svar_ider
                        )
                        VALUES (
                            :kartleggingId,
                            :sesjonId,
                            :sporsmalId,
                            :svar_ider::jsonb
                        )
                        ON CONFLICT ON CONSTRAINT ia_sak_kartlegging_svar_kartlegging_sesjon_spm DO UPDATE SET
                            svar_ider = :svar_ider::jsonb,
                            endret = now()
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to karleggingSvarDto.spørreundersøkelseId,
                        "sesjonId" to karleggingSvarDto.sesjonId,
                        "sporsmalId" to karleggingSvarDto.spørsmålId,
                        "svar_ider" to gson.toJson(karleggingSvarDto.svarIder),
                    ),
                ).asUpdate,
            )
        }

    fun slettSpørreundersøkelse(
        spørreundersøkelseId: String,
        sistEndret: LocalDateTime = LocalDateTime.now(),
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                UPDATE ia_sak_kartlegging SET
                    status = '$SLETTET',
                    endret = :sistEndret
                WHERE kartlegging_id = :kartleggingId
                """.trimIndent(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId,
                    "sistEndret" to sistEndret,
                ),
            ).asUpdate,
        )
        hentSpørreundersøkelse(spørreundersøkelseId)
    }

    fun endreSpørreundersøkelseStatus(
        spørreundersøkelseId: String,
        status: SpørreundersøkelseStatus,
        sistEndret: LocalDateTime = LocalDateTime.now(),
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                UPDATE ia_sak_kartlegging SET
                    status = '${status.name}',
                    endret = :sistEndret
                WHERE kartlegging_id = :kartleggingId
                """.trimIndent(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId,
                    "sistEndret" to sistEndret,
                ),
            ).asUpdate,
        )
        hentSpørreundersøkelse(spørreundersøkelseId)
    }

    private fun mapTilTema(row: Row) =
        TemaInfo(
            id = row.int("tema_id"),
            rekkefølge = row.int("rekkefolge"),
            navn = row.string("navn"),
            status = TemaStatus.valueOf(row.string("status")),
            sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
        )

    fun stengTema(
        spørreundersøkelseId: String,
        temaId: Int,
    ) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging_kartlegging_til_tema
                      SET stengt = true 
                      WHERE kartlegging_id = :kartleggingId
                      AND tema_id = :temaId 
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                        "temaId" to temaId,
                    ),
                ).asUpdate,
            )
        }
    }

    fun hentAktiveTemaer(type: String): List<TemaInfo> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_tema
                    WHERE status = '${TemaStatus.AKTIV}'
                    AND type = '$type'
                    """.trimIndent(),
                ).map(this::mapTilTema).asList,
            )
        }

    fun oppdaterBehovsvurdering(
        behovsvurderingId: String,
        oppdaterBehovsvurderingDto: OppdaterBehovsvurderingDto,
    ): Either<Feil, Spørreundersøkelse> {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging
                    SET ia_prosess = :prosessId
                    WHERE kartlegging_id = :behovsvurderingId
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to oppdaterBehovsvurderingDto.prosessId,
                        "behovsvurderingId" to behovsvurderingId,
                    ),
                ).asUpdate,
            )
        }
        return hentSpørreundersøkelse(behovsvurderingId)?.right()
            ?: IASakSpørreundersøkelseError.`feil under oppdatering`.left()
    }

    fun hentAlleSpørreundersøkelser(): List<Spørreundersøkelse> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT ia_sak_kartlegging.*,
                         ia_sak.saksnummer,
                         virksomhet.orgnr,
                         virksomhet.navn,
                         ia_prosess.id AS prosessId
                        FROM ia_sak_kartlegging
                        JOIN ia_prosess on (ia_sak_kartlegging.ia_prosess = ia_prosess.id)
                        JOIN ia_sak using (saksnummer, orgnr)
                        JOIN virksomhet using (orgnr)
                    """.trimMargin(),
                ).map(this::mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer).asList,
            )
        }
}
