-----------------------------Join--------------------------------------------
--Display hotel ID, name, and the name of its manager

SELECT b.BranchID, b.Address, e.name AS Manager_Name
FROM Branch b
JOIN Employees e ON b.BranchID = e.branch_id
WHERE e.position = 'Manager'

 --Display hotel names and the rooms available under them

SELECT b.Address, a.account_id, a.type, a.balance
FROM Branch b
JOIN Employees e ON b.BranchID = e.branch_id
JOIN Loan l ON e.employee_id = l.employee_id
JOIN Account a ON l.customer_id = a.customer_id

--Display guest data along with the bookings they made

SELECT c.Name, bt.transaction_id, bt.amount, bt.type, bt.date
FROM Customer c
JOIN Account a ON c.CustomerID = a.customer_id
JOIN BankTransaction bt ON a.account_id = bt.account_number

--Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'

SELECT bt.*
FROM BankTransaction bt
JOIN Account a ON bt.account_number = a.account_id
JOIN Customer c ON a.customer_id = c.CustomerID
JOIN Employees e ON c.CustomerID = e.employee_id
JOIN Branch b ON e.branch_id = b.BranchID
WHERE b.Address LIKE '%New York%'

SELECT * FROM Branch
--Display all room records where room type starts with "S" (e.g., "Suite", "Single")

SELECT *
FROM Account
WHERE type LIKE 'S%'

--List guests who booked rooms priced between 1500 and 2500 LE

SELECT DISTINCT c.Name
FROM Customer c
JOIN Account a ON c.CustomerID = a.customer_id
WHERE a.balance BETWEEN 1500 AND 2500 

--Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown"

SELECT c.Name
FROM Customer c
JOIN Loan l ON c.CustomerID = l.customer_id
JOIN Employees e ON l.employee_id = e.employee_id
WHERE e.name = 'Alice Green'

SELECT * FROM Employees
--Find guests whose bookings were handled by staff member "Mona Ali"
SELECT c.Name
FROM Customer c
JOIN Employee_Customer ec ON c.CustomerID = ec.customer_id
JOIN Employees e ON ec.employee_id = e.employee_id
WHERE e.name = 'David Black'

--Display each guest’s name and the rooms they booked, ordered by room type

SELECT c.Name, a.type, a.balance
FROM Customer c
JOIN Account a ON c.CustomerID = a.customer_id
ORDER BY a.type
--For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info

SELECT b.BranchID, b.Address, b.Phone, e.name AS Manager_Name
FROM Branch b
JOIN Employees e ON b.BranchID = e.branch_id
WHERE e.position = 'Manager'
AND b.Address LIKE '%New York%'
--Display all staff members who hold 'Manager' positions

SELECT *
FROM Employees
WHERE position = 'Manager'
--Display all guests and their reviews, even if some guests haven't submitted any reviews

SELECT c.Name, l.loan_id, l.amount
FROM Customer c
LEFT JOIN Loan l ON c.CustomerID = l.customer_id







