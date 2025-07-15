--Section 2
SELECT CONCAT(C.FirstName, ' ',C.MiddleName, ' ', C.LastName) As 'Customer Full Name',
A.OrderDate, A.TotalDue FROM SALES.Customer AS B INNER JOIN Person.Person AS C ON B.PersonID = C.BusinessEntityID INNER JOIN Sales.SalesOrderHeader AS A
ON A.CustomerID = B.CustomerID;

SELECT A.Name AS 'Product Name', B.Name AS 'Sub Category Name' FROM Production.Product AS A LEFT JOIN Production.ProductSubcategory AS B ON A.ProductSubcategoryID = B.ProductSubcategoryID;

SELECT CONCAT(B.FirstName, ' ',B.MiddleName, ' ', B.LastName) As 'Employee Name', A.JobTitle FROM HumanResources.Employee AS A LEFT JOIN Person.Person AS B
ON A.BusinessEntityID = B.BusinessEntityID;

SELECT CONCAT(C.FirstName,' ',C.MiddleName, ' ', C.LastName) As 'Salesperson Full Name', A.SalesOrderID, B.BusinessEntityID AS 'SalesPersonID' FROM Sales.SalesOrderHeader AS A
LEFT JOIN Sales.SalesPerson AS B ON B.BusinessEntityID = A.SalesPersonID LEFT JOIN Person.Person AS C ON C.BusinessEntityID = B.BusinessEntityID;


--Section 3
SELECT ProductLine, COUNT(ProductLine) AS 'Number of Products' FROM Production.Product GROUP BY ProductLine

SELECT ProductSubcategoryID, AVG(ListPrice) AS 'AVG List price' FROM Production.Product GROUP BY ProductSubcategoryID;

SELECT JobTitle, COUNT(BusinessEntityID) AS 'Total Employee' FROM HumanResources.Employee GROUP BY JobTitle; 

SELECT YEAR(OrderDate) AS 'Year', COUNT(OrderDate) AS 'Many Order' FROM Sales.SalesOrderHeader GROUP BY YEAR(OrderDate);


--Section 4
SELECT  CONCAT(C.FirstName,' ',C.MiddleName, ' ', C.LastName) As 'Full Name', SUM(A.TotalDue) AS 'Total Due' FROM
Sales.SalesOrderHeader AS A LEFT JOIN Sales.Customer AS B ON B.CustomerID = A.CustomerID LEFT JOIN Person.Person AS C
ON C.BusinessEntityID = B.PersonID GROUP BY CONCAT(C.FirstName,' ',C.MiddleName, ' ', C.LastName);

SELECT 
    CONCAT(C.FirstName,' ',C.MiddleName, ' ', C.LastName) AS 'Salesperson Full Name',
    B.BusinessEntityID AS 'SalesPersonID',
    COUNT(A.SalesOrderID) AS 'OrderCount'
FROM Sales.SalesOrderHeader AS A
INNER JOIN Sales.SalesPerson AS B ON B.BusinessEntityID = A.SalesPersonID
INNER JOIN Person.Person AS C ON C.BusinessEntityID = B.BusinessEntityID
GROUP BY 
    C.FirstName,
    C.MiddleName,
    C.LastName,
    A.SalesOrderID,
    B.BusinessEntityID;
    
SELECT YEAR(OrderDate) AS 'Year Date', AVG(TotalDue) AS 'AVG Order Amount' FROM Sales.SalesOrderHeader GROUP BY YEAR(OrderDate);

SELECT TOP 5 B.Name, SUM(A.OrderQty) AS 'Total Quantity Sold' FROM Sales.SalesOrderDetail AS A LEFT JOIN Production.Product AS B ON A.ProductID = B.ProductID GROUP BY A.OrderQty, B.Name ORDER BY [Total Quantity Sold] DESC;

SELECT B.Name, COUNT(A.ProductID) AS 'Number of Products' FROM Production.Product AS A 
LEFT JOIN Production.ProductSubCategory AS B 
ON A.ProductSubcategoryID = B.ProductSubCategoryID
WHERE A.ListPrice > 500 
GROUP BY B.Name

SELECT TOP 1 CONCAT(C.FirstName,' ',C.MiddleName, ' ', C.LastName) As 'Full Name', COUNT(A.SalesOrderID) AS 'Total Due' FROM
Sales.SalesOrderHeader AS A INNER JOIN Sales.SalesPerson AS B ON B.BusinessEntityID = A.SalesPersonID INNER JOIN Person.Person AS C
ON C.BusinessEntityID = B.BusinessEntityID GROUP BY CONCAT(C.FirstName,' ',C.MiddleName, ' ', C.LastName) ORDER BY [Total Due] DESC


