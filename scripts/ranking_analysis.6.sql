-- Which 5 Products generate the highest revenue?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- Using Window Function
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

--What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY product_name
ORDER BY total_sales ASC

-- Find the top 10 customers who have generated the highest revenue
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

-- Top 3 customers with the fewest orders placed
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




