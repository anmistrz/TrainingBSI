CREATE VIEW vw_FrequentCustomers
as
	SELECT 
		CONCAT(c.FirstName, ' ', c.MiddleName, ' ', c.LastName) AS 'Customer Name',
		COUNT(a.SalesOrderID) AS 'Order Count'
	FROM Sales.SalesOrderHeader a INNER JOIN Sales.Customer b ON
	a.CustomerID = b.CustomerID INNER JOIN Person.Person c ON
	b.CustomerID = c.BusinessEntityID
	GROUP BY CONCAT(c.FirstName, ' ', c.MiddleName, ' ', c.LastName)
	HAVING COUNT(a.SalesOrderID) > 3
go

SELECT * FROM  vw_FrequentCustomers;