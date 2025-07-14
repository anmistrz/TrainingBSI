--select db
use master
go

use TrainingDB
go

--create db
create database Demo01
go

create database Demo02
go
create database Demo03
go

--delete db
drop database Demo01
--go

------ sys database
--select name from sys.databases
--if not exists(select name from sys.databases where name = 'Demo01')
--begin
--	create database Demo01;
--end

--use TrainingDB
--go

--create table Customer(
--	Id int identity(1,1) primary key,
--	Name varchar(50) not null,
--	Email varchar(30)
--)
--go

use TrainingDB;

CREATE TABLE Plant (
	idPlant int identity(1,1) primary key,
	plantName varchar(60) NOT NULL,
	totalArea float NOT NULL,
	email varchar(30),
	phoneNumber varchar(15),
	startedYear int,
)

CREATE TABLE CarModel (
	idCarModel int identity(1,1) primary key,
	modelName varchar(60) NOT NULL,
	modelType varchar(60) NOT NULL,
	engineCapacity float NOT NULL,
	modelYear int NOT NULL,
	fuelType varchar(10) NOT NULL,
)


CREATE TABLE ProductionPlan (
	idProductionPlan int identity(1,1) primary key,
	ProductionPlanName varchar(60) NOT NULL,
	productionDate varchar(15) NOT NULL,
	unit int NOT NULL,
	notes text,
)

CREATE TABLE Dealer (
	idDealer int identity(1,1) primary key,
	dealerName varchar(50) NOT NULL,
	city varchar(30) NOT NULL,
	province varchar(30) NOT NULL,
	phoneNumber varchar(15),
	startedYear int NOT NULL,
)

CREATE TABLE CarSale (
	idSale int identity(1,1) primary key,
	fullName varchar(50) NOT NULL,
	--carModel varchar(30) NOT NULL,
	idCarModel int NOT NULL,
	price float NOT NULL,
	unitSold int NOT NULL,
	paidType varchar(10) NOT NULL,
	dateSale date NOT NULL
	constraint fk_CarSale_CarModel foreign key (idCarModel) references CarModel(idCarModel)
)
		

CREATE TABLE MaintenanceLog (
	idMaintenance int identity(1,1) primary key,
	idCarModel int NOT NULL,
	customerName varchar(50) NOT NULL,
	--carModel varchar(30) NOT NULL,
	dateService date NOT NULL,
	serviceType varchar(30) NOT NULL,
	serviceCenterName varchar(50) NOT NULL,
	constraint fk_MaintenanceLog_CarModel foreign key (idCarModel) references CarModel(idCarModel)
)

CREATE TABLE PartInventory (
	idInventory int identity(1,1) primary key,
	partName varchar(50) NOT NULL,
	partNumber int NOT NULL,
	partCategory varchar(30) NOT NULL,
	stock int NOT NULL,
	unitPrice float NOT NULL,
	isActive bit,
)

CREATE TABLE CustomerFeedback (
	idFeedback int identity(1,1) primary key,
	idCarModel int NOT NULL,
	customerName varchar(50) NOT NULL,
	--carModel varchar(30) NOT NULL,
	dateFeedback date NOT NULL,
	rating int,
	comments text,
	constraint fk_CustomerFeedback_CarModel foreign key (idCarModel) references CarModel(idCarModel)
)

