DELETE FROM
    virksomhet a
    USING virksomhet b
WHERE
        a.id < b.id
  AND a.orgnr = b.orgnr;

alter table virksomhet
  add constraint virksomhet_unik_orgnr unique (orgnr);