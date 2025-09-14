/*
================================================================================
Product Report
================================================================================
Purpose: 
	- This report consolidates key product metrics and behaviours 

Highlights:
	1. Gathers essential fields such as product name, category, subcategory and cost.
	2. Segments products by revenue to identify High-Performers, Mid-Range or Low-Performers.
	3. Aggregates product-level metrics:
		- total order
		- total sales
		- total quantity sold
		- total customers (unique)
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last sales)
		- average order revenue (AOR)
		- average monthly revenue
================================================================================
*/

-- =============================================================================
-- Create Report = gold.report_customers
-- =============================================================================
IF OBJECT_ID('gold.report_product', 'V') IS NOT NULL
	DROP VIEW gold.report_product,

CREATE VIEW gold.report_product AS

WITH base_query AS (
/*--------------------------------------------------------------------------------
1) Base Query: Retrives core columns from the fact_sales and dim_products
--------------------------------------------------------------------------------*/
SELECT 
	f.order_number,
	f.customer_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.sub_category,
	p.product_cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
WHERE order_date IS NOT NULL -- only consider valid sales data
)

, product_aggregation AS (

/*--------------------------------------------------------------------------------
2) Product_Aggregation: Summarizing key metrics at the product level
--------------------------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	category,
	sub_category,
	product_cost,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
FROM base_query
GROUP BY 
	product_key,
	product_name,
	category,
	sub_category,
	product_cost
)

/* --------------------------------------------------------------------------------
3) Final Query : Combines all product results into one output
--------------------------------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	sub_category,
	product_cost,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency,
	CASE 
		 WHEN total_sales > 50000 THEN 'High-Performer'
		 WHEN total_sales >=10000 THEN 'Mid-Range'
		 ELSE 'Low-Performer'
	END AS product_segemnt,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	-- Compute average order revenue (AOR)
	CASE WHEN total_orders = 0 THEN 0
		 ELSE total_sales / total_orders
	END AS avg_order_revenue,
	-- Compute average monthly revunue
	CASE WHEN lifespan = 0 THEN total_sales
		 ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregation

SELECT * FROM gold.report_product