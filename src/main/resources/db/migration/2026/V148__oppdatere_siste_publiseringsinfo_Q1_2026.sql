insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2026, 1, '2026-05-28', '2026-09-03');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
