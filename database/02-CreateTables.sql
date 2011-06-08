/*
 * ERP Data Integration
 * Table Definitions
 * SQL Server 2008/2012
 */

USE ERP_ETL;
GO

-- Main entity table
CREATE TABLE dbo.MainRecords (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    RecordCode VARCHAR(20) UNIQUE NOT NULL,
    RecordName VARCHAR(200) NOT NULL,
    Description VARCHAR(500),
    Status VARCHAR(20) DEFAULT 'Active',
    CreatedDate DATETIME DEFAULT GETDATE(),
    CreatedBy VARCHAR(50),
    ModifiedDate DATETIME DEFAULT GETDATE(),
    ModifiedBy VARCHAR(50),
    IsActive BIT DEFAULT 1
);

-- Audit log table
CREATE TABLE dbo.AuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    TableName VARCHAR(50) NOT NULL,
    RecordID INT NOT NULL,
    Action VARCHAR(20) NOT NULL,
    OldValue VARCHAR(MAX),
    NewValue VARCHAR(MAX),
    ChangedBy VARCHAR(50),
    ChangedDate DATETIME DEFAULT GETDATE()
);

-- Create indexes
CREATE INDEX IX_MainRecords_Status ON dbo.MainRecords(Status);
CREATE INDEX IX_MainRecords_CreatedDate ON dbo.MainRecords(CreatedDate);
CREATE INDEX IX_AuditLog_Date ON dbo.AuditLog(ChangedDate);

PRINT 'Tables created successfully for ERP_ETL';
GO
