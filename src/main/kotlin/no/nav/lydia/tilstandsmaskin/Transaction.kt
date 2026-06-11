package no.nav.lydia.tilstandsmaskin

import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.felles.tilUUID
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.mapTilSalesforceAktivitet
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.kartlegging.Spørsmål
import no.nav.lydia.kartlegging.Svaralternativ
import no.nav.lydia.kartlegging.Tema
import no.nav.lydia.kartlegging.Undertema
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsplan.EndreTemaRequest
import no.nav.lydia.samarbeidsplan.EndreUndertemaRequest
import no.nav.lydia.samarbeidsplan.Plan
import no.nav.lydia.samarbeidsplan.PlanDto
import no.nav.lydia.samarbeidsplan.PlanMalDto
import no.nav.lydia.samarbeidsplan.PlanTema
import no.nav.lydia.samarbeidsplan.PlanTemaDto
import no.nav.lydia.samarbeidsplan.PlanUndertema
import no.nav.lydia.samarbeidsplan.PlanUndertemaDto
import no.nav.lydia.samarbeidsplan.hentInnholdsMålsetning
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class Transaction(
    val dataSource: DataSource,
) {
    fun <T> transactional(block: (TransactionalSession) -> T): T =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                block(tx)
            }
        }
}

fun IASakDto.nyHendelseBasertPåSak(
    hendelsestype: IASakshendelseType,
    superbruker: Superbruker,
    navEnhet: NavEnhet,
) = IASakshendelse(
    id = ULID.random(),
    opprettetTidspunkt = LocalDateTime.now(),
    saksnummer = this.saksnummer,
    hendelsesType = hendelsestype,
    orgnummer = this.orgnr,
    opprettetAv = superbruker.navIdent,
    opprettetAvRolle = superbruker.rolle,
    navEnhet = navEnhet,
    resulterendeStatus = null,
)

context(tx: TransactionalSession)
fun opprettKartlegging(
    kartleggingId: UUID,
    orgnummer: String,
    prosessId: Int,
    opprettetAv: String,
    type: Spørreundersøkelse.Type,
) {
    val opprettet = LocalDateTime.now()
    tx.run(
        queryOf(
            """
            INSERT INTO ia_sak_kartlegging (
                kartlegging_id, orgnr, ia_prosess, status, opprettet_av, type, opprettet, gyldig_til
            )
            VALUES (
                :kartlegging_id, :orgnr, :prosessId, :status, :opprettet_av, :sporreundersokelseType, :opprettet, :gyldigTil
            )
            """.trimIndent(),
            mapOf(
                "kartlegging_id" to kartleggingId,
                "orgnr" to orgnummer,
                "prosessId" to prosessId,
                "status" to "OPPRETTET",
                "opprettet_av" to opprettetAv,
                "sporreundersokelseType" to type.name,
                "opprettet" to opprettet,
                "gyldigTil" to opprettet.plusHours(Spørreundersøkelse.ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG),
            ),
        ).asUpdate,
    )
}

context(tx: TransactionalSession)
fun leggTilTemaTilKartlegging(
    kartleggingId: UUID,
    temaId: Int,
) {
    tx.run(
        queryOf(
            """
            INSERT INTO ia_sak_kartlegging_kartlegging_til_tema (kartlegging_id, tema_id)
            VALUES (:kartlegging_id, :tema_id)
            """.trimIndent(),
            mapOf(
                "kartlegging_id" to kartleggingId,
                "tema_id" to temaId,
            ),
        ).asUpdate,
    )
}

context(tx: TransactionalSession)
fun leggTilUndertemaTilKartlegging(
    kartleggingId: UUID,
    temaId: Int,
    undertemaId: Int,
) {
    tx.run(
        queryOf(
            """
            INSERT INTO ia_sak_kartlegging_kartlegging_til_undertema (kartlegging_id, tema_id, undertema_id)
            VALUES (:kartlegging_id, :tema_id, :undertema_id)
            """.trimIndent(),
            mapOf(
                "kartlegging_id" to kartleggingId,
                "tema_id" to temaId,
                "undertema_id" to undertemaId,
            ),
        ).asUpdate,
    )
}

context(tx: TransactionalSession)
fun startSpørreundersøkelse(spørreundersøkelseId: UUID): Spørreundersøkelse? {
    val nåværendeTidspunkt = LocalDateTime.now()
    tx.run(
        queryOf(
            """
            UPDATE ia_sak_kartlegging SET
                status = '${Spørreundersøkelse.Status.PÅBEGYNT.name}',
                endret = :navaerendeTidspunkt,
                pabegynt = :navaerendeTidspunkt
            WHERE kartlegging_id = :kartleggingId
            """.trimIndent(),
            mapOf(
                "kartleggingId" to spørreundersøkelseId.toString(),
                "navaerendeTidspunkt" to nåværendeTidspunkt,
            ),
        ).asUpdate,
    )
    return hentSpørreundersøkelse(spørreundersøkelseId)
}

