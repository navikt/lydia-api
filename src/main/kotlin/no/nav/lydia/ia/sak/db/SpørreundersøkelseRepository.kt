package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
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
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvar
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
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.UndertemaInfo
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
                ).map(this::mapRowToSpørreundersøkelse).asSingle,
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

                temaer.sortedBy { it.rekkefølge }.forEach { tema ->
                    tema.undertemaer.sortedBy { it.rekkefølge }.forEach { undertema ->
                        tx.run(
                            queryOf(
                                """
                        INSERT INTO ia_sak_kartlegging_kartlegging_til_undertema (
                            kartlegging_id,
                            tema_id, 
                            undertema_id
                        )
                        VALUES (
                            :kartlegging_id,
                            :tema_id, 
                            :undertema_id
                        )
                                """.trimMargin(),
                                mapOf(
                                    "kartlegging_id" to spørreundersøkelseId,
                                    "tema_id" to tema.id,
                                    "undertema_id" to undertema.id,
                                ),
                            ).asUpdate,
                        )
                    }
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

    private fun mapRowToSpørreundersøkelse(row: Row): Spørreundersøkelse = row.tilSpørreundersøkelse()

    private fun Row.tilSpørreundersøkelse(): Spørreundersøkelse {
        val spørreundersøkelseId = UUID.fromString(this.string("kartlegging_id"))
        return Spørreundersøkelse(
            id = spørreundersøkelseId,
            saksnummer = this.string("saksnummer"),
            samarbeidId = this.int("prosessId"),
            orgnummer = this.string("orgnr"),
            virksomhetsNavn = this.string("navn"),
            status = SpørreundersøkelseStatus.valueOf(this.string("status")),
            temaer = hentTemaer(spørreundersøkelseId),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet").toKotlinLocalDateTime(),
            type = this.string("type"),
            endretTidspunkt = this.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
            påbegyntTidspunkt = this.localDateTimeOrNull("pabegynt")?.toKotlinLocalDateTime(),
            fullførtTidspunkt = this.localDateTimeOrNull("fullfort")?.toKotlinLocalDateTime(),
        )
    }

    private fun hentTemaer(spørreundersøkelseId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                        ia_sak_kartlegging_kartlegging_til_tema.kartlegging_id as kartlegging_id,
                        ia_sak_kartlegging_kartlegging_til_tema.stengt as stengt,
                        ia_sak_kartlegging_kartlegging_til_tema.tema_id as tema_id,
                        ia_sak_kartlegging_tema.rekkefolge as rekkefolge,
                        ia_sak_kartlegging_tema.navn as navn,
                        ia_sak_kartlegging_tema.status as status,
                        ia_sak_kartlegging_tema.sist_endret as sist_endret,                      
                        ia_sak_kartlegging_undertema.navn as undertemanavn,
                        ia_sak_kartlegging_sporsmal.sporsmal_id as sporsmal_id,
                        ia_sak_kartlegging_sporsmal.sporsmal_tekst as sporsmal_tekst,
                        ia_sak_kartlegging_sporsmal.flervalg as flervalg,
                        ia_sak_kartlegging_svaralternativer.svaralternativ_id as svaralternativ_id,
                        ia_sak_kartlegging_svaralternativer.svaralternativ_tekst as svaralternativ_tekst
                      FROM ia_sak_kartlegging_sporsmal
                      JOIN ia_sak_kartlegging_sporsmal_til_undertema USING (sporsmal_id) 
                      JOIN ia_sak_kartlegging_svaralternativer USING (sporsmal_id)
                      JOIN ia_sak_kartlegging_undertema USING (undertema_id)
                      JOIN ia_sak_kartlegging_tema USING (tema_id)
                      JOIN ia_sak_kartlegging_kartlegging_til_tema USING (tema_id)
                      JOIN ia_sak_kartlegging_kartlegging_til_undertema USING (undertema_id) 
                    WHERE ia_sak_kartlegging_kartlegging_til_tema.kartlegging_id = :kartlegging_id
                    AND ia_sak_kartlegging_kartlegging_til_undertema.kartlegging_id = :kartlegging_id
                    ORDER BY ia_sak_kartlegging_tema.rekkefolge,
                      ia_sak_kartlegging_undertema.rekkefolge,
                      ia_sak_kartlegging_sporsmal.sporsmal_id, 
                      ia_sak_kartlegging_svaralternativer.svaralternativ_id
                    """.trimIndent(),
                    mapOf(
                        "kartlegging_id" to spørreundersøkelseId.toString(),
                    ),
                ).map {
                    SpørsmålsRad(
                        spørreundersøkelseId = UUID.fromString(it.string("kartlegging_id")),
                        tema = mapTilTema(it),
                        erTemaStengt = it.boolean("stengt"),
                        undertemanavn = it.string("undertemanavn"),
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
        val undertemanavn: String,
        val spørsmålId: UUID,
        val spørsmåltekst: String,
        val flervalg: Boolean,
        val svaralternativ: Svaralternativ,
    )

    private fun List<SpørsmålsRad>.tilTemaMedSpørsmålOgSvaralternativer() =
        this.groupBy {
            it.tema
        }.map { tema ->
            val temaInfo = tema.key
            val erTemaStengt = tema.value.any { spørsmålsRad -> spørsmålsRad.erTemaStengt }
            val spørsmål = tema.value.groupBy { spørsmålsRad -> spørsmålsRad.spørsmålId }
                .map { spørsmål ->
                    val spørsmålId = spørsmål.key
                    val spørsmåltekst = spørsmål.value.first().spørsmåltekst
                    val flervalg = spørsmål.value.first().flervalg
                    val svaralternativer = spørsmål.value.map { it.svaralternativ }
                    val undertemanavn = spørsmål.value.first().undertemanavn
                    Spørsmål(
                        spørsmålId = spørsmålId,
                        undertemanavn = undertemanavn,
                        spørsmåltekst = spørsmåltekst,
                        flervalg = flervalg,
                        svaralternativer = svaralternativer,
                    )
                }
            Tema(
                tema = temaInfo,
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

    private fun mapRowToSpørreundersøkelseSvarDto(row: Row): SpørreundersøkelseSvar = row.tilSpørreundersøkelseSvar()

    private val svarIderType = object : TypeToken<List<String>>() {}.type

    private fun Row.tilSpørreundersøkelseSvar(): SpørreundersøkelseSvar =
        SpørreundersøkelseSvar(
            spørreundersøkelseId = this.string("kartlegging_id"),
            sesjonId = this.string("sesjon_id"),
            spørsmålId = this.string("sporsmal_id"),
            svarIder = gson.fromJson(this.string("svar_ider"), svarIderType),
            opprettet = this.localDateTime("opprettet").toKotlinLocalDateTime(),
            endret = this.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
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

    fun startSpørreundersøkelse(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${PÅBEGYNT.name}',
                        endret = :navaerendeTidspunkt,
                        pabegynt = :navaerendeTidspunkt
                    WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                        "navaerendeTidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    fun avsluttSpørreundersøkelse(spørreundersøkelseId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${AVSLUTTET.name}',
                        endret = :navaerendeTidspunkt,
                        fullfort = :navaerendeTidspunkt
                        WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                        "navaerendeTidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    private fun mapTilTema(row: Row): TemaInfo {
        val temaId = row.int("tema_id")
        return TemaInfo(
            id = temaId,
            rekkefølge = row.int("rekkefolge"),
            navn = row.string("navn"),
            status = TemaStatus.valueOf(row.string("status")),
            sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
            undertemaer = hentAktiveUndertemaer(temaId = temaId),
        )
    }

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

    private fun hentAktiveUndertemaer(temaId: Int): List<UndertemaInfo> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_undertema
                    WHERE status = '${TemaStatus.AKTIV}'
                    AND tema_id = '$temaId'
                    """.trimIndent(),
                ).map(this::mapTilUndertema).asList,
            )
        }

    private fun mapTilUndertema(row: Row) =
        UndertemaInfo(
            id = row.int("undertema_id"),
            navn = row.string("navn"),
            rekkefølge = row.int("rekkefolge"),
            status = TemaStatus.valueOf(row.string("status")),
        )

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
                ).map(this::mapRowToSpørreundersøkelse).asList,
            )
        }
}
