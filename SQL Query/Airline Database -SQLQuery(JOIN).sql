----------------------------JOIN---------------------------------------------

--Display each flight leg's ID, schedule, and the name of the airplane assigned to it:

SELECT fl.leg_no,fl.scheduled_dep_time,fl.scheduled_arr_time,
at.type_name AS airplane_type
FROM Flight_Leg fl
JOIN Leg_Instance li ON fl.leg_no = li.leg_no
JOIN Airplane a ON li.airplane_id = a.airplane_id
JOIN Airplane_Type at ON a.type_name = at.type_name 

--Display all flight numbers and the names of the departure and arrival airports

SELECT fl.flight_no,
dep.name AS departure_airport,
arr.name AS arrival_airport
FROM Flight_Leg fl
JOIN Airport dep ON fl.departure_airport = dep.airport_code
JOIN Airport arr ON fl.arrival_airport = arr.airport_code

--Display all reservation data with the name and phone of the customer who made each booking

SELECT 
    r.reservation_id,
    r.customer_name,
    r.customer_phone,
    r.seat_number,
    r.leg_no,
    r.date
FROM Reservation r

--Display IDs and locations of flights departing from 'CAI' or 'DXB'

SELECT DISTINCT fl.flight_no, a.city, a.state
FROM Flight_Leg fl
JOIN Airport a ON fl.departure_airport = a.airport_code
WHERE fl.departure_airport IN ('CAI', 'DXB')

--Display full data of flights whose names start with 'A'

SELECT *
FROM Flight
WHERE airline LIKE 'A%'

--List customers who have bookings with total payment between 3000 and 5000

SELECT r.customer_name, SUM(f.amount) AS total_payment
FROM Reservation r
JOIN Flight_Leg fl ON r.leg_no = fl.leg_no
JOIN Fare f ON fl.flight_no = f.flight_no
GROUP BY r.customer_name
HAVING SUM(f.amount) BETWEEN 3000 AND 5000

--Retrieve all passengers on 'Flight 110' who booked more than 2 seats.

SELECT  r.customer_name,
COUNT(*) AS seats_booked
FROM Reservation r
JOIN Flight_Leg fl ON r.leg_no = fl.leg_no
WHERE fl.flight_no = 'AA101'
GROUP BY r.customer_name
HAVING COUNT(*) > 2

SELECT * FROM Flight

-- Find names of passengers whose booking was handled by agent "Youssef Hamed"

-- Display each passenger’s name and the flights they booked, ordered by flight date

SELECT  r.customer_name, fl.flight_no, r.date
FROM Reservation r
JOIN Flight_Leg fl ON r.leg_no = fl.leg_no
ORDER BY r.date

-- For each flight departing from 'Cairo', display the flight number, departure time, and airline name

SELECT DISTINCT fl.flight_no, fl.scheduled_dep_time, f.airline
FROM Flight_Leg fl
JOIN Airport a ON fl.departure_airport = a.airport_code
JOIN Flight f ON fl.flight_no = f.flight_no
WHERE a.city = 'Cairo'

-- Display all staff members who are assigned as supervisors for flights/ There is no Staff table or supervisor relationship in your schema 

-- Display all bookings and their related passengers, even if some bookings are unpaid

SELECT r.reservation_id, r.customer_name, r.customer_phone, f.amount
FROM Reservation r
LEFT JOIN Flight_Leg fl ON r.leg_no = fl.leg_no
LEFT JOIN Fare f ON fl.flight_no = f.flight_no


