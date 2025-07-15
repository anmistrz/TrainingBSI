SELECT Name, ListPrice FROM Production.Product WHERE ListPrice > 1000;

SELECT * FROM HumanResources.Employee WHERE HireDate > '2012-01-01';

SELECT TOP 10 * FROM Production.Product ORDER BY ListPrice DESC;

SELECT Name FROM Production.Product WHERE Name LIKE 'B%';