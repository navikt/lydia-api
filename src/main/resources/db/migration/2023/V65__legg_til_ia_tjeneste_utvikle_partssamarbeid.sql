-- opprett "Utvikle partssamarbeid" IA-tjeneste
insert into ia_tjeneste (id, navn, deaktivert) VALUES
    (4, 'Utvikle partssamarbeid', false);

-- opprett generell modul for tjenesten
insert into modul (id, ia_tjeneste, navn, deaktivert) VALUES
    (18, 4, 'Utvikle partssamarbeid', false);
