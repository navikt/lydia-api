insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2025, 4, '2026-02-26', '2026-05-28');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
