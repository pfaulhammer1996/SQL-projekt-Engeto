-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 01: VYTVORENI PRIMARNI TABULKY

DROP TABLE IF EXISTS t_petr_faulhammer_project_SQL_primary_final;

CREATE TABLE t_petr_faulhammer_project_SQL_primary_final AS
SELECT 
    cp.payroll_year          AS rok,
    cpib.name                AS odvetvi,
    AVG(cp.value)            AS prumerna_mzda,
    cpc.name                 AS kategorie_potravin,
    AVG(cpr.value)           AS prumerna_cena
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib 
    ON cp.industry_branch_code = cpib.code
JOIN czechia_price cpr 
    ON cp.payroll_year = EXTRACT(YEAR FROM cpr.date_from)
JOIN czechia_price_category cpc 
    ON cpr.category_code = cpc.code
WHERE cp.value_type_code = 5958
    AND cp.calculation_code = 100
    AND cp.payroll_year BETWEEN 2006 AND 2018
GROUP BY cp.payroll_year, cpib.name, cpc.name
ORDER BY cp.payroll_year;
