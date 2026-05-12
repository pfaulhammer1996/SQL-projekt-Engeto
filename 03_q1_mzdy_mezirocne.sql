-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 03: OTAZKA 1 - Rostou mzdy mezirocne ve vsech odvetvich?

WITH rocni_mzdy AS (
    SELECT 
        rok,
        odvetvi,
        AVG(prumerna_mzda) AS mzda
    FROM t_petr_faulhammer_project_SQL_primary_final
    GROUP BY rok, odvetvi
),
mezirocni AS (
    SELECT 
        rok,
        odvetvi,
        ROUND(mzda::numeric) AS prumerna_mzda,
        ROUND(LAG(mzda) OVER (PARTITION BY odvetvi ORDER BY rok)::numeric) AS mzda_predchozi_rok,
        ROUND(
            ((mzda - LAG(mzda) OVER (PARTITION BY odvetvi ORDER BY rok))
            / LAG(mzda) OVER (PARTITION BY odvetvi ORDER BY rok) * 100)::numeric, 2
        ) AS mezirocni_rust_pct
    FROM rocni_mzdy
)
SELECT 
    rok,
    odvetvi,
    prumerna_mzda,
    mzda_predchozi_rok,
    mezirocni_rust_pct,
    CASE WHEN mezirocni_rust_pct < 0 THEN 'POKLES' ELSE 'RUST' END AS trend
FROM mezirocni
WHERE mzda_predchozi_rok IS NOT NULL
ORDER BY odvetvi, rok;
