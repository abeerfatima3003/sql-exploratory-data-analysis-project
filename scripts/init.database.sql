/*
==========================================================
Creating Database and Schemas
==========================================================
Script Purpose:
This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database already exists, it is dropped and recreated. 
Additionally, the script sets up three schemas within the database: 'bronze', 'silver' and 'gold'.

WARNING:
Running this script will drop the entire 'DataWarehouse' database if it exists. 
All data in the database will be permanently deleted.
Proceed with caution and ensure you have proper backups before running this script.
*/


-- This database is used to create other databases
USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Creating a new database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Creating Schemas for each layer
CREATE SCHEMA bronze;

-- GO is used so that we don't get errors when executing 2 or more codes
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