context(tx: TransactionalSession)
fun oppdaterStatusTilSpørreundersøkelse(
    spørreundersøkelseId: UUID,
    status: Spørreundersøkelse.Status,
): Spørreundersøkelse? {
    val nåværendeTidspunkt = LocalDateTime.now()
    val fullførtEllerPåbegyntDato = when (status) {
        Spørreundersøkelse.Status.AVSLUTTET -> "fullfort = :navaerendeTidspunkt,"
        Spørreundersøkelse.Status.PÅBEGYNT -> "pabegynt = :navaerendeTidspunkt,"
        Spørreundersøkelse.Status.OPPRETTET, Spørreundersøkelse.Status.SLETTET -> ""
    }

    tx.run(
        queryOf(
            """
            UPDATE ia_sak_kartlegging SET
                status = :status,
                $fullførtEllerPåbegyntDato
                endret = :navaerendeTidspunkt
            WHERE kartlegging_id = :kartleggingId
            """.trimIndent(),
            mapOf(
                "status" to status.name,
                "kartleggingId" to spørreundersøkelseId.toString(),
                "navaerendeTidspunkt" to nåværendeTidspunkt,
            ),
        ).asUpdate,
    )
    return hentSpørreundersøkelse(spørreundersøkelseId)
}

context(tx: TransactionalSession)
fun hentSpørreundersøkelse(kartleggingId: UUID): Spørreundersøkelse? =
    tx.run(
        queryOf(
            """
            SELECT sporreundersokelse.kartlegging_id AS id,
                   sporreundersokelse.type,
                   sporreundersokelse.status,
                   sporreundersokelse.opprettet_av,
                   sporreundersokelse.opprettet,
                   sporreundersokelse.gyldig_til,
                   sporreundersokelse.endret,
                   sporreundersokelse.pabegynt,
                   sporreundersokelse.fullfort,
                   virksomhet.navn,
                   virksomhet.orgnr,
                   sak.saksnummer,
                   samarbeid.id AS samarbeid_id
            FROM ia_sak_kartlegging sporreundersokelse
                     JOIN ia_prosess samarbeid ON sporreundersokelse.ia_prosess = samarbeid.id
                     JOIN ia_sak sak USING (saksnummer, orgnr)
                     JOIN virksomhet USING (orgnr)
            WHERE sporreundersokelse.kartlegging_id = :kartleggingId
            """.trimIndent(),
            mapOf(
                "kartleggingId" to kartleggingId.toString(),
            ),
        ).map { row -> tilSpørreundersøkelse(row, tx) }.asSingle,
    )

private fun tilSpørreundersøkelse(
    row: Row,
    tx: TransactionalSession,
): Spørreundersøkelse {
    val spørreundersøkelseId = row.string("id").tilUUID("spørreundersøkelseId")
    return Spørreundersøkelse(
        id = spørreundersøkelseId,
        saksnummer = row.string("saksnummer"),
        samarbeidId = row.int("samarbeid_id"),
        orgnummer = row.string("orgnr"),
        virksomhetsNavn = row.string("navn"),
        status = Spørreundersøkelse.Status.valueOf(row.string("status")),
        temaer = hentSpørreundersøkelseTemaer(spørreundersøkelseId, tx),
        opprettetAv = row.string("opprettet_av"),
        opprettetTidspunkt = row.localDateTime("opprettet").toKotlinLocalDateTime(),
        type = Spørreundersøkelse.Type.valueOf(row.string("type")),
        endretTidspunkt = row.localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
        påbegyntTidspunkt = row.localDateTimeOrNull("pabegynt")?.toKotlinLocalDateTime(),
        fullførtTidspunkt = row.localDateTimeOrNull("fullfort")?.toKotlinLocalDateTime(),
        gyldigTilTidspunkt = row.localDateTime("gyldig_til").toKotlinLocalDateTime(),
    )
}

private fun hentSpørreundersøkelseTemaer(
    spørreundersøkelseId: UUID,
    tx: TransactionalSession,
): List<Tema> =
    tx.run(
        queryOf(
            """
            SELECT sporreundersokelse_tema.tema_id AS id,
                   tema.navn,
                   tema.status,
                   tema.rekkefolge,
                   tema.sist_endret,
                   sporreundersokelse_tema.stengt
            FROM ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                     JOIN ia_sak_kartlegging_tema tema
                          ON tema.tema_id = sporreundersokelse_tema.tema_id
            WHERE sporreundersokelse_tema.kartlegging_id = :kartleggingId
            """.trimIndent(),
            mapOf(
                "kartleggingId" to spørreundersøkelseId.toString(),
            ),
        ).map { row -> tilSpørreundersøkelseTema(row, spørreundersøkelseId, tx) }.asList,
    )

private fun tilSpørreundersøkelseTema(
    row: Row,
    spørreundersøkelseId: UUID,
    tx: TransactionalSession,
): Tema {
    val temaId = row.int("id")
    return Tema(
        id = temaId,
        navn = row.string("navn"),
        status = Tema.Status.valueOf(row.string("status")),
        rekkefølge = row.int("rekkefolge"),
        sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
        stengtForSvar = row.boolean("stengt"),
        undertemaer = hentSpørreundersøkelseUndertemaer(spørreundersøkelseId, temaId, tx),
    )
}

