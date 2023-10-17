alter table naring alter column navn type varchar;
alter table naring add column kort_navn varchar;

create table virksomhet_naring (
    virksomhet int not null,
    narings_kode varchar not null,
    constraint fk_virksomhet_naring_virksomhet foreign key (virksomhet) references virksomhet(id) on delete cascade,
    constraint fk_virksomhet_naring_naring foreign key (narings_kode) references naring(kode),
    constraint virksomhet_naring_unik unique (virksomhet, narings_kode)
);