/*
 * ERP Data Integration
 * Triggers
 * SQL Server 2008/2012
 */

USE ERP_ETL;
GO

-- Audit trigger
CREATE TRIGGER trg_AuditMainRecords
ON dbo.MainRecords
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO dbo.AuditLog (TableName, RecordID, Action, NewValue, ChangedBy)
        SELECT 'MainRecords', RecordID, 'INSERT', RecordName, CreatedBy
        FROM inserted;
    END
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO dbo.AuditLog (TableName, RecordID, Action, OldValue, NewValue, ChangedBy)
        SELECT 'MainRecords', i.RecordID, 'UPDATE', d.RecordName, i.RecordName, i.ModifiedBy
        FROM inserted i
        INNER JOIN deleted d ON i.RecordID = d.RecordID;
    END
    
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO dbo.AuditLog (TableName, RecordID, Action, OldValue, ChangedBy)
        SELECT 'MainRecords', RecordID, 'DELETE', RecordName, ModifiedBy
        FROM deleted;
    END
END
GO

PRINT 'Triggers created successfully';
GO
