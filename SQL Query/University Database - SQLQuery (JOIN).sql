----------------JOIN----------------------------------------------

--Display the department ID, name, and the full name of the faculty managing it

SELECT D.Department_id, D.D_name, F.Name AS Faculty_Name
FROM Department D
JOIN Faculty F
ON D.Department_id = F.Department_id

--Display each program's name and the name of the department offering it

SELECT C.Course_name, D.D_name AS Department_Name
FROM Course C
JOIN Department D
ON C.Department_id = D.Department_id

-- Display the full student data and the full name of their faculty advisor

SELECT S.*, F.Name AS Advisor_Name
FROM Student S
JOIN Faculty F
ON S.Department_id = F.Department_id

--Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'


-- Display full data about courses whose titles start with "I" (e.g., "Introduction to...")

SELECT *
FROM Course
WHERE Course_name LIKE 'B%'

SELECT * FROM Course
SELECT * FROM Faculty


-- Display names of students in program ID 3 whose GPA is between 2.5 and 3.5.
-- Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course.
-- Find names of students who are advised by "Dr. Ahmed Hassan"

SELECT S.F_name, S.L_name
FROM Student S
JOIN Faculty F
ON S.Department_id = F.Department_id
WHERE F.Name = 'Dr. Ahmed Ali'

--Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title.

SELECT S.F_name,  S.L_name, C.Course_name
FROM Student S
JOIN Student_Course SC
ON S.S_id = SC.S_id
JOIN Course C
ON SC.Course_id = C.Course_id
ORDER BY C.Course_name

-- For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class
SELECT DISTINCT F.*
FROM Faculty F
JOIN Department D
ON F.Department_id = D.Department_id 

-- Display all faculty members who manage any department
SELECT DISTINCT F.*
FROM Faculty F
JOIN Department D
ON F.Department_id = D.Department_id


-- Display all students and their advisors' names, even if some students don’t have advisors yet

SELECT S.F_name,
       S.L_name,
       F.Name AS Advisor_Name
FROM Student S
LEFT JOIN Faculty F
    ON S.Department_id = F.Department_id;
