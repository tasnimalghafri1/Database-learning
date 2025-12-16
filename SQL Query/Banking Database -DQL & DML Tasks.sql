use [Banking System]

CREATE TABLE Branch(
BranchID int PRIMARY KEY,
Address VARCHAR(50) NOT NULL,
Phone VARCHAR(50)
)

CREATE TABLE Customer(
CustomerID int PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Position VARCHAR(50),
Date_of_birth int NOT NULL
)

CREATE TABLE Employees (
employee_id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(120) NOT NULL,
position VARCHAR(50),
branch_id INT NOT NULL,
FOREIGN KEY (branch_id) REFERENCES Branch(BranchID)
)

CREATE TABLE Account(
account_id int identity(1,1) PRIMARY KEY,
type VARCHAR(50) NOT NULL,
balance DECIMAL(12,2) DEFAULT 0,
date_created DATE NOT NULL DEFAULT GETDATE(),
customer_id int NOT NULL,
FOREIGN KEY (Customer_ID) REFERENCES Customer(CustomerID)
)

CREATE TABLE BankTransaction (
transaction_id INT IDENTITY(1,1) PRIMARY KEY,
date DATETIME NOT NULL DEFAULT GETDATE(),
amount DECIMAL(12,2) NOT NULL,
type VARCHAR(20) NOT NULL,
account_number INT NOT NULL,
FOREIGN KEY (account_number) REFERENCES Account(account_id)
)

CREATE TABLE Loan (
loan_id INT IDENTITY(1,1) PRIMARY KEY,
type VARCHAR(20),
amount DECIMAL(12,2) NOT NULL,
issue_date DATE NOT NULL DEFAULT GETDATE(),
customer_id INT NOT NULL,
employee_id INT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customer(CustomerID),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
)

CREATE TABLE Employee_Customer (
employee_id INT NOT NULL,
customer_id INT NOT NULL,
action_type VARCHAR(50) NOT NULL,
PRIMARY KEY (employee_id, customer_id, action_type),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
FOREIGN KEY (customer_id) REFERENCES Customer(CustomerID)
)

INSERT INTO Branch (BranchID, Address, Phone) VALUES
(1, 'Main Street 12, New York', '212-555-1000'),
(2, 'Wall Street 5, New York', '212-555-2000'),
(3, 'Market Street 9, Chicago', '312-555-3000')

INSERT INTO Customer (CustomerID, Name, Position, Date_of_birth) VALUES
(101, 'John Smith', 'Engineer', 1990),
(102, 'Sarah Johnson', 'Teacher', 1985),
(103, 'Michael Brown', 'Doctor', 1978),
(104, 'Emily Davis', 'Accountant', 1992)

INSERT INTO Employees (name, position, branch_id) VALUES
('Alice Green', 'Manager', 1),
('Bob White', 'Teller', 1),
('David Black', 'Loan Officer', 2),
('Laura Wilson', 'Customer Service', 3)

INSERT INTO Account (type, balance, customer_id) VALUES
('Savings', 5000.00, 101),
('Checking', 1500.00, 102),
('Savings', 12000.00, 103),
('Checking', 3000.00, 104)

INSERT INTO BankTransaction (amount, type, account_number) VALUES
(500.00, 'Deposit', 1),
(200.00, 'Withdrawal', 1),
(1000.00, 'Deposit', 2),
(300.00, 'Withdrawal', 3),
(1500.00, 'Deposit', 4)

INSERT INTO Loan (type, amount, customer_id, employee_id) VALUES
('Home Loan', 250000.00, 101, 1),
('Car Loan', 30000.00, 102, 3),
('Personal Loan', 15000.00, 104, 3)

INSERT INTO Employee_Customer (employee_id, customer_id, action_type) VALUES
(1, 101, 'Account Opening'),
(2, 102, 'Deposit Processing'),
(3, 102, 'Loan Approval'),
(3, 104, 'Loan Approval'),
(4, 103, 'Customer Support')

SELECT * FROM Customer --Display all customer records

SELECT Name AS FullName
FROM Customer 

SELECT loan_id, amount, type
FROM Loan --Display each loan ID, amount, and type

SELECT 
account_id AS AccountNumber,
balance * 0.05 AS AnnualInterest
FROM Account --Display account number and annual interest (5% of balance)

SELECT DISTINCT c.*
FROM Customer c
JOIN Loan l ON c.CustomerID = l.customer_id
WHERE l.amount > 100000 --List customers with loan amounts greater than 100000

SELECT *
FROM Account
WHERE balance > 20000 --List accounts with balances above 20000

SELECT *
FROM Account
WHERE YEAR(date_created) = 2023 --Display accounts opened in 2023

SELECT *
FROM Account
ORDER BY balance DESC --Display accounts ordered by balance descending

SELECT 
MAX(balance) AS MaxBalance,
MIN(balance) AS MinBalance,
AVG(balance) AS AvgBalance
FROM Account --maximum, minimum, and average account balance

SELECT COUNT(*) AS TotalCustomers
FROM Customer --Display total number of customers

----------------------------------------DML (INSERT / UPDATE / DELETE)

INSERT INTO Customer (CustomerID, Name, Position, Date_of_birth)
VALUES (201, 'Your Name', 'Student', 2000);

INSERT INTO Account (type, balance, customer_id)
VALUES ('Savings', 10000, 201)

INSERT INTO Customer (CustomerID, Name, Position, Date_of_birth)
VALUES (202, 'Ahmed Ali', NULL, 1995)

UPDATE Account
SET balance = balance * 1.20
WHERE customer_id = 201  --Increase your account balance by 20%

UPDATE Account
SET balance = balance * 1.05
WHERE balance < 5000 --Increase balance by 5% for accounts with balance less than 5000

