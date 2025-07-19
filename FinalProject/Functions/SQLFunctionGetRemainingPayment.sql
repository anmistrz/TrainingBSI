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
CREATE FUNCTION fn_GetRemainingPayment
(
	-- Add the parameters for the function here
	@PurchaseID INT
)
RETURNS  INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @TotalPaid INT;
	DECLARE @Nominal INT;
	DECLARE @Result INT;

	-- Add the T-SQL statements to compute the return value here
	SELECT @Nominal = Nominal FROM Purchase WHERE PurchaseID = @PurchaseID;
	SELECT @TotalPaid = ISNULL(SUM(PaymentNominal), 0) FROM PaymentHistory WHERE PurchaseID = @PurchaseID;

	SET @Result = @Nominal - @TotalPaid

	-- Return the result of the function
	RETURN @Result

END
GO

SELECT Nominal FROM Purchase;

SELECT dbo.fn_GetRemainingPayment(1);

