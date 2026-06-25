# MySQL Exploratory Data Analysis: Global Tech Layoffs

Exploratory Data Analysis (EDA) project on a global tech layoffs dataset using MySQL. This project follows the data cleaning phase ([MYSQL-data-cleaning-project](https://github.com/MitaibA/MYSQL-data-cleaning-project)) and focuses on uncovering trends and patterns in tech industry layoffs.

## Overview

This project analyzes layoff events across the global tech industry to answer questions such as:
- Which industries and company stages were hit hardest?
- How did layoffs trend over time?
- Which companies had the largest layoffs each year?

## Dataset

The dataset contains layoff records from tech companies worldwide, including fields such as:
- `company`, `location`, `country`, `industry`
- `total_laid_off`, `percentage_laid_off`
- `date`, `stage`, `funds_raised`

**Date range:** March 2020 – April 2026

## Tools Used

- **MySQL Workbench** – SQL queries and analysis
- **SQL Concepts:** Aggregations, `GROUP BY`, CTEs, Window Functions (`DENSE_RANK`, `SUM OVER`), Subqueries

## Analysis Performed

1. **Initial Exploration** – Largest single layoff event and highest percentage laid off
2. **Date Range** – Identifying the time span of the dataset
3. **Layoffs by Industry** – Which industries lost the most jobs
4. **Layoffs by Year** – Year-over-year totals
5. **Layoffs by Company Stage** – Post-IPO, Series B, etc.
6. **Layoffs by Month** – Monthly time series
7. **Rolling Total of Layoffs** – Cumulative layoffs over time using window functions
8. **Top Companies by Total Layoffs** – Companies with the highest layoff counts
9. **Layoffs by Company per Year** – Breakdown by company and year
10. **Top 5 Companies per Year** – Ranking with `DENSE_RANK()` and chained CTEs

## Key Findings

- Post-IPO companies accounted for the largest share of layoffs by stage
- Layoffs peaked in specific months, visible through the rolling total analysis
- Major tech companies (Uber, Meta, Google, Microsoft, Amazon) consistently ranked in the top 5 per year

## Files

- `EDA_layoffs.sql` – All SQL queries organized by analysis section

## Author

**Mitaib** – Junior Data Analyst | [GitHub](https://github.com/MitaibA)
