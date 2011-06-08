/*
 * ERP Data Integration
 * Stored Procedures
 * SQL Server 2008/2012
 */

USE ERP_ETL;
GO

-- Get all records
CREATE PROCEDURE dbo.usp_GetAllRecords
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM dbo.MainRecords WHERE IsActive = 1 ORDER BY RecordName;
END
GO

-- Get record by ID
CREATE PROCEDURE dbo.usp_GetRecordByID
    @RecordID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM dbo.MainRecords WHERE RecordID = @RecordID;
END
GO

-- Insert new record
CREATE PROCEDURE dbo.usp_InsertRecord
    @RecordCode VARCHAR(20),
    @RecordName VARCHAR(200),
    @Description VARCHAR(500),
    @CreatedBy VARCHAR(50),
    @RecordID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO dbo.MainRecords (RecordCode, RecordName, Description, CreatedBy)
        VALUES (@RecordCode, @RecordName, @Description, @CreatedBy);
        
        SET @RecordID = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
        RETURN 0;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN -1;
    END CATCH
END
GO

PRINT 'Stored procedures created successfully';
GO
