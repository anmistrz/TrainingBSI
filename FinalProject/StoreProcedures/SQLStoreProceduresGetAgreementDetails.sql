-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
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
CREATE PROCEDURE sp_GetAgreeementDetails
	-- Add the parameters for the stored procedure here
	@AgreementID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		A.AgreementID,
		C.FirstName + ' ' + C.LastName AS CustomerName,
		D.DealerName,
		DC.CarID,
		DC.Status,
		A.MethodPayment,
		A.BookingFee,
		A.AgreementDate
	FROM Agreement A
	JOIN Customer C ON A.CustomerID = C.CustomerID
	JOIN DealerCar DC ON A.DealerCarID = DC.DealerCarID
	JOIN Dealer D ON DC.DealerID = D.DealerID
	WHERE A.AgreementID = @AgreementID;
END
GO
