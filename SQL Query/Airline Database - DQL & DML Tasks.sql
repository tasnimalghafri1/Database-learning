use [Airline Database ]

------------------creation------------------------------------------
CREATE TABLE Airport (
    airport_code VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50),
    name VARCHAR(100)
)

CREATE TABLE Flight (
    flight_no VARCHAR(10) PRIMARY KEY,
    airline VARCHAR(50),
    restrictions VARCHAR(200)
)

CREATE TABLE Flight_Weekdays (
    flight_no VARCHAR(10),
    weekday VARCHAR(20),
    PRIMARY KEY (flight_no, weekday),
    FOREIGN KEY (flight_no) REFERENCES Flight(flight_no)
)

CREATE TABLE Flight_Leg (
leg_no INT PRIMARY KEY,
scheduled_dep_time TIME,
scheduled_arr_time TIME,
flight_no VARCHAR(10),
departure_airport VARCHAR(10),
arrival_airport VARCHAR(10),
FOREIGN KEY (flight_no) REFERENCES Flight(flight_no),
FOREIGN KEY (departure_airport) REFERENCES Airport(airport_code),
FOREIGN KEY (arrival_airport) REFERENCES Airport(airport_code)
)

CREATE TABLE Airplane_Type (
type_name VARCHAR(30) PRIMARY KEY,
company VARCHAR(50),
max_seats INT
)

CREATE TABLE Airplane (
airplane_id INT PRIMARY KEY,
total_seats INT,
type_name VARCHAR(30),
FOREIGN KEY (type_name) REFERENCES Airplane_Type(type_name)
)

CREATE TABLE Leg_Instance (
leg_no INT,
date DATE,
arrival_time TIME,
departure_time TIME,
available_seats INT,
airplane_id INT,
PRIMARY KEY (leg_no, date),
FOREIGN KEY (leg_no) REFERENCES Flight_Leg(leg_no),
FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id)
)

CREATE TABLE Reservation (
reservation_id INT PRIMARY KEY,
customer_name VARCHAR(100),
customer_phone VARCHAR(20),
seat_number VARCHAR(10),
leg_no INT,
date DATE,
FOREIGN KEY (leg_no, date) REFERENCES Leg_Instance(leg_no, date)
)

CREATE TABLE Fare (
fare_code VARCHAR(10) PRIMARY KEY,
amount DECIMAL(8,2),
flight_no VARCHAR(10),
FOREIGN KEY (flight_no) REFERENCES Flight(flight_no)
)

CREATE TABLE Airport_AirplaneType (
airport_code VARCHAR(10),
type_name VARCHAR(30),
PRIMARY KEY (airport_code, type_name),
FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
FOREIGN KEY (type_name) REFERENCES Airplane_Type(type_name)
)

----------------------------INSERT DATA ------------------------------------------

INSERT INTO Airport VALUES
('JFK', 'New York', 'NY', 'John F Kennedy International'),
('LAX', 'Los Angeles', 'CA', 'Los Angeles International'),
('ORD', 'Chicago', 'IL', 'O Hare International'),
('ATL', 'Atlanta', 'GA', 'Hartsfield Jackson Atlanta'),
('DFW', 'Dallas', 'TX', 'Dallas Fort Worth International')

INSERT INTO Flight VALUES
('AA101', 'American Airlines', 'No smoking'),
('DL202', 'Delta Airlines', 'No pets allowed'),
('UA303', 'United Airlines', 'Carry-on only'),
('SW404', 'Southwest', 'Open seating')

INSERT INTO Flight_Weekdays VALUES
('AA101', 'Monday'),
('AA101', 'Wednesday'),
('DL202', 'Tuesday'),
('DL202', 'Friday'),
('UA303', 'Monday'),
('UA303', 'Thursday'),
('SW404', 'Saturday')

INSERT INTO Flight_Leg VALUES
(1, '08:00', '11:00', 'AA101', 'JFK', 'LAX'),
(2, '12:00', '14:00', 'DL202', 'ATL', 'ORD'),
(3, '09:30', '12:30', 'UA303', 'ORD', 'DFW'),
(4, '15:00', '18:30', 'SW404', 'DFW', 'LAX')

INSERT INTO Airplane_Type VALUES
('Boeing737', 'Boeing', 180),
('AirbusA320', 'Airbus', 160),
('Boeing787', 'Boeing', 250)

INSERT INTO Airplane VALUES
(1001, 180, 'Boeing737'),
(1002, 160, 'AirbusA320'),
(1003, 250, 'Boeing787')

