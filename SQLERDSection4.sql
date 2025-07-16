--SECTION 4
CREATE TABLE Customer (
    customerID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(50) NOT NULL,
    phoneNumber NVARCHAR(15) NOT NULL,
    address TEXT,
)

CREATE TABLE RentalBranch (
    branchID INT IDENTITY(1,1) PRIMARY KEY,
    branchName NVARCHAR(50) NOT NULL,
    province NVARCHAR(30) NOT NULL,
    city NVARCHAR(50) NOT NULL,
    phoneNumber NVARCHAR(15) NOT NULL,
    address TEXT,
)

CREATE TABLE Employee (
    employeeID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(50) NOT NULL,
    phoneNumber NVARCHAR(15) NOT NULL,
    address TEXT,
    branchID INT NOT NULL,

    FOREIGN KEY (branchID) REFERENCES RentalBranch(branchID)
)

CREATE TABLE Vehicle (
    vehicleID INT IDENTITY(1,1) PRIMARY KEY,
    vehicleName NVARCHAR(50) NOT NULL,
    vehicleType NVARCHAR(30)  NOT NULL,
    vehicleStatus NVARCHAR(10) NOT NULL,
    mileage FLOAT NOT NULL,
    rentalHistory DATE,
    branchID INT NOT NULL,

    FOREIGN KEY (branchID) REFERENCES RentalBranch(branchID)
)

CREATE TABLE RentalContract (
    contractID INT IDENTITY(1,1) PRIMARY KEY,
    vehicleID INT NOT NULL,
    customerID INT NOT NULL,
    employeeID INT NOT NULL,               
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    totalDays AS DATEDIFF(DAY, StartDate, EndDate) PERSISTED,
    dailyRate DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);
