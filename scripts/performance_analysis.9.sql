/*
==============================================================================================
Analysis Script: Performance Analysis
==============================================================================================

Script Purpose: 
    This script analyzes the yearly performance of products by comparing their sales 
    against two benchmarks:
        1. The product’s average sales across all years.
        2. The product’s sales in the previous year.
    
    Using window functions and conditional logic, we classify performance as above/below 
    average and increasing/decreasing compared to the prior year.

Usage:
    - Evaluate product performance relative to historical averages.
    - Track year-over-year sales growth or decline.
    - Identify strong vs. weak performers for business decisions.
==============================================================================================
*/


-- Analyze the yearly performance of the products by comparing their sales
-- to both the average sales performance of the product and the previous year's sales


-- order date as dimension, product as dimension and measure as sales
-- Comparing current sales with average sales 
-- With CTE define the columns, first avg sales, then diff in current and avg sales
-- Then using CASE WHEN find avg change
-- comparing previous year sales with LAG() function
-- Comparing diff of current sales and pre_year_sales

-- ==============================================================================================
-- Step 1: Prepare yearly sales per product
-- ==============================================================================================
WITH yearly_product_sales AS
(
SELECT 
YEAR(f.order_date) AS order_year,
p.product_name,
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key 
WHERE f.order_date IS NOT NULL
GROUP BY YEAR(f.order_date), p.product_name
)

-- ==============================================================================================
-- Step 2: Compare Current Sales to Product Average
-- ==============================================================================================
SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
	 WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
ELSE 'Avg'
END AS avg_change,

-- ==============================================================================================
-- Step 3: Compare Current Sales to Previous Year’s Sales
--         Track year-over-year sales change using LAG()
-- ==============================================================================================
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS pre_year_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_pre_year_sales,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
ELSE 'NO Change'
END AS pre_year_change
FROM yearly_product_sales
ORDER BY product_name, order_year