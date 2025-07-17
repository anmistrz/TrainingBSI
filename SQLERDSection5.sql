--SECTION 5
CREATE TABLE Customer (
    customerID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(50) NOT NULL
)

CREATE TABLE Car (
    vin INT IDENTITY(1,1) PRIMARY KEY,
    purchaseDate DATE NOT NULL,
    warrantyPeriod INT NOT NULL,
    customerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

CREATE TABLE WarrantyRegistration (
    warrantyID INT IDENTITY(1,1) PRIMARY KEY,
    vin INT UNIQUE NOT NULL,
    warrantyName NVARCHAR(50) NOT NULL,
    FOREIGN KEY (vin) REFERENCES Car(vin)
)

CREATE TABLE WarrantyClaim (
    claimID INT IDENTITY(1,1) PRIMARY KEY,
    warrantyID INT NOT NULL,
    description TEXT NOT NULL,
    serviceCenter NVARCHAR(150),
    repairDate DATE NOT NULL,
    claimStatus NVARCHAR(10) NOT NULL,
    FOREIGN KEY (warrantyID) REFERENCES WarrantyRegistration(warrantyID)
);

