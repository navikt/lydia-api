package no.nav.lydia.tilstandsmaskin

import kotliquery.TransactionalSession
import kotliquery.sessionOf
import kotliquery.using
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
