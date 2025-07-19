-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER trgEmployee
   ON  Employee
   AFTER INSERT, DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO EmployeeAudit(
        empid,
        status,
        created
    )
    SELECT
        i.id,
        'inserted',        
        GETDATE()
    FROM
        inserted i
    UNION ALL
    SELECT
		d.id,
        'deleted',        
        GETDATE()
    FROM
        deleted d;
END
GO


select * from EmployeeAudit
select * from Employee

insert into Employee(id,first_name,last_name,email,created) 
values(1,'user test ','2','usertest1@email.com',getdate()) 
insert into Employee(id,first_name,last_name,email,created) 
values(2,'user test ','22','usertest1@email.com',getdate())

delete from Employee where id = 1;


