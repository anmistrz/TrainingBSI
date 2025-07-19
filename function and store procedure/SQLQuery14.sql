-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
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
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION ufnGetProductTotal
(
	-- Add the parameters for the function here
	@productNumber varchar(25)
)
RETURNS [int]
AS
BEGIN
	-- Declare the return variable here
	DECLARE @hasil int

	-- Add the T-SQL statements to compute the return value here
	SET @hasil = (SELECT COUNT(productid) FROM Production.Product
				   WHERE ProductNumber=@productNumber)

	-- Return the result of the function
	RETURN @hasil

END
GO


SELECT * FROM Production.Product

SELECT dbo.ufnGetProductTotal('CA-5965') AS Total
