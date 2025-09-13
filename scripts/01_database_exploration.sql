/*
===========================================================================================
DDL Script: Database Exploration
===========================================================================================

Script Purpose: 
    This script explores the database to understand its structure.
    It inspects tables, columns, and specific schemas to prepare for further development.

Usage:
    - Use this script to get metadata about tables and columns.
    - Helps identify available data sources before transformation.
==============================================================================================
*/

-- ===========================================================================================
-- Step 1: Explore all objects (tables, views) in the database
-- ===========================================================================================
SELECT * FROM INFORMATION_SCHEMA.TABLES

  -- =========================================================================================
-- Step 2: Explore all columns for all tables
-- ===========================================================================================
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

-- ===========================================================================================
-- Step 3: Inspect columns for a specific table (dim_customers in this case)
-- ===========================================================================================
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'


