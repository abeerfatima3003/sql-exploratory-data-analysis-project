-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity
FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(price) AS avg_price
FROM gold.fact_sales

-- Find the total number of orders
SELECT COUNT(order_number) AS total_orders
FROM gold.fact_sales
-- Checking for duplicates
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales

-- Find the total number of Products
SELECT COUNT(product_key) AS total_products
FROM gold.dim_products
-- Checking for duplicates
SELECT COUNT(DISTINCT product_key) AS total_products
FROM gold.dim_products -- NO DUPLICATES ( can go with product_name as well)

-- Find the total number of Customers
SELECT COUNT(customer_id) AS total_customers
FROM gold.dim_customers
-- Checking for duplicates
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers;

-- Find the total number of Customers who have placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers_orders
FROM gold.fact_sales;


--Generating a Report that shows all kew metrics of the business
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
