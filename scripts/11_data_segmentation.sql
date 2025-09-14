/*
==============================================================================================
Analysis Script: Data Segmentation
==============================================================================================

Script Purpose: 
    This script segments both products and customers into meaningful groups based on cost and spending behavior. 
	Segmentation helps identify different customer/product profiles and supports targeted analysis.
	Helps understand coorelation between measures.

Usage:
    - Categorize products into cost ranges for inventory/price band analysis.
    - Segment customers into VIP, Regular, and New groups based on lifetime 
      spending and order history.
==============================================================================================
*/

-- Segment products into cost ranges and count how many products fall into each segment


-- Converting measure to dimension (CASE WHEN)
-- CTE as product_segments
-- Aggregate data based on new dimension

-- ==============================================================================================
-- Product Segmentation by Cost Range
-- ==============================================================================================
WITH product_segments AS (
SELECT
product_key,
product_name,
product_cost,
CASE WHEN product_cost < 100 THEN 'Below 100'
	 WHEN product_cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN product_cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END AS cost_range
FROM gold.dim_products )

SELECT
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC


/*Group customers into 3 segments based on their spending behaviour:
	VIP: Customers with at least 12 months of history and spending more than $5000.
	Regular: Customers with atleast 12 months of history but spending $5000 or less.
	New: Customers with a life span less than 12 months
And find the total number of customers by each group.
*/


-- Defining the columns required and joining tables
-- Finding first & last order of each customer using MIN() MAX()
-- Calculating months between first & last order using DATEDIFF()
-- Creating segment based on the results belown using CTE
-- Finding total number of customers in each group

-- ==============================================================================================
-- Customer Segmentation by Spending Behavior
-- ==============================================================================================
WITH customer_spending AS (
SELECT 
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)

/*
SELECT 
customer_key,
total_spending,
lifespan,
CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
	 WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
	 ELSE 'New'
END AS customer_segments
FROM customer_spending
*/

-- ==============================================================================================
-- Aggregate Customer Segments
-- ==============================================================================================
SELECT 
customer_segments,
COUNT(customer_key) AS total_customers
FROM (
	SELECT 
	customer_key,
	CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
		 ELSE 'New'
	END AS customer_segments
	FROM customer_spending ) t
GROUP BY customer_segments
ORDER BY total_customers DESC






