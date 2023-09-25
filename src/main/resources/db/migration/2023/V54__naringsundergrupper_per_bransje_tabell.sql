create table naringsundergrupper_per_bransje
(
    naringsundergruppe varchar primary key,
    bransje            varchar not null,
    opprettet          timestamp default current_timestamp
);
create index idx_bransje_naringsundergrupper_per_bransje on naringsundergrupper_per_bransje (bransje);

-- Barnehager
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('88.911', 'BARNEHAGER');
-- Næringsmiddelindustri
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.110', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.120', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.130', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.201', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.202', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.203', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.209', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.310', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.320', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.390', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.411', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.412', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.413', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.420', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.510', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.520', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.610', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.620', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.710', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.720', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.730', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.810', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.820', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.830', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.840', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.850', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.860', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.890', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.910', 'NÆRINGSMIDDELINDUSTRI');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('10.920', 'NÆRINGSMIDDELINDUSTRI');
-- Sykehus
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('86.101', 'SYKEHUS');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('86.102', 'SYKEHUS');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('86.104', 'SYKEHUS');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('86.105', 'SYKEHUS');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('86.106', 'SYKEHUS');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('86.107', 'SYKEHUS');
-- Sykehjem
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('87.101', 'SYKEHJEM');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('87.102', 'SYKEHJEM');
-- Transport
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('49.100', 'TRANSPORT');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('49.311', 'TRANSPORT');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('49.391', 'TRANSPORT');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('49.392', 'TRANSPORT');
-- Bygg
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('41.101', 'BYGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('41.109', 'BYGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('41.200', 'BYGG');
-- Anlegg
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.110', 'ANLEGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.120', 'ANLEGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.130', 'ANLEGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.210', 'ANLEGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.220', 'ANLEGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.910', 'ANLEGG');
insert into naringsundergrupper_per_bransje(naringsundergruppe, bransje)
VALUES ('42.990', 'ANLEGG');
