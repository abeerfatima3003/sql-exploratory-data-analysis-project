-- Find the date of the first and last order
-- How many years of sales are available
-- How many months of sales are available

SELECT 
order_date
FROM gold.fact_sales

-- Finding the first dates
-- Finding the last dates
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date),MAX(order_date)) AS order_range_years,
DATEDIFF(month, MIN(order_date),MAX(order_date)) AS order_range_months
FROM gold.fact_sales

-- Find youngest and oldest customers
-- If we need to see ages 
SELECT 
MIN(birth_date) AS old_customer,
DATEDIFF(year, MIN(birth_date), GETDATE()) AS oldest_age,
MAX(birth_date) AS young_customer,
DATEDIFF(year, MAX(birth_date), GETDATE()) AS youngest_age 
FROM gold.dim_customers 



