# Projekt SQL: Dostupnost potravin v ČR (2006–2018)

## Autor
Petr Faulhammer

## Popis projektu
Projekt analyzuje dostupnost základních potravin pro obyvatele České republiky na základě průměrných mezd a cen potravin v letech 2006–2018. Výsledky slouží jako podklad pro tiskové oddělení k prezentaci na konferenci zaměřené na životní úroveň občanů.

## Struktura projektu
Skripty jsou rozděleny do samostatných souborů podle jednotlivých úkolů:

| Soubor | Popis |
|--------|-------|
| `01_primary_table.sql` | Vytvoření primární tabulky |
| `02_secondary_table.sql` | Vytvoření sekundární tabulky |
| `03_q1_mzdy_mezirocne.sql` | Otázka 1 — meziroční vývoj mezd |
| `04_q2_mleko_chleb.sql` | Otázka 2 — dostupnost mléka a chleba |
| `05_q3_zdrazovani.sql` | Otázka 3 — nejpomaleji zdražující potraviny |
| `06_q4_ceny_vs_mzdy.sql` | Otázka 4 — srovnání růstu cen a mezd |
| `07_q5_hdp_vliv.sql` | Otázka 5 — vliv HDP na mzdy a ceny |

## Výstupní tabulky

### t_petr_faulhammer_project_SQL_primary_final
Primární tabulka obsahuje průměrné mzdy podle odvětví a průměrné ceny potravin v ČR za společné období 2006–2018.

Sloupce:
- `rok` — rok měření
- `odvetvi` — název odvětví
- `prumerna_mzda` — průměrná mzda v odvětví (Kč)
- `kategorie_potravin` — název kategorie potraviny
- `prumerna_cena` — průměrná cena potraviny (Kč)

### t_petr_faulhammer_project_SQL_secondary_final
Sekundární tabulka obsahuje makroekonomické ukazatele evropských států za stejné období.

Sloupce:
- `country` — název státu
- `year` — rok
- `gdp` — hrubý domácí produkt (USD)
- `gini` — GINI koeficient
- `population` — počet obyvatel

## Informace o datech
- Společné období: **2006–2018**
- Mzdy dostupné: 2000–2021 (oříznuty na 2006–2018 dle dostupnosti cen)
- Ceny potravin dostupné: 2006–2018
- GINI koeficient obsahuje NULL hodnoty pro některé státy a roky — data nebyla dostupná
- Některé kategorie potravin nejsou sledovány po celé období 2006–2018 (např. Jakostní víno bílé — data pouze za 2015–2018)

## Výsledky výzkumných otázek

### Otázka 1 — Rostou mzdy ve všech odvětvích meziročně?
**Ano, celkově** — mzdy rostly ve všech 19 odvětvích v období 2006–2018, avšak ne každý rok. Meziroční analýza odhaluje konkrétní roky s poklesy.

Příklady meziročních poklesů:
- **2013:** Peněžnictví a pojišťovnictví, Zpracovatelský průmysl a řada dalších odvětví zaznamenala meziroční pokles — nejhorší rok z hlediska mzdového vývoje celého sledovaného období
- **2012:** Stavebnictví vykazovalo pokles odpovídající útlumu celého sektoru

Propady v letech 2012–2013 odpovídají období evropské dluhové krize a fiskální konsolidaci v ČR. Veřejný sektor (zdravotnictví, vzdělávání) byl v krizových letech stabilnější než průmysl a finance. Naopak nejsilnější mzdový růst přinesla léta 2017–2018, kdy historicky nízká nezaměstnanost tlačila mzdy nahoru napříč odvětvími.

### Otázka 2 — Kolik mléka a chleba lze koupit za průměrnou mzdu?

| Rok | Průměrná mzda | Cena mléka | Cena chleba | Litrů mléka | Kg chleba |
|-----|--------------|------------|-------------|-------------|-----------|
| 2006 | 20 342 Kč | 14,44 Kč | 16,12 Kč | 1 409 | 1 262 |
| 2018 | 31 980 Kč | 19,82 Kč | 24,24 Kč | 1 614 | 1 319 |

