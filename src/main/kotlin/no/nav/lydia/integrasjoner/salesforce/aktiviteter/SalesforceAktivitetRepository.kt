package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import javax.sql.DataSource

class SalesforceAktivitetRepository(
    val dataSource: DataSource,
) {
    fun oppdaterSlettetStatus(
        aktivitet: SalesforceAktivitet,
        slettet: Boolean,
    ) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE salesforce_aktiviteter
                        SET slettet = :slettet,
                        sist_endret = now()
                        WHERE id = :id
                    """.trimIndent(),
                    mapOf(
                        "slettet" to slettet,
                        "id" to aktivitet.id,
                    ),
                ).asUpdate,
            )
        }
    }

    fun lagreAktivitet(aktivitet: SalesforceAktivitet) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO salesforce_aktiviteter
                        (
                            id,
                            type,
                            saksnummer,
                            samarbeid,
                            plan_id,
                            tema,
                            undertema,
                            oppgave_planlagt,
                            oppgave_fullfort,
                            mote_start,
                            mote_slutt,
                            status,
                            sist_endret_salesforce
                        )
                        VALUES (
                            :id,
                            :type,
                            :saksnummer,
                            :samarbeid,
                            :planId,
                            :tema,
                            :undertema,
                            :oppgavePlanlagt,
                            :oppgaveFullfort,
                            :moteStart,
                            :moteSlutt,
                            :status,
                            :sistEndretISalesforce
                        )
                        ON CONFLICT (id) DO UPDATE SET
                            type = :type, 
                            saksnummer = :saksnummer, 
                            samarbeid = :samarbeid, 
                            plan_id = :planId, 
                            tema = :tema, 
                            undertema = :undertema, 
                            oppgave_planlagt = :oppgavePlanlagt,
                            oppgave_fullfort = :oppgaveFullfort, 
                            mote_start = :moteStart,
                            mote_slutt = :moteSlutt, 
                            status = :status, 
                            sist_endret_salesforce = :sistEndretISalesforce
                        WHERE (
                            salesforce_aktiviteter.sist_endret_salesforce IS NULL OR
                            salesforce_aktiviteter.sist_endret_salesforce <= :sistEndretISalesforce
                        )
                    """.trimIndent(),
                    mapOf(
                        "id" to aktivitet.id,
                        "sistEndretISalesforce" to aktivitet.sistEndretISalesforce,
                        "type" to aktivitet.type.name,
                        "saksnummer" to aktivitet.saksnummer,
                        "samarbeid" to aktivitet.samarbeidsId,
                        "planId" to aktivitet.planId,
                        "tema" to aktivitet.tema,
                        "undertema" to aktivitet.undertema,
                        "oppgavePlanlagt" to aktivitet.planlagt,
                        "oppgaveFullfort" to aktivitet.fullført,
                        "moteStart" to aktivitet.møteStart,
                        "moteSlutt" to aktivitet.møteSlutt,
                        "status" to aktivitet.status?.name,
                    ),
                ).asUpdate,
            )
        }
}
