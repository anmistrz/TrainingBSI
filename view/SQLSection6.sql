CREATE VIEW vw_SalespersonPerformance
as
	SELECT 
		CONCAT(c.FirstName, ' ', c.MiddleName, ' ', c.LastName) AS 'Customer Name',
		SUM(a.totalDue) AS 'Total Sales Amount',
		COUNT(a.SalesOrderID) AS 'Order Count'
	FROM Sales.SalesOrderHeader a INNER JOIN Sales.SalesPerson b ON
	a.SalesPersonID = b.BusinessEntityID INNER JOIN Person.Person c ON
	b.BusinessEntityID = c.BusinessEntityID
	WHERE a.SalesPersonID IS NOT NULL
	GROUP BY CONCAT(c.FirstName, ' ', c.MiddleName, ' ', c.LastName)
		
go

SELECT * FROM  vw_SalespersonPerformance;