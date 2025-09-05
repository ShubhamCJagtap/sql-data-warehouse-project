/*
=================================
Create Database and Schema
=================================
Script Purppose : This script creates a new databse 'DataWarehouse' after checking if it already exists. 
If ths database exists, it will be dropped and recreated. Additionally, it will set 3 schemas bronze, silver and gold.
*/

USE master;
GO

if EXISTS (select 1 from sys.databases WHERE name = 'DataWarehouse')
BEGIN	
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


create database DataWarehouse;
GO
USE DataWarehouse;
GO

Create schema bronze;
GO
Create schema silver;
GO
Create schema gold;
GO