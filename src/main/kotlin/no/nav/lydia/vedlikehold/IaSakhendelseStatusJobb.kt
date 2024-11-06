package no.nav.lydia.vedlikehold

import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import org.slf4j.LoggerFactory

class IaSakhendelseStatusJobb(
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
) {
    val log = LoggerFactory.getLogger(IaSakhendelseStatusJobb::class.java)

    fun kjør() {
        iaSakRepository.hentAlleSaker().forEach { sak ->
            try {
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(sak.saksnummer)
                List(hendelser.size) { index ->
                    IASak.fraHendelser(hendelser.subList(0, index + 1)) to hendelser[index]
                }.forEach { (historiskIaSak, hendelse) ->
                    log.info(
                        "Hendelse ${hendelse.hendelsesType} med id '${hendelse.id}' i sak '${historiskIaSak.saksnummer}' resulterer i status ${historiskIaSak.status}",
                    )
                    iaSakshendelseRepository.lagreResulterendeStatus(hendelse, historiskIaSak.status)
                }
            } catch (e: Exception) {
                log.warn("Feil i sakshistorikk for sak ${sak.saksnummer}", e)
            }
        }
    }
}
