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
