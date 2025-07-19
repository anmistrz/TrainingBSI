-- Dummy data for Customer
INSERT INTO Customer (FirstName, LastName, PhoneNumber, Address)
VALUES
('Andi', 'Saputra', '081234567890', 'Jl. Melati No.5, Jakarta'),
('Budi', 'Santoso', '082345678901', 'Jl. Kenanga No.10, Bandung'),
('Citra', 'Ningsih', '083456789012', 'Jl. Mawar No.8, Surabaya');

-- Dummy data for Dealer
INSERT INTO Dealer (DealerName, Location, Province, City)
VALUES
('AutoMart Jakarta', 'Jl. Sudirman Kav 45', 'DKI Jakarta', 'Jakarta'),
('Speedy Motors Bandung', 'Jl. Asia Afrika 123', 'Jawa Barat', 'Bandung'),
('TransAuto Surabaya', 'Jl. Pemuda 78', 'Jawa Timur', 'Surabaya');

-- Dummy data for Car
INSERT INTO Car (CarName, CarModel, CarType, BasePrice)
VALUES
('Toyota Avanza', '2025', 'MPV', 200000000),
('Honda Civic', '2024', 'Sedan', 350000000),
('Suzuki Ertiga', '2023', 'MPV', 220000000);

-- Dummy data for DealerCar
INSERT INTO DealerCar (DealerID, CarID, Stock, DealerPrice, Tax, Status)
VALUES
(1, 1, 10, 210000000, 0.10, 'Available'),
(2, 2, 5, 360000000, 0.12, 'Available'),
(3, 3, 7, 230000000, 0.11, 'Available');

-- Dummy data for SalesPerson
INSERT INTO SalesPerson (DealerID, FullName, PhoneNumber, Bonus)
VALUES
(1, 'Rian Wijaya', '081122334455', 2000000),
(2, 'Sari Dewi', '082233445566', 1800000),
(3, 'Dedi Prasetyo', '083344556677', 2100000);

-- Dummy data for LetterOfIntent
INSERT INTO LetterOfIntent (FixPrice, Discount, DownPayment, Description)
VALUES
(210000000, 0.05, 50000000, 'LOI untuk pembelian Avanza di AutoMart Jakarta'),
(360000000, 0.07, 80000000, 'LOI untuk pembelian Civic di Speedy Motors Bandung'),
(230000000, 0.03, 60000000, 'LOI untuk pembelian Ertiga di TransAuto Surabaya');

-- Dummy data for LoiCarFromDealer
INSERT INTO LoiCarFromDealer (LoiID, DealerCarID, totalUnit)
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3);

-- Dummy data for ConsultHistory
INSERT INTO ConsultHistory (CustomerID, DealerID, SalesPersonID, Budget, ConsultDate, Note)
VALUES
(1, 1, 1, 250000000, '2025-01-05 10:00:00', 'Konsultasi awal pembelian Avanza'),
(2, 2, 2, 400000000, '2025-02-10 13:30:00', 'Konsultasi pembelian Civic'),
(3, 3, 3, 260000000, '2025-03-15 15:45:00', 'Konsultasi Ertiga');

-- Dummy data for TesDrive
INSERT INTO TesDrive (CarID, CustomerID, DealerID, SalesPersonID, Note, AppointmentDate)
VALUES
(1, 1, 1, 1, 'Test drive berjalan lancar', '2025-01-07 09:00:00'),
(2, 2, 2, 2, 'Customer tertarik setelah test drive', '2025-02-12 14:00:00'),
(3, 3, 3, 3, 'Test drive sukses, ada follow up', '2025-03-20 10:30:00');

-- Dummy data for Agreement
INSERT INTO Agreement (DealerCarID, CustomerID, SalesPersonID, LoiID, MethodPayment, BookingFee, AgreementDate)
VALUES
(1, 1, 1, 1, 'Credit', 20000000, '2025-01-10 08:00:00'),
(2, 2, 2, 2, 'Cash', 10000000, '2025-02-15 11:00:00'),
(3, 3, 3, 3, 'Credit', 15000000, '2025-03-25 16:15:00');

-- Dummy data for Purchase
INSERT INTO Purchase (CustomerID, Nominal, AgreementID, PaymentStatus, SubmissionDate)
VALUES
(1, 190000000, 1, 'Belum Lunas', '2025-01-11 10:00:00'),
(2, 360000000, 2, 'Lunas', '2025-02-16 12:00:00'),
(3, 220000000, 3, 'Belum Lunas', '2025-03-27 17:00:00');

-- Dummy data for CreditApplication
INSERT INTO CreditApplication (AgreementID, TimePeriod, InterestRate, InstallmentPerMonth, ApprovalStatus, ApprovalDate)
VALUES
(1, 24, 0.08, 8500000, 'Pending', NULL),
(NULL, NULL, NULL, NULL, NULL, NULL),
(3, 12, 0.09, 19500000, 'Disetujui', '2025-04-01');

-- Dummy data for DocumentCreditApplication
INSERT INTO DocumentCreditApplication (CreditAppID, DocType, File_Path, Date)
VALUES
(1, 'KTP', '/documents/andi_ktp.pdf', '2025-01-12'),
(3, 'Slip', '/documents/citra_slip.pdf', '2025-04-02');

-- Dummy data for PaymentHistory
INSERT INTO PaymentHistory (PurchaseID, PaymentNominal, PaymentType, PaymentDate)
VALUES
(1, 50000000, 'Transfer', '2025-01-15'),
(2, 360000000, 'Cash', '2025-02-16'),
(3, 100000000, 'Transfer', '2025-04-05');

-- Dummy data for WarrantyRegistration
INSERT INTO WarrantyRegistration (DealerCarID, PurchaseDate, WarrantyPeriod)
VALUES
(1, '2025-01-10', 36),
(2, '2025-02-15', 24),
(3, '2025-03-25', 36);

-- Dummy data for WarrantyClaim
INSERT INTO WarrantyClaim (WarrantyID, CustomerID, ClaimStatus, CostCovered, Description, ClaimDate)
VALUES
(1, 1, 'Success', 5000000, 'Ganti suku cadang', '2025-06-10'),
(2, 2, 'Failed', 0, 'Klaim garansi ditolak', '2025-07-01'),
(3, 3, 'Success', 3000000, 'Perbaikan kecil', '2025-08-15');