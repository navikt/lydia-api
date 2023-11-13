-- sett alle gamle moduler til deaktivert
update modul set deaktivert = true;

-- opprett generelle moduler
insert into modul (id, ia_tjeneste, navn, deaktivert) VALUES
    (15, 1, 'Redusere sykefravær', false),
    (16, 2, 'Forebyggende arbeidsmiljøarbeid', false),
    (17, 3, 'HelseIArbeid', false);
