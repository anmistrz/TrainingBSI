CREATE VIEW vw_SalesOrderSummary
as
	SELECT
		a.Name,
		b.Name as 'Sub Cataeogry Name',
		a.ListPrice
	FROM Production.Product a INNER JOIN Production.ProductSubcategory b ON
	a.ProductSubcategoryID = b.ProductSubcategoryID 
	WHERE a.ListPrice > 0
		
go

SELECT * FROM  vw_SalesOrderSummary;