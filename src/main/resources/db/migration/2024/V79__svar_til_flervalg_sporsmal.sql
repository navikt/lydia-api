alter table ia_sak_kartlegging_svar add column svar_ider jsonb not null default '[]'::jsonb;
update ia_sak_kartlegging_svar set svar_ider = jsonb_build_array(svar_id) where svar_ider = '[]'::jsonb;

alter table ia_sak_kartlegging_svar drop column svar_id;