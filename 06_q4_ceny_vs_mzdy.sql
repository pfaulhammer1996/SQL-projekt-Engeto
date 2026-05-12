-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 06: OTAZKA 4 - Existuje rok kdy ceny rostly vyrazne vice nez mzdy?

WITH rocni_data AS (
    SELECT 
        rok,
        AVG(prumerna_mzda) AS mzda,
        AVG(prumerna_cena) AS cena
    FROM t_petr_faulhammer_project_SQL_primary_final
    GROUP BY rok
)
SELECT 
    rok,
    ROUND(mzda::numeric) AS prumerna_mzda,
    ROUND(cena::numeric, 2) AS prumerna_cena,
    ROUND(
        ((cena - LAG(cena) OVER (ORDER BY rok))
        / LAG(cena) OVER (ORDER BY rok) * 100)::numeric, 2
    ) AS rust_cen_pct,
    ROUND(
        ((mzda - LAG(mzda) OVER (ORDER BY rok))
        / LAG(mzda) OVER (ORDER BY rok) * 100)::numeric, 2
    ) AS rust_mezd_pct,
    ROUND(
        ((((cena - LAG(cena) OVER (ORDER BY rok)) / LAG(cena) OVER (ORDER BY rok))
        - ((mzda - LAG(mzda) OVER (ORDER BY rok)) / LAG(mzda) OVER (ORDER BY rok))) * 100)::numeric
    , 2) AS rozdil_pct
FROM rocni_data
ORDER BY rok;
