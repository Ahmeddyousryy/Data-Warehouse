/*
========================================================================

Create Database and Schemas

========================================================================

Script Purpose:
	This script creates a new database named 'DataWarehouse' after checking if it already exists.
	If the database exists, it will be dropped and recreated. Additionally, the script sets up
	three schemas within the database: 'bronze', 'silver', 'gold'.

*/


USE master;

GO

-- Check if there exists database with the same name and drop it
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	DROP DATABASE DataWarehouse;
END

GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;

GO 

-- Use that newely created database
USE DataWarehouse;

GO

-- Create database schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
