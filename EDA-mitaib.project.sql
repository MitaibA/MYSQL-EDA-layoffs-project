-- ============================================================
-- Exploratory Data Analysis: Global Tech Layoffs
-- Author: Mitaib (github.com/MitaibA)
-- Dataset: World Layoffs (cleaned in previous project)
-- Tool: MySQL Workbench
-- ============================================================

-- Preview the cleaned dataset
SELECT *
FROM layoffs_staging2;


-- ============================================================
-- 1. Initial Exploration
-- ============================================================

-- Largest single layoff event & highest percentage laid off
SELECT MAX(total_laid_off) AS max_layoffs, 
       MAX(percentage_laid_off) AS max_percentage
FROM layoffs_staging2;

-- Companies that laid off 100% of their staff (went under)
-- Ordered by total employees affected
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;


-- ============================================================
-- 2. Date Range of the Dataset
-- ============================================================

SELECT MIN(`date`) AS earliest_date, 
       MAX(`date`) AS latest_date
FROM layoffs_staging2;


-- ============================================================
-- 3. Layoffs by Industry
-- ============================================================

SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;


-- ============================================================
-- 4. Layoffs by Year
-- ============================================================

SELECT YEAR(`date`) AS year, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY year DESC;


-- ============================================================
-- 5. Layoffs by Company Stage
-- (Post-IPO, Series B, etc. — shows which funding stages were hit hardest)
-- ============================================================

SELECT stage, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;


-- ============================================================
-- 6. Layoffs by Month (Time Series)
-- ============================================================

SELECT SUBSTRING(`date`, 1, 7) AS `month`, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month` ASC;


-- ============================================================
-- 7. Rolling Total of Layoffs by Month
-- (Running sum to visualize cumulative impact over time)
-- ============================================================

WITH Rolling_total AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `month`, 
           SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
    ORDER BY `month` ASC
)
SELECT `month`, 
       total_off,
       SUM(total_off) OVER (ORDER BY `month`) AS rolling_total
FROM Rolling_total;


-- ============================================================
-- 8. Top Companies by Total Layoffs
-- ============================================================

SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;


-- ============================================================
-- 9. Layoffs by Company per Year
-- ============================================================

SELECT company, 
       YEAR(`date`) AS year, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY total_layoffs DESC;


-- ============================================================
-- 10. Top 5 Companies with the Most Layoffs Each Year
-- (Uses two CTEs + DENSE_RANK to rank companies within each year)
-- ============================================================

WITH Company_Year (company, years, total_laid_off) AS
(
    SELECT company, 
           YEAR(`date`), 
           SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),
Company_Year_Rank AS
(
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5;