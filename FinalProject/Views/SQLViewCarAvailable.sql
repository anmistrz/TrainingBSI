CREATE VIEW vw_CarAvailable
AS
SELECT
    d.DealerID,
    d.DealerName,
    c.CarName,
    dc.Stock
    FROM Dealer d INNER JOIN DealerCar dc ON
    d.DealerID = dc.DealerID INNER JOIN Car c ON
    dc.CarID = c.CarID
    WHERE dc.Status = 'Available'
GO

SELECT * FROM vw_CarAvailable;