CREATE VIEW vw_CustomerPurchaseSummary 
AS
SELECT
    p.PurchaseID,
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    d.DealerName,
    car.CarName,
    car.CarModel,
    dc.DealerPrice,
    loi.Discount,
    loi.DownPayment,
    ca.TimePeriod AS CreditPeriodMonths,
    ca.InterestRate,
    p.Nominal AS TotalAmountDue,
    p.PaymentStatus,
    a.MethodPayment,
    p.SubmissionDate
    FROM Purchase p
    INNER JOIN Agreement a ON p.AgreementID = a.AgreementID
    INNER JOIN Customer c ON p.CustomerID = c.CustomerID
    INNER JOIN DealerCar dc ON a.DealerCarID = dc.DealerCarID
    INNER JOIN Car car ON dc.CarID = car.CarID
    INNER JOIN Dealer d ON dc.DealerID = d.DealerID
    INNER JOIN LetterOfIntent loi ON a.LoiID = loi.LoiID
    LEFT JOIN CreditApplication ca ON a.AgreementID = ca.AgreementID;
GO

SELECT * FROM vw_CustomerPurchaseSummary;


