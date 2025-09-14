/*
==============================================================================================
Analysis Script: Part-to-Whole Analysis
==============================================================================================

Script Purpose: 
    This script analyzes how each product category contributes to the overall sales.
    It calculates total sales by category, compares it to overall sales, and expresses 
    the contribution as a percentage.

Usage:
    - Identify categories that drive the largest share of sales.
    - Perform part-to-whole analysis to evaluate category importance.
    - Use percentage contributions for reporting and visualization.
==============================================================================================
*/


-- Which category contribute the most to overall sales?

-- Joining the tables, 1 measure & 1 dimension
-- Total sales for each category
-- With CTE find overall sales including all categories
-- Finding part to whole / percentage, convert total_sales to FLOAT since percent is 0, 
-- And use ROUND to keep 2 decimal points, Use CONCAT() to add % sign

-- ==============================================================================================
-- Step 1: Calculate Total Sales by Category
-- ==============================================================================================
WITH category_sales AS (
SELECT
p.category,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category
)

-- ==============================================================================================
-- Step 2: Calculate Part-to-Whole Contribution
-- ==============================================================================================
SELECT 
category,
total_sales,
SUM(total_sales) OVER() AS overall_sales,
CONCAT(ROUND((CAST (total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC




