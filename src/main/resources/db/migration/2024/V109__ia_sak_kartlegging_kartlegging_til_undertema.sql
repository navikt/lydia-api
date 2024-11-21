-- kobling mellom kartlegging, tema og undertema(er)
create table ia_sak_kartlegging_kartlegging_til_undertema
(
    id             serial primary key,
    kartlegging_id varchar(36) not null,
    tema_id        int         not null,
    undertema_id   int         not null,
    constraint fk_ia_sak_kartlegging_k_til_undertema_kartlegging foreign key (kartlegging_id) references ia_sak_kartlegging (kartlegging_id),
    constraint fk_ia_sak_kartlegging_k_til_undertema_tema foreign key (tema_id) references ia_sak_kartlegging_tema (tema_id),
    constraint fk_ia_sak_kartlegging_k_til_undertema_undertema foreign key (undertema_id) references ia_sak_kartlegging_undertema (undertema_id),
    constraint fk_ia_sak_kartlegging_k_til_undertema_k_tema_undertema unique (kartlegging_id, tema_id, undertema_id)
);

-- Legg til mapping kartlegging <-> tema - undertema
-- Init ved å kopiere eksisterende forhold kartlegging <-> tema fra ia_sak_kartlegging_kartlegging_til_tema
--  tema_id og undertema_id har samme verdi da det bare finne 1 undertema per tema
--  (og de har samme ID)
insert into ia_sak_kartlegging_kartlegging_til_undertema (kartlegging_id, tema_id, undertema_id)
select KKT.kartlegging_id, KKT.tema_id, KKT.tema_id
from ia_sak_kartlegging_kartlegging_til_tema KKT;
