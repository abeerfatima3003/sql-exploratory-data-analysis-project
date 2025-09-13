/*
==============================================================================================
Dimensions Exploration
==============================================================================================

Script Purpose: 
    Identifying unique values in each dimension
    Recognizing how data might be grouped/ segmented.
    This script explores the dimension tables in the Gold Layer to understand 
    available attributes such as customers, countries, product categories, and subcategories.

    Dimension exploration helps analysts verify data coverage, identify potential 
    hierarchies, and prepare for building meaningful business insights.

Usage:
    - Helps in understanding the geographic distribution of customers and product classification.
    - Useful for later analysis
==============================================================================================
*/

-- ==============================================================================================
-- Step 1: Explore DISTINCT countries of customers
-- ==============================================================================================
SELECT DISTINCT
country 
FROM gold.dim_customers

-- ==============================================================================================
-- Step 2: Explore DISTINCT product categories (The Major Divisions)
-- ==============================================================================================
SELECT DISTINCT 
category
FROM gold.dim_products

-- ==============================================================================================
-- Step 3: Drill down into product hierarchy
-- ==============================================================================================
SELECT DISTINCT
category, sub_category, product_name
FROM gold.dim_products 

ORDER BY 1,2,3
