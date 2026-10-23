CREATE TYPE virksomhet_tilstand_type AS ENUM (
    'VirksomhetKlarTilVurdering',
    'VirksomhetVurderes',
    'VirksomhetErVurdert',
    'VirksomhetHarAktiveSamarbeid',
    'AlleSamarbeidIVirksomhetErAvsluttet',
    'VirksomhetErAvregistrertIBrreg'
);