Dostupnost potravin se zlepšila — za průměrnou mzdu si člověk v roce 2018 koupil o ~14 % více mléka a o ~5 % více chleba než v roce 2006. Přestože nominální ceny obou komodit vzrostly (mléko o 37 %, chléb o 50 %), mzdový růst (+57 %) byl rychlejší. Chléb zdražoval relativně výrazněji než mléko, což se odráží v menším zlepšení jeho dostupnosti — pravděpodobně vlivem vyšší energetické náročnosti pekárenské výroby.

### Otázka 3 — Která potravina zdražuje nejpomaleji?
Analýza je postavena na průměrném meziročním nárůstu ceny. Výsledky zahrnují pouze roky, pro které jsou data dostupná — kategorie s méně záznamy je vhodné interpretovat s rezervou (sloupec `pocet_mezirocnich_zmen`).

Nejpomaleji zdražuje **Cukr krystalový** (průměrný meziroční nárůst **−1,92 %** — cena tedy v průměru klesala). Druhý je Rajská jablka červená kulatá (−0,74 %), třetí Banány žluté (+0,81 %).

Pokles ceny cukru odpovídá vývoji na světových komoditních trzích, kde nadprodukce a dotační politika EU dlouhodobě tlačily ceny dolů. Naopak nejrychleji zdražovaly potraviny závislé na domácích nákladech — zejména masné výrobky a mléčné produkty, kde se projevily rostoucí náklady na krmiva a energie.

### Otázka 4 — Existuje rok kdy ceny rostly výrazně více než mzdy (o více než 10 %)?
**Ne** — žádný rok nevykazuje rozdíl větší než 10 procentních bodů. Největší rozdíl byl v roce **2013**, kdy ceny potravin rostly o 5,1 % zatímco průměrné mzdy klesly o 1,56 % — rozdíl tedy činil 6,66 p.b. Z pohledu reálné kupní síly šlo o nejhorší rok sledovaného období, přičemž domácnosti s nižšími příjmy, které vydávají na potraviny vyšší podíl rozpočtu, jej pocítily výrazněji.

Příznivým obdobím byly roky **2016–2018**, kdy mzdy rostly rychleji než ceny potravin a reálná kupní síla se soustavně zlepšovala.

### Otázka 5 — Má výška HDP vliv na mzdy a ceny potravin?
**Ano, částečně** — růst HDP se projevuje růstem mezd ve stejném nebo následujícím roce:

- **2007:** HDP +5,57 % → mzdy +6,79 %
- **2009:** HDP −4,66 % (finanční krize) → mzdový růst zpomalil na +3,25 %
- **2012–2013:** HDP stagnovalo → mzdy klesly v řadě odvětví
- **2015–2018:** HDP rostlo průměrně o 4 % ročně → mzdy rostly o 5–8 %

Vliv HDP na ceny potravin je méně přímý a méně konzistentní. Ceny potravin jsou více ovlivněny globálními komoditními trhy a zemědělskou sezónou než domácím ekonomickým výkonem — například v roce 2009 HDP kleslo o 4,66 %, ale ceny potravin přesto mírně vzrostly.

## Závěr projektu
Analýza za období 2006–2018 ukazuje, že životní úroveň obyvatel ČR měřená dostupností základních potravin se celkově zlepšila. Mzdový růst (+57 % v průměru) předstihl zdražování potravin, i když ne v každém roce rovnoměrně.

Kritickým obdobím byla léta **2012–2013**, kdy ekonomická stagnace přinesla meziroční poklesy mezd v řadě odvětví při současném mírném zdražování potravin. Naopak roky **2015–2018** byly charakteristické silným souběžným růstem HDP, mezd i cenovou stabilitou.

Projekt potvrzuje, že makroekonomický kontext (HDP) má měřitelný vliv na mzdový vývoj, zatímco ceny potravin jsou determinovány širšími faktory včetně globálních komoditních trhů. Žádný rok ve sledovaném období nevykazoval kritický rozdíl mezi růstem cen a mezd přesahující 10 p.b.

## Zdroje dat
- Portál otevřených dat ČR — mzdy (`czechia_payroll`) a ceny potravin (`czechia_price`)
- Data Academy databáze — `economies`, `countries`
