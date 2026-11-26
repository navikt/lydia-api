insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2026, 3, '2026-11-26', '2027-02-25');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
