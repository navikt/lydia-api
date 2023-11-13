package no.nav.lydia.vedlikehold

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.Clock.System.now
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toLocalDateTime
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import javax.sql.DataSource
import kotlin.coroutines.CoroutineContext
import kotlin.system.measureTimeMillis

fun oppdaterStatistikkView(dataSource: DataSource, logger: Logger) {
    logger.info("Oppdaterer statistikkview...")
    val tidBrukt = measureTimeMillis {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    "REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering"
                ).asExecute
            )
        }
    }
    logger.info("Oppdaterte statistikkview på $tidBrukt ms")
}

object StatistikkViewOppdaterer: CoroutineScope {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)
    lateinit var job: Job
    lateinit var dataSource: DataSource

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.IO + job

    init {
        Runtime.getRuntime().addShutdownHook(Thread(StatistikkViewOppdaterer::cancel))
    }

    fun run(dataSource: DataSource) {
        logger.info("Starter statistikkview oppdaterer")

        job = Job()
        StatistikkViewOppdaterer.dataSource = dataSource

        launch {
            while (job.isActive) {
                if (now().toLocalDateTime(TimeZone.UTC).hour == 0) {
                    oppdaterStatistikkView(dataSource, logger)
                } else
                    logger.debug("Statistikkview oppdateres kun mellom kl 00:00 og 00:59")

                delay(1000 * 60 * 30) // 30 minutter
            }
        }
    }

    fun cancel()  = runBlocking {
        logger.info("Avslutter statistikkview oppdaterer")
        job.cancelAndJoin()
    }
}