use [Banking System task2]

------------------Creation-------------------------------

CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
FullName NVARCHAR(100),
Email NVARCHAR(100),
Phone NVARCHAR(15),
SSN CHAR(9)
)

CREATE TABLE Account (
AccountID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
Balance DECIMAL(10, 2),
AccountType VARCHAR(50),
Status VARCHAR(20)
)

CREATE TABLE Transactions (
TransactionID INT PRIMARY KEY,
AccountID INT,
Amount DECIMAL(10, 2),
Type VARCHAR(10), -- Deposit, Withdraw
    TransactionDate DATETIME,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
)

CREATE TABLE Loan (
LoanID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
LoanAmount DECIMAL(12, 2),
LoanType VARCHAR(50),
Status VARCHAR(20)
)

-------------------------Insert data---------------------------------------

INSERT INTO Customer (CustomerID, FullName, Email, Phone, SSN)
VALUES
(1, N'Ahmed Al-Harthy', 'ahmed.harthy@gmail.com', '+96891234567', '123456789'),
(2, N'Fatima Al-Balushi', 'fatima.b@gmail.com', '+96892345678', '987654321'),
(3, N'Salim Al-Rashdi', 'salim.r@gmail.com', '+96893456789', '456789123'),
(4, N'Aisha Al-Said', 'aisha.said@gmail.com', '+96894567890', '321654987')

INSERT INTO Account (AccountID, CustomerID, Balance, AccountType, Status)
VALUES
(101, 1, 5500.00, 'Savings', 'Active'),
(102, 2, 3200.50, 'Current', 'Active'),
(103, 3, 1500.75, 'Savings', 'Inactive'),
(104, 4, 8200.00, 'Current', 'Active')

INSERT INTO Transactions (TransactionID, AccountID, Amount, Type, TransactionDate)
VALUES
(1001, 101, 1000.00, 'Deposit', '2024-01-10'),
(1002, 101, 500.00, 'Withdraw', '2024-01-15'),
(1003, 102, 1200.00, 'Deposit', '2024-02-05'),
(1004, 104, 2000.00, 'Deposit', '2024-02-20')

INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, Status)
VALUES
(201, 1, 10000.00, 'Car Loan', 'Approved'),
(202, 2, 25000.00, 'Home Loan', 'Pending'),
(203, 3, 5000.00, 'Personal Loan', 'Rejected'),
(204, 4, 15000.00, 'Business Loan', 'Approved')

-------------------------------Customer Service View------------------------------------

CREATE VIEW vw_CustomerService
AS
SELECT c.FullName, c.Phone,
a.Status AS AccountStatus
FROM Customer c
JOIN Account a
ON c.CustomerID = a.CustomerID

--------------------------------------Finance Department View---------------------------

CREATE VIEW vw_FinanceDepartment
AS
SELECT AccountID, Balance, AccountType
FROM Account

----------------------------------Loan Officer View------------------------------------

CREATE VIEW vw_LoanOfficer
AS
SELECT LoanID,
CustomerID,
LoanAmount,
LoanType,
Status
FROM Loan

-----------------------------Transaction Summary View------------------------------------

CREATE VIEW vw_TransactionSummary
AS
SELECT AccountID,
Amount,
TransactionDate
FROM Transactions
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE())

-------Test the viwes------------------------------ 

SELECT * FROM vw_CustomerService
SELECT * FROM vw_FinanceDepartment
SELECT * FROM vw_LoanOfficer
SELECT * FROM vw_TransactionSummary


