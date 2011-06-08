/*
 * ERP Data Integration
 * Project #78 - Complete Database Implementation
 * SQL Server 2008/2012
 * Technology: SSIS
 * Created: 2013
 */

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ERP_ETL')
BEGIN
    ALTER DATABASE ERP_ETL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ERP_ETL;
END
GO

CREATE DATABASE ERP_ETL
ON PRIMARY
(
    NAME = 'ERP_ETL_Data',
    FILENAME = 'C:\SQLData\ERP_ETL_Data.mdf',
    SIZE = 100MB,
    MAXSIZE = 5GB,
    FILEGROWTH = 10MB
)
LOG ON
(
    NAME = 'ERP_ETL_Log',
    FILENAME = 'C:\SQLData\ERP_ETL_Log.ldf',
    SIZE = 50MB,
    MAXSIZE = 1GB,
    FILEGROWTH = 5MB
);
GO

ALTER DATABASE ERP_ETL SET RECOVERY SIMPLE;
ALTER DATABASE ERP_ETL SET AUTO_UPDATE_STATISTICS ON;
GO

USE ERP_ETL;
GO

PRINT 'Database ERP_ETL created successfully';
PRINT 'Project: ERP Data Integration';
PRINT 'Description: ERP modules to DWH integration';
GO
