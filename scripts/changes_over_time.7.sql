/*
==============================================================================================
Analysis Script: Changes Over Time
==============================================================================================

Script Purpose: 
    This script analyzes sales and customer performance across different time 
    periods (daily, yearly, monthly). 
    It helps identify trends, seasonality and customer growth over time.

Usage:
    - Track sales performance at different time granularities.
    - Measure customer and quantity trends alongside revenue.
    - Evaluate customer acquisition over time.
==============================================================================================
*/


-- ==============================================================================================
-- Step 1: Analyze Sales Performance by Day
-- ==============================================================================================
SELECT 
order_date,
SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date iS NOT NULL
GROUP BY order_date
ORDER BY order_date


-- ==============================================================================================
-- Step 2: Analyze Sales Performance by Year
-- ============================================================================================== 
SELECT 
YEAR(order_date) as order_year,
SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)


-- ==============================================================================================
-- Step 3: Adding More Measures to Yearly Analysis
-- ==============================================================================================
SELECT 
YEAR(order_date) as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)


-- ==============================================================================================
-- Step 4: Drill Down by Month (Across All Years)
-- ==============================================================================================
SELECT 
MONTH(order_date) as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)


-- ==============================================================================================
-- Step 5: Aggregate Data by Year and Month
-- ==============================================================================================
SELECT 
YEAR(order_date) as order_year,
MONTH(order_date) as order_month,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)


-- ==============================================================================================
-- Step 6: Aggregate by Truncated Month-Year
-- ==============================================================================================
SELECT 
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)


-- ==============================================================================================
-- Step 7: Format Order Date as Year-Month
-- Purpose: Display results in a more readable 'YYYY-MMM' format
-- ============================================================================================== 
SELECT 
FORMAT(order_date, 'yyyy-MMM') as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')


-- ==============================================================================================
-- Step 8: Track New Customer Acquisition by Year
-- ==============================================================================================
SELECT 
DATETRUNC(year, create_date) as create_year,
COUNT(customer_key) as total_customers
FROM gold.dim_customers
GROUP BY DATETRUNC(year, create_date)
ORDER BY DATETRUNC(year, create_date)







