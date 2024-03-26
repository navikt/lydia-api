alter table ia_sak_kartlegging_tema add column rekkefolge int not null default 0;
update ia_sak_kartlegging_tema set rekkefolge = 1 where tema_id = 1;
update ia_sak_kartlegging_tema set rekkefolge = 2 where tema_id = 2;