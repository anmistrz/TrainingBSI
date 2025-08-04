CREATE TABLE Customer (
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	UserName VARCHAR(50) NOT NULL,
	Password VARCHAR(255),  -- diperpanjang untuk hashed password
	PhoneNumber VARCHAR(20),
	Email VARCHAR(100) NOT NULL UNIQUE,
	isGuest BIT NOT NULL DEFAULT 1,   
	Address VARCHAR(MAX),
	District VARCHAR(100),
	Province VARCHAR(50),
	CreatedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
	UpdatedAt DATETIME2 NULL
)

CREATE INDEX idx_Customer_UserName ON Customer(UserName);
CREATE NONCLUSTERED INDEX idx_Customer_Email ON Customer(Email);


CREATE TABLE Dealer (
	DealerID INT IDENTITY(1,1) PRIMARY KEY,
	DealerName VARCHAR(50) NOT NULL,
	Location VARCHAR(MAX) NOT NULL,
	Province VARCHAR(40) NOT NULL,
	City VARCHAR(50) NOT NULL,
	Address VARCHAR(MAX) NOT NULL,
	PhoneNumber VARCHAR(15),
	Email VARCHAR(100),
	CreatedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    	UpdatedAt DATETIME2 NULL
);

CREATE NONCLUSTERED INDEX idx_Dealer_DealerName ON Dealer(DealerName);

CREATE TABLE Car (
	CarID INT IDENTITY(1,1) PRIMARY KEY,
    	Make VARCHAR(30) NOT NULL,
    	CarModel VARCHAR(50) NOT NULL,
    	CarType VARCHAR(30) NOT NULL,
    	Year INT,
    	EngineSize VARCHAR(20),
    	FuelType VARCHAR(20),
    	Transmission VARCHAR(15),
    	Color VARCHAR(20),
   	BasePrice DECIMAL(15,2) NOT NULL,
	Description VARCHAR(MAX)
)

CREATE INDEX idx_Car_Make ON Car(Make);
CREATE INDEX idx_Car_CarModel ON Car(CarModel);
CREATE INDEX idx_Car_CarType ON Car(CarType);

CREATE TABLE DealerCar (
	DealerCarID INT IDENTITY(1,1) PRIMARY KEY,
	DealerID INT NOT NULL,
	CarID INT NOT NULL,
	Stock INT NOT NULL,
	DealerPrice DECIMAL(15,2) NOT NULL,
	Tax FLOAT,
	Status VARCHAR(15) CHECK (Status IN ('Available', 'Sold')) DEFAULT 'Available',

	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
)

CREATE TABLE DealerCarUnit (
    DealerCarUnitID INT IDENTITY(1,1) PRIMARY KEY,
    DealerCarID INT NOT NULL,
    VIN VARCHAR(50) UNIQUE NOT NULL,         -- Nomor identifikasi kendaraan unik
    Color VARCHAR(30) NULL,
    YearManufacture INT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Available', -- Status unit: Available, Sold, InService, Returned.
     AddedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    FOREIGN KEY (DealerCarID) REFERENCES DealerCar(DealerCarID)
);

CREATE UNIQUE INDEX IDX_DealerCarUnit_VIN ON DealerCarUnit(VIN);
CREATE INDEX IDX_DealerCarUnit_DealerCarID ON DealerCarUnit(DealerCarID);
CREATE INDEX IDX_DealerCarUnit_Status ON DealerCarUnit(Status);


CREATE TABLE SalesPerson (
	SalesPersonID INT IDENTITY(1,1) PRIMARY KEY,
	DealerID INT NOT NULL,
	FullName VARCHAR(50) NOT NULL,
	Email VARCHAR(100) NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	UserName VARCHAR(50) NOT NULL,
	Password VARCHAR(255) NOT NULL,  -- diperpanjang untuk hashed password
	Bonus INT,
	IsActive BIT NOT NULL DEFAULT 1,
	CreatedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    	UpdatedAt DATETIME2 NULL,

	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID)
)

CREATE INDEX IDX_SalesPerson_FullName ON SalesPerson(FullName);
CREATE UNIQUE INDEX ux_SalesPerson_Email_NotNull ON SalesPerson(Email) WHERE Email IS NOT NULL;
CREATE INDEX IDX_SalesPerson_PhoneNumber ON SalesPerson(PhoneNumber);
CREATE INDEX IDX_SalesPerson_DealerID ON SalesPerson(DealerID);
CREATE INDEX idx_SalesPerson_IsActive_True ON SalesPerson(IsActive) WHERE IsActive = 1;

