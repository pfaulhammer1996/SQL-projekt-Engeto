-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 04: OTAZKA 2 - Kolik mleka a chleba lze koupit za prumernou mzdu?

SELECT 
    rok,
    ROUND(AVG(prumerna_mzda)::numeric) AS prumerna_mzda,
    ROUND(MAX(CASE WHEN kategorie_potravin = 'Mléko polotučné pasterované' 
        THEN prumerna_cena END)::numeric, 2) AS cena_mleka,
    ROUND(MAX(CASE WHEN kategorie_potravin = 'Chléb konzumní kmínový' 
        THEN prumerna_cena END)::numeric, 2) AS cena_chleba,
    ROUND((AVG(prumerna_mzda) / MAX(CASE WHEN kategorie_potravin = 'Mléko polotučné pasterované' 
        THEN prumerna_cena END))::numeric) AS litru_mleka,
    ROUND((AVG(prumerna_mzda) / MAX(CASE WHEN kategorie_potravin = 'Chléb konzumní kmínový' 
        THEN prumerna_cena END))::numeric) AS kg_chleba
FROM t_petr_faulhammer_project_SQL_primary_final
WHERE rok IN (2006, 2018)
GROUP BY rok
ORDER BY rok;
