alter table virksomhet_statistikk_metadata
  add constraint virksomhet_statistikk_metadata_unik_orgnr unique (orgnr);