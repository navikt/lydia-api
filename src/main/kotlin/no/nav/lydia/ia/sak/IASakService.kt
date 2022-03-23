package no.nav.lydia.ia.sak

import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.*
import java.time.LocalDateTime

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository
) {


    fun opprettSak(orgnummer: String, navIdent: String): IASak {
        val id = ULID.random()
        val sakshendelse = IASakshendelse(
            id = id,
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = id,
            type = SaksHendelsestype.VIRKSOMHET_PRIORITERES,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )

        iaSakshendelseRepository.opprettHendelse(sakshendelse)

        val sak = IASak(
            saksnummer = sakshendelse.saksnummer,
            orgnr = sakshendelse.orgnummer,
            type = IASakstype.NAV_STOTTER,
            opprettet = sakshendelse.opprettetTidspunkt,
            opprettetAv = sakshendelse.opprettetAv,
            endret = null,
            endretAv = null,
            endretAvHendelseId = sakshendelse.id,
            status = IAProsessStatus.PRIORITERT
        )


        return iaSakRepository.lagreSak(sak)
    }

    fun behandleHendelse(hendelseDto: IASakshendelseDto, navIdent: String): IASak {
        val sakshendelse = IASakshendelse.fromDto(hendelseDto, navIdent)
        val hendelser = iaSakshendelseRepository.hentHendelser(sakshendelse.saksnummer)

        // TODO: feilhåndter

        val sak = IASak.fraHendelser(hendelser)

        sak.behandleHendelse(sakshendelse)

        iaSakshendelseRepository.opprettHendelse(sakshendelse)
        return iaSakRepository.oppdaterSak(sak)
    }
}