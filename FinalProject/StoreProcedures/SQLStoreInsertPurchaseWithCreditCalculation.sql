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
CREATE PROCEDURE sp_InsertPurchaseWithCreditCalculation
(
	@CustomerID INT,
	@AgreementID INT,
	@BasePrice INT,
	@DownPayment INT,
	@InterestRate FLOAT,
	@TimePeriod INT, 
	@Discount FLOAT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Hitung Total Amount = (hargaMobil + bunga flat)
	DECLARE @DiscountAmount FLOAT = @BasePrice * @Discount;
	DECLARE @AdjustedBasePrice INT = CAST(@BasePrice - @DiscountAmount AS INT);

	DECLARE @Principal INT = @AdjustedBasePrice - @DownPayment;
	DECLARE @TotalInterest FLOAT = @Principal * @InterestRate * (@TimePeriod / 12.0);
	DECLARE @TotalAmount INT = CAST(@Principal + @TotalInterest AS INT);
	DECLARE @MonthlyInstallment FLOAT = @TotalAmount / @TimePeriod;

	-- Insert data Purchase dengan nominal akhir
	INSERT INTO Purchase (CustomerID, AgreementID, Nominal, PaymentStatus, SubmissionDate)
	VALUES 
	(
		@CustomerID, 
		(SELECT TOP 1 AgreementID FROM Agreement WHERE CustomerID = @CustomerID ORDER BY AgreementDate DESC), 
		@TotalAmount, 
		'Belum Lunas', 
		GETDATE()
	)

	-- Ambil PurchaseID yang baru saja diinsert
	DECLARE @NewPurchaseID INT = SCOPE_IDENTITY();

	-- Insert data CreditApplication
	INSERT INTO CreditApplication (AgreementID, TimePeriod, InterestRate, InstallmentPerMonth, ApprovalStatus, ApprovalDate)
	VALUES 
	(
		-- Anda bisa sesuaikan AgreementID sesuai kebutuhan
		(SELECT TOP 1 AgreementID FROM Agreement WHERE CustomerID = @CustomerID ORDER BY AgreementDate DESC),
		@TimePeriod,
		@InterestRate,
		CAST(@MonthlyInstallment AS INT),
		'Pending',
		NULL
	);

	-- Output
	SELECT 
		@NewPurchaseID AS PurchaseID,
		@Principal AS Principal,
		@TotalInterest AS TotalInterest,
		@TotalAmount AS TotalAmount,
		@MonthlyInstallment AS MonthlyInstallment;
END;
GO