private fun hentSpørreundersøkelseUndertemaer(
    spørreundersøkelseId: UUID,
    temaId: Int,
    tx: TransactionalSession,
): List<Undertema> =
    tx.run(
        queryOf(
            """
            SELECT undertema.undertema_id AS id,
                   undertema.navn,
                   undertema.status,
                   undertema.rekkefolge,
                   undertema.sist_endret
            FROM ia_sak_kartlegging_kartlegging_til_undertema ktu
                     JOIN ia_sak_kartlegging_undertema undertema
                          ON ktu.undertema_id = undertema.undertema_id
            WHERE ktu.kartlegging_id = :kartleggingId
              AND undertema.tema_id = :temaId
            """.trimIndent(),
            mapOf(
                "kartleggingId" to spørreundersøkelseId.toString(),
                "temaId" to temaId,
            ),
        ).map { row -> tilSpørreundersøkelseUndertema(row, spørreundersøkelseId, tx) }.asList,
    )

private fun tilSpørreundersøkelseUndertema(
    row: Row,
    spørreundersøkelseId: UUID,
    tx: TransactionalSession,
): Undertema {
    val undertemaId = row.int("id")
    return Undertema(
        id = undertemaId,
        navn = row.string("navn"),
        status = Undertema.Status.valueOf(row.string("status")),
        rekkefølge = row.int("rekkefolge"),
        sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
        spørsmål = hentSpørreundersøkelseSpørsmål(spørreundersøkelseId, undertemaId, tx),
    )
}

private fun hentSpørreundersøkelseSpørsmål(
    spørreundersøkelseId: UUID,
    undertemaId: Int,
    tx: TransactionalSession,
): List<Spørsmål> =
    tx.run(
        queryOf(
            """
            SELECT sporsmal.sporsmal_id                            AS id,
                   sporsmal.sporsmal_tekst                         AS tekst,
                   sporsmal_undertema.rekkefolge,
                   sporsmal.flervalg,
                   (SELECT COUNT(DISTINCT svar.sesjon_id)
                    FROM ia_sak_kartlegging_svar svar
                    WHERE svar.kartlegging_id = :kartleggingId
                      AND svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
            FROM ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                     JOIN ia_sak_kartlegging_sporsmal sporsmal
                          ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
            WHERE sporsmal_undertema.undertema_id = :undertemaId
            """.trimIndent(),
            mapOf(
                "kartleggingId" to spørreundersøkelseId.toString(),
                "undertemaId" to undertemaId,
            ),
        ).map { row -> tilSpørreundersøkelseSpørsmål(row, spørreundersøkelseId, tx) }.asList,
    )

private fun tilSpørreundersøkelseSpørsmål(
    row: Row,
    spørreundersøkelseId: UUID,
    tx: TransactionalSession,
): Spørsmål {
    val spørsmålId = row.string("id").tilUUID("spørsmålId")
    return Spørsmål(
        id = spørsmålId,
        tekst = row.string("tekst"),
        rekkefølge = row.int("rekkefolge"),
        flervalg = row.boolean("flervalg"),
        antallSvar = row.int("antall_svar_per_sporsmal"),
        svaralternativer = hentSpørreundersøkelseSvaralternativer(spørreundersøkelseId, spørsmålId, tx),
    )
}

private fun hentSpørreundersøkelseSvaralternativer(
    spørreundersøkelseId: UUID,
    spørsmålId: UUID,
    tx: TransactionalSession,
): List<Svaralternativ> =
    tx.run(
        queryOf(
            """
            SELECT svaralternativ.svaralternativ_id,
                   svaralternativ.svaralternativ_tekst,
                   COALESCE(
                           (SELECT CASE
                                       WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                             FROM ia_sak_kartlegging_svar us
                                             WHERE us.kartlegging_id = :kartleggingId
                                               AND us.sporsmal_id = :sporsmalId) < ${Spørreundersøkelse.MINIMUM_ANTALL_DELTAKERE}
                                           THEN 0
                                       ELSE COUNT(DISTINCT svar.sesjon_id)
                                       END
                            FROM ia_sak_kartlegging_svar svar
                            WHERE svar.kartlegging_id = :kartleggingId
                              AND svar.sporsmal_id = :sporsmalId
                              AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       ) AS antall_svar
            FROM ia_sak_kartlegging_svaralternativer svaralternativ
            WHERE svaralternativ.sporsmal_id = :sporsmalId
            """.trimIndent(),
            mapOf(
                "kartleggingId" to spørreundersøkelseId.toString(),
                "sporsmalId" to spørsmålId.toString(),
            ),
        ).map { row ->
            Svaralternativ(
                id = row.string("svaralternativ_id").tilUUID("svaralternativId"),
                tekst = row.string("svaralternativ_tekst"),
                antallSvar = row.intOrNull("antall_svar") ?: 0,
            )
        }.asList,
    )
