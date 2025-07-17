--SECTION 5
CREATE TABLE Customer (
    customerID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(50) NOT NULL
)

CREATE TABLE Car (
    carID INT IDENTITY(1,1) PRIMARY KEY,
    carName NVARCHAR(50) NOT NULL,
    vin INT UNIQUE NOT NULL,
    purchaseDate DATE NOT NULL,
    warrantyPeriod INT NOT NULL,
    customerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

CREATE TABLE WarrantyRegistration (
    warrantyID INT IDENTITY(1,1) PRIMARY KEY,
    warrantyName NVARCHAR(50) NOT NULL,
    carID INT NOT NULL,
    FOREIGN KEY (carID) REFERENCES Car(carID)
)

CREATE TABLE WarrantyClaim (
    claimID INT IDENTITY(1,1) PRIMARY KEY,
    warrantyID INT NOT NULL,
    issueReported NVARCHAR(1000) NOT NULL,
    serviceCenter NVARCHAR(150),
    repairDate DATE NOT NULL,
    claimStatus NVARCHAR(10) NOT NULL,
    FOREIGN KEY (warrantyID) REFERENCES WarrantyRegistration(warrantyID)
);

