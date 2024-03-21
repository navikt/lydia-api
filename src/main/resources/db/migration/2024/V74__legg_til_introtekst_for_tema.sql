alter table ia_sak_kartlegging_tema add column introtekst varchar;

UPDATE ia_sak_kartlegging_tema
SET introtekst = 'Partssamarbeid er essensielt i virksomheter fordi det bidrar til et godt forebyggende arbeidsmiljø og reduksjon av antall tapte dagsverk. Partssamarbeidet anerkjenner og utnytter kompetansen og ansvarsområdene til verneombud, tillitsvalgte og ledere, noe som skaper en "utvidet ledelseskapasitet".'
WHERE tema_id = 1;

UPDATE ia_sak_kartlegging_tema
SET introtekst = 'Redusere sykefravær er essensielt i virksomheter ...'
WHERE tema_id = 2;
