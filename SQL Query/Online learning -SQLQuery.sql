use [Online Learning]

-----------------------Creation Table-------------------------------------

CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
)

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
)

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
Title VARCHAR(100),
InstructorID INT,
CategoryID INT,
Price DECIMAL(6,2),
PublishDate DATE,
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
)

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
)

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
EnrollDate DATE,
CompletionPercent INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
)

--------------------------------Insert data -------------------------------------

INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21')

INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business')

INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01')

INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10')

INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3)

---------------------------Part 1: Warm-Up (Simple SELECT)------------------------------------

SELECT Title, Price
FROM Courses

SELECT FullName, JoinDate
FROM Students

SELECT EnrollmentID, CompletionPercent, Rating
FROM Enrollments

SELECT COUNT(*) AS Instructors_2023
FROM Instructors
WHERE YEAR(JoinDate) = 2023 --Count instructors who joined in 2023

SELECT COUNT(*) AS Students_April_2023
FROM Students
WHERE YEAR(JoinDate) = 2023
  AND MONTH(JoinDate) = 4 --Count students who joined in April 2023

 -------------------------Part 2: Beginner Aggregation-------------------------------------

SELECT COUNT(*) AS Total_Students
FROM Students --Count total number of students

SELECT COUNT(*) AS Total_Enrollments
FROM Enrollments --Count total number of Enrollments

SELECT CourseID, AVG(Rating) AS Avg_Rating
FROM Enrollments
GROUP BY CourseID -- Average rating

SELECT InstructorID, COUNT(*) AS Course_Count
FROM Courses
GROUP BY InstructorID --Count courses per instructor

SELECT CategoryID, COUNT(*) AS Course_Count
FROM Courses
GROUP BY CategoryID --Count courses per Category

SELECT CourseID, COUNT(StudentID) AS Student_Count
FROM Enrollments
GROUP BY CourseID --Count students enrolled in each course

SELECT CategoryID, AVG(Price) AS Avg_Price
FROM Courses
GROUP BY CategoryID --average course price per category

SELECT MAX(Price) AS Max_Price
FROM Courses --Maximum course 

SELECT CourseID,
MIN(Rating) AS Min_Rating,
MAX(Rating) AS Max_Rating,
AVG(Rating) AS Avg_Rating
FROM Enrollments
GROUP BY CourseID --Min,Max,Avg rating per course

SELECT COUNT(*) AS Rating_5_Count
FROM Enrollments
WHERE Rating = 5 --cpunt how many students give rating 5

-------------------------Part 3: Extended Beginner Practice-----------------

SELECT MONTH(EnrollDate) AS Month, COUNT(*) AS Enrollments
FROM Enrollments
GROUP BY MONTH(EnrollDate) -- count    enroll per month

SELECT AVG(Price) AS Avg_Course_Price
FROM Courses --Average 

SELECT MONTH(JoinDate) AS Month, COUNT(*) AS Students
FROM Students
GROUP BY MONTH(JoinDate) --count students per join month 

SELECT Rating, COUNT(*) AS Rating_Count
FROM Enrollments
GROUP BY Rating -- Count RATING per value 1-5

SELECT CourseID
FROM Enrollments
GROUP BY CourseID
HAVING SUM(CASE WHEN Rating = 5 THEN 1 ELSE 0 END) = 0 --course that never received ratiiiiing =5

SELECT COUNT(*) AS Courses_Above_30
FROM Courses
WHERE Price > 30 -- count courses priced > 30 

SELECT AVG(CompletionPercent) AS Avg_Completion
FROM Enrollments -- avg completon percent 

SELECT TOP 1 CourseID, AVG(Rating) AS Avg_Rating
FROM Enrollments
GROUP BY CourseID
ORDER BY Avg_Rating ASC --courses with lowest avg rating

-------------------------Day 1 Mini Challenge – Course Performance Snapshot---------------

SELECT c.Title,
COUNT(e.EnrollmentID) AS Total_Enrollments,
AVG(e.Rating) AS Avg_Rating,
AVG(e.CompletionPercent) AS Avg_Completion
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title 

use [Online Learning]
--------------------Part 4: JOIN + Aggregation----------------------------------

SELECT c.Title, i.FullName, COUNT(e.EnrollmentID) AS Enrollments
FROM Courses c
JOIN Instructors i ON c.InstructorID = i.InstructorID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title, i.FullName

SELECT cat.CategoryName,
COUNT(c.CourseID) AS Total_Courses,
AVG(c.Price) AS Avg_Price
FROM Categories cat
LEFT JOIN Courses c ON cat.CategoryID = c.CategoryID
GROUP BY cat.CategoryName --Category name + total courses + average price

SELECT i.FullName, AVG(e.Rating) AS Avg_Rating
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName --Instructor name + average course rating

SELECT s.FullName, COUNT(e.CourseID) AS Total_Courses
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.FullName --Student name + total courses enrolled

SELECT cat.CategoryName, COUNT(e.EnrollmentID) AS Total_Enrollments
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName --Category name + total enrollments

SELECT i.FullName, SUM(c.Price) AS Revenue
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName  --Instructor name + total revenue

SELECT c.Title,
AVG(CASE WHEN e.CompletionPercent = 100 THEN 1.0 ELSE 0 END) * 100 AS Completion_100_Percent
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title --Course title + % of students completed 100%

-------------------------------Part 5: HAVING Practice (ONLY HAVING)---------------------------

SELECT CourseID
FROM Enrollments
GROUP BY CourseID
HAVING COUNT(*) > 2

SELECT i.FullName
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
HAVING AVG(e.Rating) > 4

SELECT CourseID
FROM Enrollments
GROUP BY CourseID
HAVING AVG(CompletionPercent) < 60

SELECT CategoryID
FROM Courses
GROUP BY CategoryID
HAVING COUNT(*) > 1

SELECT StudentID
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) >= 2

---------------------------------Part 6: Analytical Thinking------------------------

SELECT TOP 1 c.Title, AVG(e.Rating) AS Avg_Rating
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY Avg_Rating DESC --Highest average rating

SELECT TOP 1 i.FullName, AVG(e.Rating) AS Avg_Rating
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY Avg_Rating DESC

SELECT TOP 1 cat.CategoryName, SUM(c.Price) AS Revenue
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName
ORDER BY Revenue DESC

SELECT AVG(Rating) AS Avg_Rating_Expensive
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.Price > 30 --Do expensive courses have better ratings?

SELECT AVG(CompletionPercent) AS Avg_Completion_Cheap
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.Price <= 30 --o cheaper courses have higher completion?

-------------------Mini Analytics Report--------------------------------

SELECT TOP 3 c.Title, SUM(c.Price) AS Revenue
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY Revenue DESC --top 3 courses by revenue

SELECT TOP 1 i.FullName, COUNT(e.EnrollmentID) AS Enrollments
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY Enrollments DESC

SELECT TOP 1 c.Title, AVG(e.CompletionPercent) AS Avg_Completion
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY Avg_Completion ASC

SELECT TOP 1 cat.CategoryName, AVG(e.Rating) AS Avg_Rating
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName
ORDER BY Avg_Rating DESC 

SELECT TOP 1 s.FullName, COUNT(e.CourseID) AS Courses
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.FullName
ORDER BY Courses DESC --student enrolled in most courses


































