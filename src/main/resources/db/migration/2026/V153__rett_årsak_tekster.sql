UPDATE hendelse_begrunnelse
SET aarsak = 'Vurder virksomheten senere'
WHERE aarsak_enum = 'VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT';

UPDATE hendelse_begrunnelse
SET aarsak = 'Nav har konkludert'
WHERE aarsak_enum = 'VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING';

UPDATE hendelse_begrunnelse
SET aarsak = 'Virksomheten har takket nei'
WHERE aarsak_enum = 'VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI';
