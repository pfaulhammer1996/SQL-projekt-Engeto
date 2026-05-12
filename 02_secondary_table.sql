-- ============================================
-- PROJEKT SQL: Dostupnost potravin v CR
-- Autor: Petr Faulhammer
-- Obdobi: 2006-2018
-- ============================================
-- 02: VYTVORENI SEKUNDARNI TABULKY

DROP TABLE IF EXISTS t_petr_faulhammer_project_SQL_secondary_final;

CREATE TABLE t_petr_faulhammer_project_SQL_secondary_final AS
SELECT 
    e.country,
    e.year,
    e.GDP,
    e.gini,
    e.population
FROM economies e
JOIN countries c ON e.country = c.country
WHERE c.continent = 'Europe'
    AND e.year BETWEEN 2006 AND 2018
ORDER BY e.country, e.year;
