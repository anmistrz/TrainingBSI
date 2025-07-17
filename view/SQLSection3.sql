CREATE VIEW vw_SalesOrderSummary
as
	SELECT 
		a.SalesOrderID, 
		a.OrderDate,
		CONCAT(c.FirstName, ' ', c.MiddleName, ' ', c.LastName) AS 'Customer Name',
		a.TotalDue
	FROM Sales.SalesOrderHeader a INNER JOIN Sales.Customer b ON
	a.CustomerID = b.CustomerID INNER JOIN Person.Person c ON
	b.CustomerID = c.BusinessEntityID
		
go

SELECT * FROM  vw_SalesOrderSummary;