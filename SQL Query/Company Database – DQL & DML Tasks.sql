use Company_SD

SELECT * FROM Employee; --Display all employee data

SELECT Fname, Lname, Salary, Dno
FROM Employee;  --Display employee Fname,Lname,Salary,Dno

SELECT 
    Fname + ' ' + Lname AS Full_Name,
    Salary * 12 * 0.10 AS ANNUAL_COMM
FROM Employee; -- Display each employee’s full name and their annual commission (10% of annual salary

SELECT SSN, Fname + ' ' + Lname AS Name
FROM Employee WHERE Salary > 1000; 
-- Display employee ID and name for employees earning more than 1000 LE monthly

SELECT Fname + ' ' + Lname AS Name, Salary FROM Employee 
WHERE Sex = 'F' --Display names and salaries of all female employees

SELECT * FROM Employee 
WHERE Salary BETWEEN 2000 AND 5000 --Display employees whose salary is between 2000 

SELECT Fname + ' ' + Lname AS Name, Salary FROM Employee
ORDER BY Salary DESC --Display employee names ordered by salary descending

SELECT 
MAX(Salary) AS Max_Salary,
MIN(Salary) AS Min_Salary,
AVG(Salary) AS Avg_Salary FROM Employee --the maximum, minimum, and average salary

SELECT COUNT(*) AS Total_Employee 
FROM Employee  --the total number of employees

SELECT * FROM Employee
WHERE Fname LIKE 'A%' --employees whose first name starts with 'A'

SELECT * FROM Employee
WHERE SuperSSN IS NULL; --employees who have no supervisor

SELECT * FROM Employee
WHERE HireDate > '2020-12-31' --This query cannot be executed because the Employee table does not contain a hire date column

ALTER TABLE Employee ADD HireDate DATE --Add HireDate column

SELECT * FROM Employee
WHERE HireDate > '2020-12-31' 



