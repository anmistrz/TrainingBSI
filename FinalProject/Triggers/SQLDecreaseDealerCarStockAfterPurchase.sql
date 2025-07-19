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
CREATE TRIGGER trg_DecreaseDealerCarStockAfterPurchase
ON Purchase
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE DC
    SET DC.Stock = DC.Stock - 1
    FROM DealerCar DC
    INNER JOIN Agreement A ON DC.DealerCarID = A.DealerCarID
    INNER JOIN inserted I ON A.AgreementID = I.AgreementID
    WHERE DC.Stock > 0;  
END;
GO

--INSERT INTO LetterOfIntent (FixPrice, Discount, DownPayment, Description)
--VALUES
--(820000000, 0.06, 40000000, 'LOI untuk pembelian Dummy Mobile 5');


--INSERT INTO Agreement (CustomerID, DealerCarID ,SalesPersonID, LoiID, MethodPayment, BookingFee, AgreementDate)
--VALUES
--(4, 3, 3, 8, 'Credit', 3000000, GETDATE());

--SELECT * FROM Agreement

--SELECT * FROM DealerCar;

--INSERT INTO Purchase (CustomerID, Nominal, AgreementID, PaymentStatus, SubmissionDate)
--VALUES
--(4, 2200000, 15, 'Belum Lunas', GETDATE());

--SELECT * FROM DealerCar;