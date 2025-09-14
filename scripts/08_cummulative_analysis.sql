/*
==============================================================================================
Analysis Script: Cumulative Analysis
==============================================================================================

Script Purpose: 
    This script explores cumulative metrics and moving averages over time using window functions. 
    It helps analyze how sales accumulate month by month or year by year, 
    and introduces moving average trends.
    Helps to understand if business is growing or declining. 

Usage:
    - Track cumulative revenue growth over time.
    - Compare cumulative totals by month vs. by year.
    - Apply window functions for moving averages to detect trends.
==============================================================================================
*/


-- ==============================================================================================
-- Step 1: Calculate Monthly Sales and Running Total
-- ==============================================================================================
SELECT
order_date,
total_sales,
-- window function
SUM(total_sales) OVER (ORDER BY order_date) as running_total_sales
FROM
(
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t


-- ==============================================================================================
-- Step 2: Running Total Reset Each Year
-- ==============================================================================================
SELECT
order_date,
total_sales,
-- window function
SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) as running_total_sales
FROM
(
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t


-- ==============================================================================================
-- Step 3: Running Total of Yearly Sales
-- ==============================================================================================
SELECT
order_date,
total_sales,
-- window function
SUM(total_sales) OVER (ORDER BY order_date) as running_total_sales
FROM
(
SELECT
DATETRUNC(year, order_date) as order_date,
SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
) t


-- ==============================================================================================
-- Step 4: Running Total with Moving Average of Price
-- ==============================================================================================
SELECT
order_date,
total_sales,
-- window function
SUM(total_sales) OVER (ORDER BY order_date) as running_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) as moving_avg_price
FROM
(
SELECT
DATETRUNC(year, order_date) as order_date,
SUM(sales_amount) as total_sales,
AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
) t

