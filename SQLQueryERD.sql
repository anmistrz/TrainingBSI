--Section 1

CREATE TABLE CarModel (
    CarModelID INT IDENTITY(1,1) PRIMARY KEY,
    ModelName NVARCHAR(50) NOT NULL,
    Manufacturer NVARCHAR(50) NOT NULL,
    Year INT NOT NULL
);

CREATE TABLE PrototypeVehicle (
    prototypeID INT IDENTITY(1,1) PRIMARY KEY,
    prototypeNumber NVARCHAR(20) NOT NULL UNIQUE,
    prototypeName NVARCHAR(50) NOT NULL,
    CarModelID INT NOT NULL,
    BuildDate DATE,
    FOREIGN KEY (CarModelID) REFERENCES CarModel(CarModelID)
);

CREATE TABLE TestEngineer (
    engineerID INT IDENTITY(1,1) PRIMARY KEY,
    firstName NVARCHAR(20) NOT NULL,
    lastName NVARCHAR(20) NOT NULL,
    email NVARCHAR(20) NOT NULL,
    department NVARCHAR(30) NOT NULL,
)

CREATE TABLE TestLocation (
    locationID INT IDENTITY(1,1) PRIMARY KEY,
    locationName NVARCHAR(50) NOT NULL,
    country NVARCHAR(50) NOT NULL,
    province NVARCHAR(30) NOT NULL,
    city NVARCHAR(50) NOT NULL
);

CREATE TABLE VehicleTest (
    testID INT IDENTITY(1,1) PRIMARY KEY,
    prototypeID INT NOT NULL,
    engineerID INT NOT NULL,
    locationID INT NOT NULL,
    testDate DATE NOT NULL,
    testType NVARCHAR(100),
    result TEXT,
    FOREIGN KEY (prototypeID) REFERENCES PrototypeVehicle(prototypeID),
    FOREIGN KEY (engineerID) REFERENCES TestEngineer(engineerID),
    FOREIGN KEY (locationID) REFERENCES TestLocation(locationID)
);








