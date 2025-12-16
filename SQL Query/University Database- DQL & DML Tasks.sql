use [University Database1]

CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL
)

CREATE TABLE Faculty (
    F_id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Mobile_no VARCHAR(15),
    Salary DECIMAL(10,2),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
)

CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Address VARCHAR(200),
    Pin_code VARCHAR(10),
    No_of_seats INT
)

CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Phone_no VARCHAR(15),
    DOB DATE,
    Department_id INT NOT NULL,
    Hostel_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
)

SELECT S_id, 
       DATEDIFF(YEAR, DOB, GETDATE()) AS Age
FROM Student

CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    Course_name VARCHAR(100),
    Duration VARCHAR(50),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
)

CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_name VARCHAR(100),
    Course_id INT NOT NULL,
    Faculty_id INT NOT NULL,
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id),
    FOREIGN KEY (Faculty_id) REFERENCES Faculty(F_id)
)

CREATE TABLE Exams (
    Exam_code INT PRIMARY KEY,
    Exam_date DATE,
    Exam_time TIME,
    Room VARCHAR(20),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
)

CREATE TABLE Student_Course (
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
)

CREATE TABLE Student_Subject (
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
)

CREATE TABLE Student_Exam (
    S_id INT,
    Exam_code INT,
    PRIMARY KEY (S_id, Exam_code),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Exam_code) REFERENCES Exams(Exam_code)
)

INSERT INTO Department (Department_id, D_name) VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical'),
(4, 'Civil')

INSERT INTO Faculty (F_id, Name, Mobile_no, Salary, Department_id) VALUES
(101, 'Dr. Ahmed Ali', '9876543210', 75000, 1),
(102, 'Dr. Sara Khan', '9876543220', 72000, 2),
(103, 'Dr. John Smith', '9876543230', 70000, 3),
(104, 'Dr. Mary Thomas', '9876543240', 68000, 1)

INSERT INTO Hostel (Hostel_id, Hostel_name, City, State, Address, Pin_code, No_of_seats) VALUES
(1, 'Boys Hostel A', 'Delhi', 'Delhi', 'North Campus', '110001', 200),
(2, 'Girls Hostel B', 'Delhi', 'Delhi', 'South Campus', '110002', 150)

INSERT INTO Student (S_id, F_name, L_name, Phone_no, DOB, Department_id, Hostel_id) VALUES
(201, 'Ali', 'Hassan', '9991112221', '2002-05-14', 1, 1),
(202, 'Ayesha', 'Khan', '9991112222', '2003-03-20', 1, 2),
(203, 'Rahul', 'Verma', '9991112223', '2001-11-10', 2, 1),
(204, 'Neha', 'Sharma', '9991112224', '2002-07-08', 3, 2)

INSERT INTO Course (Course_id, Course_name, Duration, Department_id) VALUES
(301, 'BSc Computer Science', '3 Years', 1),
(302, 'BTech Electronics', '4 Years', 2),
(303, 'BTech Mechanical', '4 Years', 3)

INSERT INTO Subject (Subject_id, Subject_name, Course_id, Faculty_id) VALUES
(401, 'Data Structures', 301, 101),
(402, 'Operating Systems', 301, 104),
(403, 'Digital Electronics', 302, 102),
(404, 'Thermodynamics', 303, 103)

INSERT INTO Exams (Exam_code, Exam_date, Exam_time, Room, Department_id) VALUES
(501, '2025-03-10', '10:00', 'R101', 1),
(502, '2025-03-12', '02:00', 'R202', 2),
(503, '2025-03-15', '10:00', 'R303', 3)

INSERT INTO Student_Course (S_id, Course_id) VALUES
(201, 301),
(202, 301),
(203, 302),
(204, 303)

INSERT INTO Student_Subject (S_id, Subject_id) VALUES
(201, 401),
(201, 402),
(202, 401),
(203, 403),
(204, 404)

INSERT INTO Student_Exam (S_id, Exam_code) VALUES
(201, 501),
(202, 501),
(203, 502),
(204, 503)

SELECT S_id, F_name,
DATEDIFF(YEAR, DOB, GETDATE()) AS Age
FROM Student -- Test if it is correct 