INSERT INTO Leg_Instance VALUES
(1, '2025-01-10', '11:05', '08:05', 150, 1003),
(2, '2025-01-11', '14:10', '12:05', 120, 1002),
(3, '2025-01-12', '12:40', '09:40', 130, 1001),
(4, '2025-01-13', '18:40', '15:10', 140, 1001)

INSERT INTO Reservation VALUES
(5001, 'John Smith', '555-1234', '12A', 1, '2025-01-10'),
(5002, 'Alice Brown', '555-5678', '14C', 2, '2025-01-11'),
(5003, 'David Lee', '555-9012', '22B', 3, '2025-01-12')

INSERT INTO Fare VALUES
('F100', 350.00, 'AA101'),
('F200', 220.00, 'DL202'),
('F300', 280.00, 'UA303'),
('F400', 199.99, 'SW404')

INSERT INTO Airport_AirplaneType VALUES
('JFK', 'Boeing787'),
('LAX', 'Boeing787'),
('ORD', 'AirbusA320'),
('ATL', 'AirbusA320'),
('DFW', 'Boeing737')

SELECT * FROM Flight_Leg --all flight leg records

SELECT leg_no, scheduled_dep_time, scheduled_arr_time
FROM Flight_Leg --each flight leg ID, scheduled departure time, and arrival time

SELECT airplane_id, type_name, total_seats
FROM Airplane --airplane’s ID, type, and seat capacity

SELECT leg_no, available_seats AS AvailableSeats
FROM Leg_Instance --flight leg’s ID and available seats as AvailableSeats

SELECT leg_no
FROM Leg_Instance
WHERE available_seats > 100 --List flight leg IDs with available seats > 100

SELECT airplane_id
FROM Airplane
WHERE total_seats > 300 --airplane IDs with seat capacity above 300

SELECT airport_code, name
FROM Airport
WHERE city = 'Cairo'

SELECT *
FROM Leg_Instance
WHERE date = '2025-06-10'

SELECT *
FROM Flight_Leg
ORDER BY scheduled_dep_time --flight legs ordered by departure time

SELECT 
MAX(available_seats) AS MaxSeats,
MIN(available_seats) AS MinSeats,
AVG(available_seats) AS AvgSeats
FROM Leg_Instance --maximum, minimum, and average available seats

SELECT COUNT(*) AS TotalFlightLegs
FROM Flight_Leg  --Total num of flight legs

SELECT *
FROM Airplane
WHERE type_name LIKE '%Boeing%' --airplanes whose type contains 'Boeing'

--------------------------------DML------------------------------------------------

INSERT INTO Flight_Leg VALUES
(10, '10:00', '14:00', 'EK500', 'CAI', 'DXB') -- ERROR

INSERT INTO Flight (flight_no, airline, restrictions)
VALUES ('EK500', 'Emirates Airlines', 'No restrictions')

SELECT airport_code FROM Airport WHERE airport_code IN ('CAI', 'DXB')

INSERT INTO Airport VALUES
('CAI', 'Cairo', 'Cairo', 'Cairo International Airport'),
('DXB', 'Dubai', 'Dubai', 'Dubai International Airport')

INSERT INTO Flight_Leg VALUES
(10, '10:00', '14:00', 'EK500', 'CAI', 'DXB')

INSERT INTO Leg_Instance VALUES
(10, '2025-06-10', '14:10', '10:05', 200, 1003)

INSERT INTO Reservation VALUES
(6001, 'Ahmed Hassan', NULL, '15A', 10, '2025-06-10') --Insert a customer with NULL contact number

UPDATE Leg_Instance
SET available_seats = available_seats - 5
WHERE leg_no = 10
  AND date = '2025-06-10' --Reduce available seats of your inserted flight leg by 5

UPDATE Leg_Instance li
SET available_seats = available_seats + 10
WHERE li.leg_no IN (
SELECT fl.leg_no
FROM Flight_Leg fl
JOIN Airport a1 ON fl.departure_airport = a1.airport_code
JOIN Airport a2 ON fl.arrival_airport = a2.airport_code
WHERE a1.state = a2.state
)

UPDATE li
SET li.available_seats = li.available_seats + 10
FROM Leg_Instance li
JOIN Flight_Leg fl ON li.leg_no = fl.leg_no
JOIN Airport a1 ON fl.departure_airport = a1.airport_code
JOIN Airport a2 ON fl.arrival_airport = a2.airport_code
WHERE a1.state = a2.state

UPDATE Airplane
SET total_seats = total_seats + 20
WHERE total_seats < 150  --Update airplane seat capacity by +20 where capacity < 150

DELETE FROM Leg_Instance
WHERE available_seats = 0