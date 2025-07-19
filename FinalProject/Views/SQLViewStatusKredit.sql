CREATE VIEW vw_StatusKredit
AS
SELECT
    p.PurchaseID,
    a.AgreementID,
    CONCAT(c.FirstName, ' ', c.LastName) AS 'Full Name',
    a.MethodPayment,
    ca.PaymentMade,
    ca.TimePeriod,
    a.AgreementDate,
    CASE 
        WHEN a.MethodPayment = 'Cash' THEN 'Tidak Kredit'
        WHEN ca.PaymentMade >= ca.TimePeriod THEN 'Lunas'
        WHEN GETDATE() > DATEADD(MONTH, ca.TimePeriod, a.AgreementDate) THEN 'Tunggakan'
        ELSE 'Masih Berjalan'
    END AS CreditStatus
    FROM Purchase p
    INNER JOIN Agreement a ON p.AgreementID = a.AgreementID
    LEFT JOIN CreditApplication ca ON a.AgreementID = ca.AgreementID
    INNER JOIN Customer c ON c.CustomerID = a.CustomerID
    WHERE p.PurchaseID IS NOT NULL;
GO

SELECT * FROM vw_StatusKredit;
