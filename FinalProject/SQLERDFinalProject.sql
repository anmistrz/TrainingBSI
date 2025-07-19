CREATE TABLE Customer (
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	PhoneNumber VARCHAR(15),
	Address TEXT
)

CREATE TABLE Dealer (
	DealerID INT IDENTITY(1,1) PRIMARY KEY,
	DealerName VARCHAR(50) NOT NULL,
	Location TEXT NOT NULL,
	Province VARCHAR(40) NOT NULL,
	City VARCHAR(50) NOT NULL
)

CREATE TABLE Car (
	CarID INT IDENTITY(1,1) PRIMARY KEY,
	CarName VARCHAR(50) NOT NULL,
	CarModel VARCHAR(30) NOT NULL,
	CarType VARCHAR(20) NOT NULL,
	BasePrice INT NOT NULL
)

CREATE TABLE DealerCar (
	DealerCarID INT IDENTITY(1,1) PRIMARY KEY,
	DealerID INT NOT NULL,
	CarID INT NOT NULL,
	Stock INT NOT NULL,
	DealerPrice INT NOT NULL,
	Tax FLOAT,
	Status VARCHAR(15) CHECK (Status IN ('Available', 'Sold')) DEFAULT 'Available',

	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
)


CREATE TABLE SalesPerson (
	SalesPersonID INT IDENTITY(1,1) PRIMARY KEY,
	DealerID INT NOT NULL,
	FullName VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	Bonus INT,

	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID)
)

CREATE TABLE LetterOfIntent (
	LoiID INT IDENTITY(1,1) PRIMARY KEY,
	FixPrice INT NOT NULL,
	Discount FLOAT,
	DownPayment INT,
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


CREATE TABLE ConsultHistory (
	ConsultHistoryID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL,
	DealerID INT NOT NULL,
	SalesPersonID INT NOT NULL,
	Budget INT NOT NULL,
	ConsultDate DATETIME NOT NULL,
	Note Text,

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
)


CREATE TABLE TesDrive (
	TestDriveID INT IDENTITY(1,1) PRIMARY KEY,
	CarID INT NOT NULL,
	CustomerID INT NOT NULL,
	DealerID INT NOT NULL,
	SalesPersonID INT NOT NULL,
	Note TEXT,
	AppointmentDate DATETIME NOT NULL,

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID),
	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
)


CREATE TABLE Agreement (
	AgreementID INT IDENTITY(1,1) PRIMARY KEY,
	DealerCarID INT NOT NULL,
	CustomerID INT NOT NULL,
	SalesPersonID INT NOT NULL,
	LoiID INT UNIQUE NOT NULL,
	MethodPayment VARCHAR(10) CHECK (MethodPayment IN ('Credit', 'Cash')) DEFAULT 'Credit',
	BookingFee INT,
	AgreementDate DATETIME NOT NULL,

	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID),
	FOREIGN KEY (DealerCarID) REFERENCES DealerCar(DealerCarID),
	FOREIGN KEY (LoiID) REFERENCES LetterOfIntent(LoiID),
)


CREATE TABLE Purchase (
	PurchaseID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL,
	Nominal INT NOT NULL,
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
	ApprovalStatus VARCHAR(10) CHECK (ApprovalStatus IN ('Pending', 'Disetujui', 'Ditolak')) DEFAULT NULL,
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