SELECT * FROM Student -- all columns and all rows from the Student table

SELECT F_name + ' ' + L_name AS Full_Name,
Enrollment_date,
Student_status
FROM Student

ALTER TABLE Student
ADD Enrollment_date DATE,
    Student_status VARCHAR(20),
    GPA DECIMAL(3,2),
    Advisor_name VARCHAR(100) --Add missing columns to Student

UPDATE Student
SET Enrollment_date = '2021-08-01',
    Student_status = 'Active',
    GPA = 3.4,
    Advisor_name = 'Dr. Ahmed Ali'
WHERE S_id = 201;

UPDATE Student
SET Enrollment_date = '2022-08-01',
    Student_status = 'Inactive',
    GPA = 3.8,
    Advisor_name = NULL
WHERE S_id = 202

SELECT F_name + ' ' + L_name AS Full_Name,
       Enrollment_date,
       Student_status
FROM Student  --Display each student's full name, enrollment date, and current status

SELECT Course_name, Credits
FROM Course -- not correct

SELECT F_name + ' ' + L_name AS Full_Name,
GPA AS GPA_Score
FROM Student --student’s full name and GPA

SELECT S_id, F_name, L_name
FROM Student
WHERE GPA > 3.5 --student IDs and names of students with GPA > 3.5

SELECT *
FROM Student
WHERE Enrollment_date < '2022-01-01' --students who enrolled before 2022

SELECT *
FROM Student
WHERE GPA BETWEEN 3.0 AND 3.5 --students with GPA between 3.0 and 3.5

SELECT *
FROM Student
ORDER BY GPA DESC --students ordered by GPA descending

SELECT 
MAX(GPA) AS Max_GPA,
MIN(GPA) AS Min_GPA,
AVG(GPA) AS Avg_GPA
FROM Student --maximum, minimum, and average GPA

SELECT COUNT(*) AS Total_Students
FROM Student --total number of students

SELECT *
FROM Student
WHERE F_name LIKE '%a' --students whose names end with 'a'

SELECT *
FROM Student
WHERE Advisor_name IS NULL --students with NULL advisor

SELECT *
FROM Student
WHERE YEAR(Enrollment_date) = 2021 --students enrolled in 2021

----------------------------------University Database – DML Tasks-----------------------

INSERT INTO Student 
(S_id, F_name, L_name, Enrollment_date, GPA, Department_id)
VALUES
(300045, 'YourName', 'YourSurname', '2023-08-01', 3.6, 2)

INSERT INTO Student
(S_id, F_name, L_name, Enrollment_date, GPA, Advisor_name, Department_id)
VALUES
(300046, 'Friend', 'Name', '2023-08-01', NULL, NULL, 1)

INSERT INTO Student
(S_id, F_name, L_name, Enrollment_date, GPA, Advisor_name, Department_id)
VALUES
(300046, 'Friend', 'Name', '2023-08-01', NULL, NULL, 1)


INSERT INTO Student
(S_id, F_name, L_name, Enrollment_date, GPA, Advisor_name, Department_id)
VALUES
(300047, 'Friend', 'Name', '2023-08-01', NULL, NULL, 1)

UPDATE Student
SET GPA = GPA + 0.2
WHERE S_id = 300045 --Increase your GPA by 0.2

UPDATE Student
SET GPA = 2.0
WHERE GPA < 2.0 --Set GPA to 2.0 for students with GPA below 2.0

UPDATE Student
SET GPA = GPA + 0.1
WHERE Enrollment_date < '2020-01-01' --Increase GPA by 0.1 for students enrolled before 2020

DELETE FROM Student
WHERE Student_status = 'Inactive'

DELETE FROM Student_Course
WHERE S_id IN (SELECT S_id FROM Student WHERE Student_status = 'Inactive')

DELETE FROM Student_Subject
WHERE S_id IN (SELECT S_id FROM Student WHERE Student_status = 'Inactive')

DELETE FROM Student_Exam
WHERE S_id IN (SELECT S_id FROM Student WHERE Student_status = 'Inactive')

DELETE FROM Student
WHERE Student_status = 'Inactive'



