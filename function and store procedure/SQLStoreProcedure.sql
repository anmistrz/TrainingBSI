USE [AdventureWorks2022]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[uspGetPersonByType]
		@personType = N'SC'

SELECT	'Return Value' = @return_value

GO

EXEC uspGetPersonByType 'SC'