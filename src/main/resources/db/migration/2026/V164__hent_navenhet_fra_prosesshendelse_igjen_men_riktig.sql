-- Behold kun koblinger basert på eksplisitt knytning til 'NY_PROSESS'-hendelse
UPDATE ia_prosess ip
SET nav_enhet_nummer = null,
    nav_enhet_navn   = null
WHERE NOT EXISTS
          (SELECT 1
           FROM hendelser_til_samarbeid hts
                    INNER JOIN ia_sak_hendelse ish ON hts.hendelse_id = ish.id
               AND ish.type = 'NY_PROSESS'
               AND hts.samarbeid_id = ip.id);

-- Opprett kobling til nav-enhet slik:
-- Finner siste IA-sakshendelse av typen 'NY_PROSESS' (nytt samarbeid) som skjedde _før_ samarbeidet ble opprettet.
-- Verifisert at disse tidspunktene alltid er < 1 sekund fra hverandre, altså at de med svært høy sannsynlighet hører til samme samarbeid.
UPDATE ia_prosess ip
SET nav_enhet_nummer = ish.nav_enhet_nummer,
    nav_enhet_navn   = ish.nav_enhet_navn
FROM ia_sak_hendelse ish
WHERE ish.saksnummer = ip.saksnummer
  AND ip.nav_enhet_nummer IS NULL
  AND ish.opprettet =
      (SELECT max(indre.opprettet)
       FROM ia_sak_hendelse indre
       WHERE indre.saksnummer = ip.saksnummer
         AND indre.type = 'NY_PROSESS'
         AND indre.opprettet <= ip.opprettet);

-- For de som fortsatt mangler verdi etter å ha hentet fra 'NY_PROSESS'
UPDATE ia_prosess ip
SET nav_enhet_nummer = ish.nav_enhet_nummer,
    nav_enhet_navn = ish.nav_enhet_navn
FROM ia_sak_hendelse ish
WHERE ish.saksnummer = ip.saksnummer
  AND ip.nav_enhet_nummer IS NULL
  AND ish.opprettet =
      (SELECT max(indre.opprettet)
       FROM ia_sak_hendelse indre
       WHERE indre.saksnummer = ip.saksnummer
         AND indre.type = 'OPPRETT_SAK_FOR_VIRKSOMHET'
         AND indre.opprettet <= ip.opprettet);
