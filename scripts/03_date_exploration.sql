/*
==============================================================================================
Date Exploration
==============================================================================================

Script Purpose: 
    
    This script explores temporal aspects of the dataset, such as order history 
    and customer ages. By analyzing the first/last order dates and customer 
    birth dates.
    Understands the timespan and the scope of data

Usage:
    - Determine the coverage period of sales (years and months).
    - Identify youngest and oldest customers to validate demographic information.
==============================================================================================
*/

-- ==============================================================================================
-- Step 1: Verify order_date column exists and contains expected values
-- ==============================================================================================
SELECT 
order_date
FROM gold.fact_sales

-- ==============================================================================================
-- Step 2: Find the first and last order dates 
          Establish the time span of sales data (in years and months)
-- ==============================================================================================
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date),MAX(order_date)) AS order_range_years,
DATEDIFF(month, MIN(order_date),MAX(order_date)) AS order_range_months
FROM gold.fact_sales

-- ==============================================================================================
-- Step 3: Explore customer age distribution
          Identify the youngest and oldest customers for demographic checks
-- ==============================================================================================
SELECT 
MIN(birth_date) AS old_customer,
DATEDIFF(year, MIN(birth_date), GETDATE()) AS oldest_age,
MAX(birth_date) AS young_customer,
DATEDIFF(year, MAX(birth_date), GETDATE()) AS youngest_age 
FROM gold.dim_customers 




