-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 05: OTAZKA 3 - Ktera kategorie potravin zdrazuje nejpomaleji?

WITH rocni_ceny AS (
    SELECT 
        rok,
        kategorie_potravin,
        AVG(prumerna_cena) AS cena
    FROM t_petr_faulhammer_project_SQL_primary_final
    GROUP BY rok, kategorie_potravin
),
mezirocni_ceny AS (
    SELECT 
        rok,
        kategorie_potravin,
        cena,
        ROUND(
            ((cena - LAG(cena) OVER (PARTITION BY kategorie_potravin ORDER BY rok))
            / LAG(cena) OVER (PARTITION BY kategorie_potravin ORDER BY rok) * 100)::numeric, 2
        ) AS mezirocni_rust_pct
    FROM rocni_ceny
)
SELECT 
    kategorie_potravin,
    ROUND(AVG(mezirocni_rust_pct)::numeric, 2) AS prumerny_mezirocni_rust_pct,
    COUNT(*) AS pocet_mezirocnich_zmen
FROM mezirocni_ceny
WHERE mezirocni_rust_pct IS NOT NULL
GROUP BY kategorie_potravin
ORDER BY prumerny_mezirocni_rust_pct ASC;
