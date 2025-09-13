/*
==============================================================================================
Ranking Analysis
==============================================================================================

Script Purpose: 
    This script ranks products and customers based on revenue and order activity. 
    It identifies top and bottom performers using aggregate functions and 
    window functions (ROW_NUMBER, RANK).

Usage:
    - Highlight best and worst-performing products by revenue.
    - Rank customers by revenue contribution.
    - Identify customers with minimal order activity.
==============================================================================================
*/

-- ==============================================================================================
-- Step 1: Find Top 5 Products by Revenue
-- ==============================================================================================
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- ==============================================================================================
-- Step 2: Find Top 5 Products by Revenue (Using Window Function)
-- ==============================================================================================
SELECT * 
FROM(
	SELECT 
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC ) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
	GROUP BY p.product_name) t
WHERE rank_products <= 5

-- ==============================================================================================
-- Step 3: Find Bottom 5 Products by Revenue
-- ==============================================================================================
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY product_name
ORDER BY total_sales ASC

-- ==============================================================================================
-- Step 4: Find Top 10 Customers by Revenue
-- ==============================================================================================
SELECT *
FROM(
	SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_order
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
	GROUP BY 
	c.customer_id,
	c.first_name,
	c.last_name ) t
WHERE rank_order <= 10

-- ==============================================================================================
-- Step 5: Find Top 3 Customers with Fewest Orders (Using RANK)
-- ==============================================================================================
SELECT *
FROM(
	SELECT 
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT f.order_number) AS order_placed,
	RANK() OVER (ORDER BY COUNT(DISTINCT f.order_number)) AS rank_order
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
	GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name ) t
WHERE rank_order <= 3

-- ==============================================================================================
-- Step 6: Find Top 3 Customers with Fewest Orders (Simple Query)
		   Alternative method without window functions
-- ==============================================================================================
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT f.order_number) AS order_placed
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers  c
ON f.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY order_placed 





