CREATE VIEW vw_ActiveProductCatalog
as
	SELECT Name, ProductNumber, ListPrice, SellStartDate 
	FROM Production.Product
	WHERE SellEndDate IS NULL
go

SELECT * FROM vw_ActiveProductCatalog;
