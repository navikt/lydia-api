insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2026, 2, '2026-09-03', '2026-11-26');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
