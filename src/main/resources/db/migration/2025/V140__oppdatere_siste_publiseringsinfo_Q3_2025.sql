insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2025, 3, '2025-11-27', '2026-02-26');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
