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
CREATE FUNCTION fn_CalculationLOIDiscount
(
	-- Add the parameters for the function here
	@LoiID INT
)
RETURNS FLOAT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FixPrice INT;
	DECLARE @Discount FLOAT;
	DECLARE @DiscountValue FLOAT;

	-- Add the T-SQL statements to compute the return value here
	SELECT @FixPrice = FixPrice, @Discount = Discount FROM LetterOfIntent WHERE LoiID = @LoiID

	SET @DiscountValue = @FixPrice * @Discount

	-- Return the result of the function
	RETURN @DiscountValue;

END
GO

SELECT * FROM LetterOfIntent

SELECT dbo.fn_CalculationLOIDiscount(1) AS 'Nominal LOI After Discount'