CREATE TABLE SalesPersonPerformance (
    PerformanceID INT IDENTITY(1,1) PRIMARY KEY,
    SalesPersonID INT NOT NULL,
    MetricType VARCHAR(50) NOT NULL,    -- Contoh: 'TotalSales', 'TargetAchievement', dll
    MetricValue FLOAT NOT NULL,
    MetricDate DATE NOT NULL,
    Notes VARCHAR(MAX) NULL,
    
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
    CONSTRAINT UQ_SalesPersonPerformance_Metric UNIQUE (SalesPersonID, MetricType, MetricDate)
);

CREATE INDEX idx_SalesPersonPerformance_SalesPerson_Metric ON SalesPersonPerformance(SalesPersonID, MetricType, MetricDate);


CREATE TABLE TesDrive (
	TestDriveID INT IDENTITY(1,1) PRIMARY KEY,
	CarID INT NOT NULL,
	CustomerID INT NOT NULL,
	DealerID INT NOT NULL,
	SalesPersonID INT NOT NULL,
	Note TEXT,
	AppointmentDate DATETIME2 NOT NULL,

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
)
	
CREATE INDEX IDX_TestDrive_CustomerID ON TestDrive(CustomerID);
CREATE INDEX IDX_TestDrive_SalesPersonID ON TestDrive(SalesPersonID);
CREATE INDEX IDX_TestDrive_DealerID ON TestDrive(DealerID);
CREATE INDEX IDX_TestDrive_AppointmentDate ON TestDrive(AppointmentDate);


CREATE TABLE CustomerRating (
	RatingID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL,
	SalesPersonID INT NULL,
	DealerID INT NULL,
	ConsultHistoryID INT NULL,
	TestDriveID INT NULL,
	RatingType VARCHAR(50) NOT NULL,
	RatingValue INT NOT NULL,
	Comments VARCHAR(1000) NULL,
	RatingDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
	
   	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
    	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
    	FOREIGN KEY (ConsultHistoryID) REFERENCES ConsultHistory(ConsultHistoryID),
    	FOREIGN KEY (TestDriveID) REFERENCES TesDrive(TestDriveID),
);

CREATE INDEX IDX_CustomerRating_CustomerID ON CustomerRating(CustomerID);
CREATE INDEX IDX_CustomerRating_SalesPersonID ON CustomerRating(SalesPersonID);
CREATE INDEX IDX_CustomerRating_TestDriveID ON CustomerRating(TestDriveID);
CREATE INDEX IDX_CustomerRating_ConsultHistoryID ON CustomerRating(ConsultHistoryID);
CREATE INDEX IDX_CustomerRating_RatingDate ON CustomerRating(RatingDate);

CREATE TABLE ConsultHistory (
	ConsultHistoryID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT,
	DealerID INT NOT NULL,
	SalesPersonID INT,
	Budget DECIMAL(15,2),
	ConsultDate DATETIME2 NOT NULL,
	Note VARCHAR(MAX),

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
)

CREATE TABLE Notification (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NULL,
    DealerID INT NULL,
    SalesPersonID INT NULL,
    ConsultHistoryID INT NULL,
    TestDriveID INT NULL,
    NotificationType VARCHAR(50) NOT NULL,        -- Contoh: 'ConsultationRequest', 'TestDriveRequest'
    Message NVARCHAR(MAX) NOT NULL,                 -- Isi notifikasi
    IsRead BIT NOT NULL DEFAULT 0,
    Priority INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
    FOREIGN KEY (ConsultHistoryID) REFERENCES ConsultHistory(ConsultHistoryID),
    FOREIGN KEY (TestDriveID) REFERENCES TestDrive(TestDriveID)
);

CREATE TABLE SalesActivityLog (
    ActivityLogID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    DealerID INT NOT NULL,
    SalesPersonID INT NOT NULL,
    ActivityType VARCHAR(50) NOT NULL,      -- Contoh: 'ConsultRequest', 'TestDriveScheduled', 'FollowUpCall'
    RelatedNotificationID INT NULL,
    ActivityDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    Details NVARCHAR(MAX) NULL,

    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
    FOREIGN KEY (RelatedNotificationID) REFERENCES Notification(NotificationID)
);



