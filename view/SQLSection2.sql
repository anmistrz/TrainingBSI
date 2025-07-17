CREATE VIEW vw_EmployeeDirectory
as
	SELECT CONCAT(a.FirstName, ' ', a.MiddleName, ' ', a.LastName) AS 'FullName',
	b.JobTitle ,
	c.EmailAddress
	FROM Person.Person a INNER JOIN HumanResources.Employee b ON
	a.BusinessEntityID = b.BusinessEntityID INNER JOIN Person.EmailAddress c ON
		b.BusinessEntityID = c.BusinessEntityID WHERE b.CurrentFlag = 1
go

SELECT * FROM  vw_EmployeeDirectory;