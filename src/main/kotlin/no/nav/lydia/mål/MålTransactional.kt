package no.nav.lydia.mål

import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf

class MålTransactional {
    companion object {
        context(tx: TransactionalSession)
        fun hentMål(samarbeidId: Int): MålDto =
            MålDto(
                sykefraværsmål = hentSykefraværsmål(samarbeidId),
                samarbeidsmål = hentSamarbeidsmål(samarbeidId),
            )

        context(tx: TransactionalSession)
        fun lagreSykefraværsmål(
            samarbeidId: Int,
            sykefraværsmål: List<SykefraværsmålDto>,
            endretAv: String,
        ) {
            val typerSomBeholdes = sykefraværsmål.map { it.type }.toSet()
            hentSykefraværsmål(samarbeidId)
                .map { it.type }
                .filterNot { it in typerSomBeholdes }
                .forEach { type ->
                    tx.run(
                        queryOf(
                            """
                            DELETE FROM samarbeid_sykefravaersmaal
                            WHERE ia_prosess = :samarbeidId
                            AND type = :type::sykefravaersmaal_type
                            """.trimIndent(),
                            mapOf("samarbeidId" to samarbeidId, "type" to type.name),
                        ).asUpdate,
                    )
                }

            sykefraværsmål.forEach { mål ->
                tx.run(
                    queryOf(
                        """
                        INSERT INTO samarbeid_sykefravaersmaal (ia_prosess, type, naavaerende, maal, frist, endret_av)
                        VALUES (:samarbeidId, :type::sykefravaersmaal_type, :naavaerende, :maal, :frist, :endretAv)
                        ON CONFLICT (ia_prosess, type) DO UPDATE
                        SET naavaerende = excluded.naavaerende,
                            maal = excluded.maal,
                            frist = excluded.frist,
                            endret_av = excluded.endret_av,
                            sist_endret = current_timestamp
                        WHERE (samarbeid_sykefravaersmaal.naavaerende, samarbeid_sykefravaersmaal.maal, samarbeid_sykefravaersmaal.frist)
                            IS DISTINCT FROM (excluded.naavaerende, excluded.maal, excluded.frist)
                        """.trimIndent(),
                        mapOf(
                            "samarbeidId" to samarbeidId,
                            "type" to mål.type.name,
                            "naavaerende" to mål.nåværende.toBigDecimal(),
                            "maal" to mål.mål.toBigDecimal(),
                            "frist" to mål.frist.toJavaLocalDate(),
                            "endretAv" to endretAv,
                        ),
                    ).asUpdate,
                )
            }
        }

        context(tx: TransactionalSession)
        fun lagreSamarbeidsmål(
            samarbeidId: Int,
            samarbeidsmål: List<SamarbeidsmålDto>,
            endretAv: String,
        ) {
            val iderSomBeholdes = samarbeidsmål.mapNotNull { it.id }.toSet()
            hentSamarbeidsmål(samarbeidId)
                .mapNotNull { it.id }
                .filterNot { it in iderSomBeholdes }
                .forEach { id ->
                    tx.run(
                        queryOf(
                            "DELETE FROM samarbeid_maal WHERE ia_prosess = :samarbeidId AND id = :id",
                            mapOf("samarbeidId" to samarbeidId, "id" to id),
                        ).asUpdate,
                    )
                }

            samarbeidsmål.forEach { mål ->
                if (mål.id == null) {
                    tx.run(
                        queryOf(
                            """
                            INSERT INTO samarbeid_maal (ia_prosess, maal, lagret_med_ki_advarsel, endret_av)
                            VALUES (:samarbeidId, :maal, :lagretMedKiAdvarsel, :endretAv)
                            """.trimIndent(),
                            mapOf(
                                "samarbeidId" to samarbeidId,
                                "maal" to mål.mål,
                                "lagretMedKiAdvarsel" to mål.lagretMedKiAdvarsel,
                                "endretAv" to endretAv,
                            ),
                        ).asUpdate,
                    )
                } else {
                    tx.run(
                        queryOf(
                            """
                            UPDATE samarbeid_maal
                            SET maal = :maal,
                                lagret_med_ki_advarsel = :lagretMedKiAdvarsel,
                                endret_av = :endretAv,
                                sist_endret = current_timestamp
                            WHERE ia_prosess = :samarbeidId
                            AND id = :id
                            AND (maal, lagret_med_ki_advarsel) IS DISTINCT FROM (:maal::varchar, :lagretMedKiAdvarsel::boolean)
                            """.trimIndent(),
                            mapOf(
                                "samarbeidId" to samarbeidId,
                                "id" to mål.id,
                                "maal" to mål.mål,
                                "lagretMedKiAdvarsel" to mål.lagretMedKiAdvarsel,
                                "endretAv" to endretAv,
                            ),
                        ).asUpdate,
                    )
                }
            }
        }

        context(tx: TransactionalSession)
        fun hentSamarbeidsmål(samarbeidId: Int): List<SamarbeidsmålDto> =
            tx.run(
                queryOf(
                    """
                    SELECT id, maal, lagret_med_ki_advarsel
                    FROM samarbeid_maal
                    WHERE ia_prosess = :samarbeidId
                    ORDER BY id
                    """.trimIndent(),
                    mapOf("samarbeidId" to samarbeidId),
                ).map { it.tilSamarbeidsmål() }.asList,
            )

        context(tx: TransactionalSession)
        private fun hentSykefraværsmål(samarbeidId: Int): List<SykefraværsmålDto> =
            tx.run(
                queryOf(
                    """
                    SELECT type, naavaerende, maal, frist
                    FROM samarbeid_sykefravaersmaal
                    WHERE ia_prosess = :samarbeidId
                    ORDER BY type
                    """.trimIndent(),
                    mapOf("samarbeidId" to samarbeidId),
                ).map { it.tilSykefraværsmål() }.asList,
            )

        private fun Row.tilSykefraværsmål() =
            SykefraværsmålDto(
                type = Sykefraværsmåltype.valueOf(string("type")),
                nåværende = bigDecimal("naavaerende").toDouble(),
                mål = bigDecimal("maal").toDouble(),
                frist = localDate("frist").toKotlinLocalDate(),
            )

        private fun Row.tilSamarbeidsmål() =
            SamarbeidsmålDto(
                id = int("id"),
                mål = string("maal"),
                lagretMedKiAdvarsel = boolean("lagret_med_ki_advarsel"),
            )
    }
}
