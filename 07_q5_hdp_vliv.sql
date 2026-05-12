-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 07: OTAZKA 5 - Ma vyska HDP vliv na mzdy a ceny potravin?

WITH rocni_data AS (
    SELECT 
        rok,
        AVG(prumerna_mzda) AS mzda,
        AVG(prumerna_cena) AS cena
    FROM t_petr_faulhammer_project_SQL_primary_final
    GROUP BY rok
),
hdp_data AS (
    SELECT 
        year AS rok,
        AVG(gdp) AS hdp
    FROM t_petr_faulhammer_project_SQL_secondary_final
    WHERE country = 'Czech Republic'
    GROUP BY year
)
SELECT 
    h.rok,
    ROUND(h.hdp::numeric) AS hdp,
    ROUND(
        ((h.hdp - LAG(h.hdp) OVER (ORDER BY h.rok))
        / LAG(h.hdp) OVER (ORDER BY h.rok) * 100)::numeric, 2
    ) AS rust_hdp_pct,
    ROUND(r.mzda::numeric) AS prumerna_mzda,
    ROUND(
        ((r.mzda - LAG(r.mzda) OVER (ORDER BY h.rok))
        / LAG(r.mzda) OVER (ORDER BY h.rok) * 100)::numeric, 2
    ) AS rust_mezd_pct,
    ROUND(r.cena::numeric, 2) AS prumerna_cena,
    ROUND(
        ((r.cena - LAG(r.cena) OVER (ORDER BY h.rok))
        / LAG(r.cena) OVER (ORDER BY h.rok) * 100)::numeric, 2
    ) AS rust_cen_pct
FROM hdp_data h
JOIN rocni_data r ON h.rok = r.rok
ORDER BY h.rok;
