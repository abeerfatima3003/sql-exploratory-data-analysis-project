/*
==============================================================================================
Measures Exploration
==============================================================================================

Script Purpose: 
    This script explores key business measures (KPIs) from the fact and dimension tables. 
    It calculates totals, averages, and distinct counts to validate data quality and 
    establish baseline business metrics.

Usage:
    - Understand overall sales performance and volumes.
    - Check for data integrity by comparing raw counts vs. distinct counts.
    - Produce a consolidated report with key metrics.
==============================================================================================
*/


-- ==============================================================================================
-- Step 1: Find the Total Sales
-- ==============================================================================================
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales

-- ==============================================================================================
-- Step 2: Find the total quantity of items sold
-- ==============================================================================================
SELECT SUM(quantity) AS total_quantity
FROM gold.fact_sales

-- ==============================================================================================
-- Step 3: Find the average selling price
-- ==============================================================================================
SELECT AVG(price) AS avg_price
FROM gold.fact_sales

-- ==============================================================================================
-- Step 4: Find the total number of orders
-- ==============================================================================================
SELECT COUNT(order_number) AS total_orders
FROM gold.fact_sales
-- Check distinct order numbers to validate no duplicates
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales

-- ==============================================================================================
-- Step 5: Find the total number of products
-- ==============================================================================================
SELECT COUNT(product_key) AS total_products
FROM gold.dim_products
-- Check distinct product keys for duplicates
SELECT COUNT(DISTINCT product_key) AS total_products
FROM gold.dim_products -- No duplicates found (could also check product_name)

-- ==============================================================================================
-- Step 6: Find the total number of customers
-- ==============================================================================================
SELECT COUNT(customer_id) AS total_customers
FROM gold.dim_customers
-- Check distinct customer IDs for duplicates
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers;

-- ==============================================================================================
-- Step 7: Find number of customers who have placed at least one order
-- ==============================================================================================
SELECT COUNT(DISTINCT customer_key) AS total_customers_orders
FROM gold.fact_sales;

-- ==============================================================================================
-- Step 8: Generate consolidated report of all key business measures
           Create a unified view of core KPIs for analysis
-- ==============================================================================================
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr.Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr.Products' AS measure_name , COUNT(DISTINCT product_key) AS measure_value
FROM gold.dim_products
UNION ALL
SELECT 'Total Nr.Customers' AS measure_name, COUNT(DISTINCT customer_id) AS measure_value
FROM gold.dim_customers

