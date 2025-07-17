CREATE VIEW vwProductDemo
as
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    p.ListPrice,
    p.ModifiedDate
FROM 
    Production.Product p
JOIN 
    Production.ProductSubcategory pc ON p.ProductSubcategoryID = pc.ProductCategoryID;
go

ALTER VIEW vwProductDemo
as
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    p.ListPrice
FROM 
    Production.Product p
JOIN 
    Production.ProductSubcategory pc ON p.ProductSubcategoryID = pc.ProductCategoryID;
go

select * from vwProductDemo