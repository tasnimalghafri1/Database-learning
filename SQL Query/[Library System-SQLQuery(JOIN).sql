use [Library System]

SELECT * FROM Library
SELECT * FROM Staff
SELECT * FROM Payment
SELECT * FROM Review
SELECT * FROM Member
SELECT * FROM Book
SELECT * FROM Loan

----------------------------Join----------------------------------------------------

----Display library ID, name, and the name of the manager:

SELECT L.Library_ID, L.Name AS Library_Name, S.Full_Name AS Manager_Name
FROM Library L
JOIN Staff S
ON L.Library_ID = S.Library_ID
WHERE S.Position = 'Manager'

---Display library names and the books available in each one:

SELECT L.Name AS Library_Name, B.Title AS Book_Title
FROM Library L
JOIN Book B
ON L.Library_ID = B.Library_ID
WHERE B.IsAvailable = 1

---Display all member data along with their loan history:

SELECT M.*, L.Loan_ID, L.Loan_Date, L.Due_Date, L.Return_Date, L.Status
FROM Member M
LEFT JOIN Loan L
ON M.Member_ID = L.Member_ID

---Display all books located in 'Zamalek' or 'Downtown'

SELECT B.*
FROM Book B
JOIN Library L
ON B.Library_ID = L.Library_ID
WHERE L.Location IN ('Zamalek', 'Downtown') --- There is no books located in Zamalek or Downtown 

---Display all books whose titles start with 'T':

SELECT *
FROM Book 
WHERE Title LIKE 'T'

---List members who borrowed books priced between 100 and 300 LE:

SELECT M.* 
FROM Member M 
JOIN Loan L
ON M.Member_ID = L.Member_ID
JOIN Book B
ON L.Book_ID = B.Book_ID
Where B.Price BETWEEN 100 AND 300

---Retrieve members who borrowed and returned books titled 'The C Programming Language'

SELECT M.Full_Name
FROM Member M
JOIN Loan L
ON M.Member_ID = L.Member_ID
JOIN Book B
ON L.Book_ID = B.Book_ID
WHERE B.Title = 'The C Programming Language'

---Find all members assisted by librarian "Sarah Fathy"

SELECT M.*
FROM Member M
JOIN Loan L
ON M.Member_ID = L.Member_ID
JOIN Book B
ON L.Book_ID = B.Book_ID
JOIN Library Lib
ON B.Library_ID = Lib.Library_ID
JOIN Staff S
ON Lib.Library_ID = S.Library_ID
WHERE S.Full_Name = 'David Brown'

---Display each member’s name and the books they borrowed, ordered by book title

SELECT M.Full_Name AS Member_Name, B.Title AS Book_Title
FROM Member M
JOIN Loan L
ON M.Member_ID = L.Member_ID
JOIN Book B
ON L.Book_ID = B.Book_ID
ORDER BY B.Title

---For each book located in 'Cairo Branch', show title, library name, manager, and shelf info

SELECT B.Title, L.Name AS Library_Name, S.Full_Name AS Manager_Name, B.Shelf_Location
FROM Book B
JOIN Library L
ON B.Library_ID = L.Library_ID
JOIN Staff S
ON L.Library_ID = S.Library_ID
WHERE L.Name = 'Central Library'
AND S.Position = 'Librarian'

---Display all staff members who manage libraries

SELECT *
FROM Staff
WHERE Position = 'Librarian'

---Display all members and their reviews, even if some didn’t submit any review yet

SELECT M.Full_Name, R.Rating, R.Comments, R.Review_Date
FROM Member M
LEFT JOIN Review R
ON M.Member_ID = R.Member_ID
