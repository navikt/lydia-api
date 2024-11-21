-- Kobling mellom spørsmål og undertema

-- Undertema og dets forhold til tema (1 tema -> n undertemaer; 1 undertemaer -> 1 tema)
create table ia_sak_kartlegging_sporsmal_til_undertema
(
    undertema_id int not null,
    sporsmal_id  varchar(36) not null,
    rekkefolge   int not null default 0,
    opprettet    date not null default now(), -- sporsmal/undertema skal aldri endre seg
    constraint fk__ia_sak_kartlegging_spmal_til_undertema__undertema_id_fk
        foreign key (undertema_id) references ia_sak_kartlegging_undertema (undertema_id),
    constraint fk__ia_sak_kartlegging_spmal_til_undertema__sporsmal_id_fk
        foreign key (sporsmal_id) references ia_sak_kartlegging_sporsmal (sporsmal_id)
);

-- Legg til mapping spørsmål <-> undertema
-- Init ved å kopiere eksisterende forhold tema_id <-> spørsmål_id
--  tema_id og undertema_id har samme verdi da det bare finne 1 undertema per tema
--  (og de har samme ID)
insert into ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id)
select TS.tema_id, TS.sporsmal_id
from ia_sak_kartlegging_tema_til_spørsmål TS;
