CREATE DATABASE hotel_management;
USE hotel_management;

CREATE TABLE BRANCHES (
    branch_id INT PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    location  VARCHAR(150) NOT NULL
)

CREATE TABLE ROOM (
    room_num     INT,
    branch_id    INT,
    type         VARCHAR(50),
    nightly_rate DECIMAL(10,2),
    PRIMARY KEY (room_num, branch_id),
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
)

CREATE TABLE CUSTOMER (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(20),
    email       VARCHAR(100) UNIQUE
)

CREATE TABLE BOOKING (
    booking_id  INT PRIMARY KEY,
    customer_id INT,
    check_in    DATE NOT NULL,
    check_out   DATE NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    CHECK (check_out > check_in)
)

CREATE TABLE STAFF (
    staff_id   INT PRIMARY KEY,
    branch_id  INT,
    name       VARCHAR(100) NOT NULL,
    job_title  VARCHAR(50),
    salary     DECIMAL(10,2),
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
)

CREATE TABLE BOOKING_ROOM (
    booking_id INT,
    room_num   INT,
    branch_id  INT,
    PRIMARY KEY (booking_id, room_num, branch_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id),
    FOREIGN KEY (room_num, branch_id) REFERENCES ROOM(room_num, branch_id)
)

CREATE TABLE STAFF_BOOKING (
    staff_id    INT,
    booking_id  INT,
    action_type VARCHAR(20),  -- check-in / check-out
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (staff_id, booking_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
)
INSERT INTO BRANCHES (branch_id, name, location) VALUES
(1, 'Downtown Hotel', 'City Center'),
(2, 'Airport Hotel', 'Near Airport'),
(3, 'Beach Resort', 'Seaside');

INSERT INTO ROOM (room_num, branch_id, type, nightly_rate) VALUES
(101, 1, 'Single',  80.00),
(102, 1, 'Double', 120.00),
(201, 2, 'Single',90.00),
(202, 2, 'Suite', 200.00),
(301, 3, 'Double', 150.00);

INSERT INTO CUSTOMER (customer_id, name, phone, email) VALUES
(1, 'Ahmed Ali', '0551234567', 'ahmed@email.com'),
(2, 'Sara Mohamed', '0559876543', 'sara@email.com'),
(3, 'Omar Hassan', '0555555555', 'omar@email.com');

INSERT INTO BOOKING (booking_id, customer_id, check_in, check_out) VALUES
(1, 1, '2025-01-10', '2025-01-12'),
(2, 2, '2025-01-15', '2025-01-18'),
(3, 3, '2025-02-01', '2025-02-05');

INSERT INTO BOOKING_ROOM (booking_id, room_num, branch_id) VALUES
(1, 101, 1),
(1, 102, 1),
(2, 201, 2),
(3, 301, 3);

INSERT INTO STAFF_BOOKING (staff_id, booking_id, action_type) VALUES
(1, 1, 'check-in'),
(1, 1, 'check-out'),
(3, 2, 'check-in'),
(4, 3, 'check-in');

DROP TABLE STAFF_BOOKING;

CREATE TABLE STAFF_BOOKING (
    staff_id    INT,
    booking_id  INT,
    action_type VARCHAR(20),
    action_time DATETIME DEFAULT GETDATE(),

    PRIMARY KEY (staff_id, booking_id, action_time),

    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
)

INSERT INTO STAFF_BOOKING (staff_id, booking_id, action_type) VALUES
(1, 1, 'check-in'),
(1, 1, 'check-out'),
(3, 2, 'check-in'),
(4, 3, 'check-in');

DROP TABLE STAFF_BOOKING;

CREATE TABLE STAFF_BOOKING (
    staff_booking_id INT IDENTITY(1,1) PRIMARY KEY,
    staff_id    INT NOT NULL,
    booking_id  INT NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    action_time DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
)

INSERT INTO STAFF_BOOKING (staff_id, booking_id, action_type) VALUES
(1, 1, 'check-in'),
(1, 1, 'check-out'),
(3, 2, 'check-in'),
(4, 3, 'check-in')

SELECT * FROM CUSTOMER --Display all guest records

SELECT name, phone, email FROM CUSTOMER --guest’s name, contact number

SELECT room_num, nightly_rate AS NightlyRate 
from ROOM -- each room number and its price per night as NightlyRate

SELECT booking_id, check_in, check_out
FROM BOOKING 

SELECT * FROM ROOM 
WHERE nightly_rate > 1000 --List rooms priced above 1000 per night

SELECT * FROM STAFF 
WHERE job_title = 'Receptionist' --staff members working as 'Receptionist'

SELECT * FROM BOOKING 
WHERE YEAR(check_in) = 2024 --bookings made in 2024

SELECT * FROM BOOKING
ORDER BY check_in DESC --bookings ordered by total cost descending

SELECT 
MAX(nightly_rate) AS MaxPrice,
MIN(nightly_rate) AS MinPrice,
AVG(nightly_rate) AS AvgPrice
FROM ROOM --maximum, minimum, and average room price

SELECT COUNT(*) AS TotalRooms
FROM ROOM --total number of rooms

SELECT * FROM CUSTOMER
WHERE name LIKE 'M%' --guests whose names start with 'M'

SELECT * FROM ROOM
WHERE nightly_rate BETWEEN 800 AND 1500 --rooms priced between 800 & 1500


---------------------------------------DML

INSERT INTO CUSTOMER (customer_id, name, phone, email)
VALUES (9011, 'Your Name', '0500000000', 'you@email.com') 

INSERT INTO BOOKING (booking_id, customer_id, check_in, check_out)
VALUES (10, 9011, '2025-01-20', '2025-01-25')

INSERT INTO BOOKING_ROOM (booking_id, room_num, branch_id)
VALUES (10, 205, 1)

SELECT * FROM ROOM
WHERE room_num = 205 AND branch_id = 1

INSERT INTO ROOM (room_num, branch_id, type, nightly_rate)
VALUES (205, 1, 'Luxury', 1200)

INSERT INTO BOOKING_ROOM (booking_id, room_num, branch_id)
VALUES (10, 205, 1)

INSERT INTO CUSTOMER (customer_id, name, phone, email)
VALUES (9012, 'Unknown Guest', NULL, NULL) --Insert another guest with NULL contact and proof details

UPDATE BOOKING
SET status = 'Confirmed'
WHERE booking_id = 10 -- Not exist

UPDATE ROOM
SET nightly_rate = nightly_rate * 1.10
WHERE type = 'Luxury' --Increase room prices by 10% for luxury rooms

UPDATE BOOKING
SET status = 'Completed'
WHERE check_out < GETDATE()

ALTER TABLE BOOKING
ADD status VARCHAR(20)

UPDATE BOOKING
SET status = 'Completed'
WHERE check_out < GETDATE()

DELETE FROM BOOKING
WHERE status = 'Cancelled'

