package no.nav.lydia

import org.slf4j.Logger
import org.slf4j.MarkerFactory

private val teamLogsMarker = MarkerFactory.getMarker("TEAM_LOGS")

fun Logger.tldebug(msg: String) = debug(teamLogsMarker, msg)

fun Logger.tlinfo(msg: String) = info(teamLogsMarker, msg)

fun Logger.tlwarn(msg: String) = warn(teamLogsMarker, msg)
fun Logger.tlwarn(msg: String, t: Throwable) = warn(teamLogsMarker, msg, t)

fun Logger.tlerror(msg: String) = error(teamLogsMarker, msg)
fun Logger.tlerror(msg: String, t: Throwable) = error(teamLogsMarker, msg, t)