--- beda proses bisnis ----	
CREATE TABLE LetterOfIntent (
	LoiID INT IDENTITY(1,1) PRIMARY KEY,
	FixPrice DECIMAL(15,2) NOT NULL,
	Discount FLOAT,
	DownPayment DECIMAL(15,2),
	Description Text
)


CREATE TABLE LoiCarFromDealer (
	LoiID INT NOT NULL,
	DealerCarID INT NOT NULL,
	TotalUnit INT NOT NULL,

	PRIMARY KEY (LoiID, DealerCarID),
	FOREIGN KEY (LoiID) REFERENCES LetterOfIntent(LoiID),
	FOREIGN KEY (DealerCarID) REFERENCES DealerCar(DealerCarID)
)


CREATE TABLE Agreement (
	AgreementID INT IDENTITY(1,1) PRIMARY KEY,
	DealerCarID INT NOT NULL,
	CustomerID INT NOT NULL,
	SalesPersonID INT NOT NULL,
	LoiID INT UNIQUE NOT NULL,
	MethodPayment VARCHAR(10) CHECK (MethodPayment IN ('Credit', 'Cash')) DEFAULT 'Credit',
	BookingFee DECIMAL(15,2),
	AgreementDate DATETIME NOT NULL,

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
	FOREIGN KEY (DealerCarID) REFERENCES DealerCar(DealerCarID),
	FOREIGN KEY (LoiID) REFERENCES LetterOfIntent(LoiID),
)


CREATE TABLE Purchase (
	PurchaseID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL,
	Nominal DECIMAL(15,2) NOT NULL,
	AgreementID INT UNIQUE NOT NULL,
	PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Lunas', 'Belum Lunas')) DEFAULT 'Belum Lunas',
	SubmissionDate DATETIME,

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (AgreementID) REFERENCES Agreement(AgreementID),

)


CREATE TABLE CreditApplication (
	CreditAppID INT IDENTITY(1,1) PRIMARY KEY,
	AgreementID INT UNIQUE NULL,
	TimePeriod INT,
	PaymentMade INT,
	InterestRate FLOAT,
	InstallmentPerMonth INT,
	ApprovalStatus VARCHAR(10) CHECK (ApprovalStatus IN ('Pending', 'Disetujui', 'Ditolak')) DEFAULT 'Pending',
	ApprovalDate DATETIME,

	FOREIGN KEY (AgreementID) REFERENCES Agreement(AgreementID)
)

CREATE TABLE DocumentCreditApplication (
	DocumentID INT IDENTITY(1,1) PRIMARY KEY,
	CreditAppID INT NOT NULL,
	DocType VARCHAR(10),
	File_Path VARCHAR(255),
	Date DATE,

	FOREIGN KEY (CreditAppID) REFERENCES CreditApplication(CreditAppID),
)

CREATE TABLE PaymentHistory (
	PaymentHistoryID INT IDENTITY(1,1) PRIMARY KEY,
	PurchaseID INT NOT NULL,
	PaymentNominal INT NOT NULL,
	PaymentType VARCHAR(20) NOT NULL,
	PaymentDate DATETIME NOT NULL,

	FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID),
)


CREATE TABLE WarrantyRegistration (
	WarrantyID INT IDENTITY(1,1) PRIMARY KEY,
	DealerCarID INT UNIQUE NOT NULL,
	PurchaseDate DATETIME NOT NULL,
	WarrantyPeriod INT NOT NULL,

	FOREIGN KEY (DealerCarID) REFERENCES DealerCar(DealerCarID)
)

CREATE TABLE WarrantyClaim (
	ClaimID INT IDENTITY(1,1) PRIMARY KEY,
	WarrantyID INT NOT NULL,
	CustomerID INT NOT NULL,
	ClaimStatus VARCHAR(10) CHECK (ClaimStatus IN ('Success', 'Failed')) DEFAULT NULL,
	CostCovered INT NOT NULL,
	Description TEXT,
	ClaimDate DATETIME NOT NULL,
	
	FOREIGN KEY (WarrantyID) REFERENCES WarrantyRegistration(WarrantyID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)














