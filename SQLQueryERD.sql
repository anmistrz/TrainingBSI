--Section 1
CREATE TABLE CarModel (
    carModelID INT IDENTITY(1,1) PRIMARY KEY,
    modelName NVARCHAR(50) NOT NULL,
    manufacturer NVARCHAR(50) NOT NULL,
    Year INT NOT NULL
);

CREATE TABLE PrototypeVehicle (
    prototypeID INT IDENTITY(1,1) PRIMARY KEY,
    prototypeNumber NVARCHAR(20) NOT NULL UNIQUE,
    prototypeName NVARCHAR(50) NOT NULL,
    carModelID INT NOT NULL,
    buildDate DATE,
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



--SECTION 2
CREATE TABLE Employee (
    employeeID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(50) NOT NULL,
    email NVARCHAR(50) UNIQUE NOT NULL,
    department NVARCHAR(100)
);

CREATE TABLE TrainingCourse (
    courseID INT IDENTITY(1,1) PRIMARY KEY,
    courseName NVARCHAR(50) NOT NULL,
    description TEXT,
    duration int NOT NULL
);

CREATE TABLE Instructor (
    InstructorID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
);

CREATE TABLE TrainingSession (
    sessionID INT IDENTITY(1,1) PRIMARY KEY,
    courseID INT NOT NULL,
    instructorID INT NOT NULL,
    sessionDate DATETIME NOT NULL,
    location NVARCHAR(30),
    FOREIGN KEY (courseID) REFERENCES TrainingCourse(courseID),
    FOREIGN KEY (instructorID) REFERENCES Instructor(instructorID)
);

CREATE TABLE ParticipationRecord (
    participationID INT IDENTITY(1,1) PRIMARY KEY,
    employeeID INT NOT NULL,
    sessionID INT NOT NULL,
    attendanceStatus NVARCHAR(10) NOT NULL,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
    FOREIGN KEY (sessionID) REFERENCES TrainingSession(sessionID)
)



--SECTION 3
CREATE TABLE PartCategory (
    categoryID INT IDENTITY(1,1) PRIMARY KEY,
    categoryName NVARCHAR(50) NOT NULL,
    descriptions TEXT,
)

CREATE TABLE Supplier (
    supplierID INT IDENTITY(1,1) PRIMARY KEY,
    supplierName NVARCHAR(50) NOT NULL,
    location TEXT,
    province NVARCHAR(30),
    city NVARCHAR(50),
    phoneNumber NVARCHAR(15),
)

CREATE TABLE Part (
    partID INT IDENTITY(1,1) PRIMARY KEY,
    partNumber INT UNIQUE,
    partName NVARCHAR(50) NOT NULL,
    categoryID INT NOT NULL,

    FOREIGN KEY (categoryID) REFERENCES PartCategory(categoryID)
)

CREATE TABLE SupplierPartOffer (
    supplierID INT NOT NULL,
    partID INT NOT NULL,
    unitPrice float NOT NULL,
    leadTimeDays INT NOT NULL,
    rating TINYINT NOT NULL,

    PRIMARY KEY (supplierID, partID),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID),
    FOREIGN KEY (partID) REFERENCES Part(partID)
 )


    







