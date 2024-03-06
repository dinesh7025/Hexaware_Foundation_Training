--Task 1: Database Design:

--1.Create the database named "TicketBookingSystem"

CREATE DATABASE TicketBookingSystem
--Selecting our DB
USE TicketBookingSystem

--2. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships.
-- Creating table Venue:
CREATE TABLE Venue (
    venue_id INT PRIMARY KEY IDENTITY,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
)
--Creating table Booking:
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    num_tickets INT NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    booking_date DATE NOT NULL
)
--Creating table Event:
CREATE TABLE Event (
    event_id INT PRIMARY KEY IDENTITY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    booking_id INT
)
INSERT INTO EVENT(event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id) 
VALUES ('Music release','2024-02-14','11:00' , 3, 150, 150, 1000.3453, 'Sports' , 3)
Select * from Event
--Creating table Customer:
CREATE TABLE Customer(
    customer_id INT PRIMARY KEY IDENTITY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    booking_id INT
)

--4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.

-- Adding foreign key constraints afterwards, because I faced errors while adding it in creation
--For Event Table:
ALTER TABLE Event
ADD CONSTRAINT FK_Event_Venue FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)  ON DELETE CASCADE,
CONSTRAINT FK_Event_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

--For Customer Table:
ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

--For Booking Table:
ALTER TABLE Booking
ADD CONSTRAINT FK_Booking_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
CONSTRAINT FK_Booking_Event FOREIGN KEY (event_id) REFERENCES Event(event_id)

--Using check constraint we can allow specific values :
ALTER TABLE Event
ADD CONSTRAINT CK_Event_EventType CHECK (event_type IN ('Movie', 'Sports', 'Concert'))

--Tasks 2: Select, Where, Between, AND, LIKE:
--1. Write a SQL query to insert at least 10 sample records into each table.
--We can insert one by one or can insert all in one query
INSERT INTO Venue (venue_name, address)
VALUES('Heavenly Palace', ' Walajah Road, Near T Nagar Bus Stand, Chennai, Tamil Nadu 600017')
SELECT * FROM Venue
INSERT INTO Venue (venue_name, address)
VALUES
    ('Paradise Gardens', 'SIDCO Industrial Estate, Vandalur-Kelambakkam Road, Chennai, Tamil Nadu 600127'),
    ('Atlantis', 'Besant Nagar, Chennai, Tamil Nadu 600014'),
    ('The Blue Fin', 'Chepauk, Chennai, Tamil Nadu 600001'),
    ('The Greenhouse', '1, Mount Road, Guindy, Chennai, Tamil Nadu 600032'),
    ('Lotus Lakes', 'Dr. Radhakrishnan Salai, Saidapet, Chennai, Tamil Nadu 600035'),
    ('The Golden Plaza', 'Mount Road, Opposite Fort St. George, Chennai, Tamil Nadu 600001'),
    ('Prime Lands', 'Luz Corner, Luz, Mylapore, Chennai, Tamil Nadu 600004'),
    ('La Parisienne', 'Parrys Corner, Near High Court, Chennai, Tamil Nadu 600001.'),
    ('Harbor Town', 'Injambakkam, Kelambakkam Road, Chennai, Tamil Nadu 600127.')

-- Inserting data into event table 
INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type)
VALUES
    ('Event 1', '2024-04-01', '10:00', 1, 100, 100, 150.00, 'Movie'),
    ('Event 2', '2024-04-03', '11:00', 2, 150, 150, 1600.00, 'Sports'),
    ('Event 3', '2024-04-03', '12:00', 3, 200, 200, 700.00, 'Concert'),
    ('Event 4', '2024-04-06', '13:00', 1, 120, 120, 200.00, 'Movie'),
    ('Event 5', '2024-04-07', '14:00', 6, 180, 180, 650.00, 'Sports'),
    ('Event 6', '2024-04-07', '15:00', 6, 220, 220, 750.00, 'Concert'),
    ('Event 7', '2024-04-07', '16:00', 10, 130, 130, 580.00, 'Movie'),
    ('Event 8', '2024-04-10', '17:00', 8, 190, 190, 689.00, 'Sports'),
    ('Event 9', '2024-04-12', '18:00', 9, 230, 230, 788.00, 'Concert'),
    ('Event 10', '2024-04-20', '19:00', 10, 140, 140, 160.00, 'Movie')

SELECT * FROM Event
-- Inserting data into Customer Table:
INSERT INTO Customer (customer_name, email, phone_number)
VALUES
    ('Priya Sharma', 'priya.sharma@gmail.com', '9876543210'),
    ('Rahul Patel', 'rahul.patel@gmail.com', '8765432109'),
    ('Neha Singh', 'neha.singh@gmail.com', '7654321098'),
    ('Rohit Kumar', 'rohit.kumar@gmail.com', '6543210987'),
    ('Meera Gupta', 'meera.gupta@gmail.com', '9432109876'),
    ('Aryan Khan', 'aryan.khan@gmail.com', '9321098765'),
    ('Anjali Nair', 'anjali.nair@gmail.com', '9210987654'),
    ('Vikram Singh', 'vikram.singh@gmail.com', '9109876543'),
    ('Riya Sen', 'riya.sen@gmail.com', '9098765432'),
    ('Mohammed Hussain', 'md.hussain@gmail.com', '9987654321')
SELECT* FROM Customer

--Inserting data into Booking Table:
INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost, booking_date)
VALUES
    (1, 1, 2, 100.00, '2024-02-28'),
    (2, 2, 3, 180.00, '2024-02-29'),
    (3, 3, 1, 70.00, '2024-03-01'),
    (4, 4, 4, 220.00, '2024-03-02'),
    (5, 5, 2, 130.00, '2024-03-03'),
    (6, 6, 3, 225.00, '2024-03-04'),
    (7, 7, 1, 58.00, '2024-03-05'),
    (8, 8, 2, 136.00, '2024-03-06'),
    (9, 9, 3, 234.00, '2024-03-07'),
    (10, 10, 1, 60.00, '2024-03-08')
SELECT * FROM Booking

--2. Write a SQL query to list all Events.(We can select query)
SELECT * FROM Event

--3. Write a SQL query to select events with available tickets.(we can use logical operator '>')
SELECT * FROM Event WHERE available_seats > 0

--4. Write a SQL query to select events name partial match with ‘cup’(We didnt add anything like that so 0 records)
SELECT * FROM Event WHERE event_name LIKE '%cup%'

--5. Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500

-- 6. Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM Event WHERE event_date BETWEEN '2024-04-03' AND '2024-04-10'

--7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
UPDATE Event
SET event_name ='Musical Concert' 
where event_id= 3
SELECT * FROM Event WHERE available_seats > 0 AND event_name LIKE '%Concert%'

--8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user
--Note: (offset starts from 0 to n)
SELECT *
FROM Customer
ORDER BY customer_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY

-- 9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
--SELECT * FROM Booking
UPDATE Booking
SET num_tickets = 5 WHERE booking_id = 3 
SELECT * FROM Booking WHERE num_tickets > 4

--10. Write a SQL query to retrieve customer information whose phone number end with ‘000’
UPDATE Customer
SET phone_number ='9800085000'  WHERE customer_id = 3
UPDATE Customer
SET phone_number ='9000554000'  WHERE customer_id = 5 
SELECT * FROM Customer WHERE RIGHT(phone_number, 3) = '000'

--11. Write a SQL query to retrieve the events in order whose seat capacity more than 15000.
UPDATE Event
SET total_seats = 20000 WHERE event_id >= 6 AND event_id < 8
SELECT * FROM Event WHERE total_seats > 15000

--12. Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT event_name 
FROM Event 
WHERE LEFT(event_name, 1) != 'x' 
	AND LEFT(event_name, 1) != 'y' 
	AND LEFT(event_name, 1) != 'z'

-- Task 3: Aggregate functions, Having, Order By, GroupBy and Joins:

--1. Write a SQL query to List Events and Their Average Ticket Prices.
SELECT event_id, event_name, AVG(ticket_price) AS average_price
FROM Event
GROUP BY event_id, event_name

--2. Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT SUM(total_cost) AS total_revenue
FROM Booking;

--Referential Integrity Correction:
--Event Table
ALTER TABLE Event DROP CONSTRAINT FK_Event_Venue;
ALTER TABLE Event
ADD CONSTRAINT FK_Event_Venue FOREIGN KEY (venue_id) REFERENCES Venue(venue_id) ON DELETE CASCADE
ALTER TABLE Event DROP CONSTRAINT FK_Event_Booking
ALTER TABLE Event
ADD CONSTRAINT FK_Event_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE

--Customer Table
ALTER TABLE Customer DROP CONSTRAINT FK_Customer_Booking
ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE

--3. Write a SQL query to find the event with the highest ticket sales.
SELECT TOP 1 *, (total_seats-available_seats) AS Tickets_Sold
FROM Event 
ORDER BY (total_seats-available_seats) Desc
SELECT * FROM Event

--4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
SELECT event_id, event_name,  (total_seats-available_seats) AS [Tickets Sold]
FROM Event 
GROUP BY event_name, event_id, (total_seats-available_seats)
UPDATE Event
SET available_seats = 50 
WHERE event_id = 3

--5. Write a SQL query to Find Events with No Ticket Sales.
SELECT *, (total_seats-available_seats) AS [Tickets Sold]
FROM Event
WHERE (total_seats-available_seats) = 0

--6. Write a SQL query to Find the User Who Has Booked the Most Tickets.
SELECT * FROM Booking
ORDER BY num_tickets DESC
--OR
SELECT TOP 1 customer_id, num_tickets
FROM Booking
ORDER BY num_tickets DESC

--7. Write a SQL query to List Events and the total number of tickets sold for each month
SELECT 
	YEAR(event_date) AS [Booking Year],
	DATENAME(MONTH, event_date) AS [Booking Month],
	event_id,
	event_name,
	(total_seats-available_seats) AS [Tickets Sold]
FROM Event
GROUP BY 
	YEAR(event_date),
	DATENAME(MONTH, event_date),
	event_id, event_name, (total_seats-available_seats)
ORDER BY [Booking Year],[Booking Month]

--8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
SELECT 
	v.venue_id, 
	v.venue_id,
	AVG(e.ticket_price) AS [Average Ticket Price]
FROM VENUE AS v
JOIN Event AS e ON v.venue_id = e.venue_id
GROUP BY V.venue_id, E.event_id

--9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type
SELECT 
    e.event_type,
    SUM(b.num_tickets) AS total_tickets_sold
FROM Event e
JOIN Booking b ON e.event_id = b.event_id
GROUP BY e.event_type

--10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year.
SELECT 
    YEAR(b.booking_date) AS booking_year,
    SUM(b.num_tickets * e.ticket_price) AS total_revenue
FROM Event e
JOIN Booking b ON e.event_id = b.event_id
GROUP BY YEAR(b.booking_date)

--11.  Write a SQL query to list users who have booked tickets for multiple events
SELECT customer_id, COUNT(DISTINCT event_id) AS num_events_booked
FROM Booking
GROUP BY customer_id
HAVING COUNT(DISTINCT event_id) > 1

--12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User.
SELECT 
    b.customer_id,
    c.customer_name,
    SUM(b.num_tickets * e.ticket_price) AS total_revenue
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY b.customer_id, c.customer_name

--13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue
SELECT 
    e.event_type,
    v.venue_name,
    AVG(e.ticket_price) AS average_ticket_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY e.event_type, v.venue_name

--14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(b.num_tickets) AS total_tickets_purchased
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
WHERE b.booking_date >= DATEADD(day, -30, GETDATE()) 
GROUP BY 
    c.customer_id, c.customer_name

-- Tasks 4: Subquery and its types

--1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
SELECT 
	V.venue_id,
	(SELECT AVG(ticket_price) 
	FROM Event 
	WHERE venue_id=v.venue_id) AS [Avg Ticket Price]
FROM Venue v

--2. Find Events with More Than 50% of Tickets Sold using subquery.
SELECT 
    event_id,
    event_name,
    (
        SELECT SUM(num_tickets) * 100.0 / total_seats
        FROM Booking
        WHERE event_id = e.event_id
    ) AS percentage_tickets_sold
FROM 
    Event e
WHERE 
    (
        SELECT SUM(num_tickets) * 100.0 / total_seats
        FROM Booking
        WHERE event_id = e.event_id
    ) > 50

--3. Calculate the Total Number of Tickets Sold for Each Event.
SELECT 
	event_id, 
	event_name,
	IsNull(
	(Select SUM(b.num_tickets) 
		From Booking b
		WHERE b.event_id = e.event_id ) , 0)As [Total Tickets Sold]
FROM Event e
Group By event_id, event_name

--4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
SELECT *
FROM Customer C
WHERE NOT EXISTS (
    SELECT 1
    FROM Booking b
    WHERE b.customer_id = c.customer_id
)

--5. List Events with No Ticket Sales Using a NOT IN Subquery.
SELECT event_id, event_name
FROM Event
WHERE event_id Not In(
	SELECT DISTINCT event_id FROM Booking)

--6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
SELECT event_type, SUM(num_tickets) AS [Total Tickets]
FROM (
	SELECT e.event_type, b.num_tickets 
	FROM EVENT e
	JOIN Booking b 
	ON b.event_id = e.event_id
) As Subquery
Group By event_type

--7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
SELECT event_id, event_name, ticket_price
FROM Event
WHERE ticket_price>(
	SELECT AVG(ticket_price)
	FROM Event
)

--8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT 
	c.customer_id,
	c.customer_id,
	IsNull((
		SELECT SUM(total_cost)
		FROM Booking b
		WHERE b.customer_id = c.customer_id
	), 0) AS [Total revenue]
FROM Customer c

--9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.
DECLARE @venueId int = 3
SELECT customer_id, customer_name
FROM Customer c
WHERE EXISTS(
	SELECT 1 
	FROM Booking b
	JOIN Event e ON e.event_id = b.booking_id
	WHERE
		b.customer_id = c.customer_id AND e.venue_id =@venueId
)
SELECT* FROM Booking

--10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY.
SELECT
    event_type,
    SUM(num_tickets) AS total_tickets_sold
FROM(
       SELECT e.event_id, e.event_type, b.num_tickets
        FROM
            Event e
            INNER JOIN Booking b ON e.event_id = b.event_id
    ) AS subquery
GROUP BY
    event_type;

--11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT
SELECT DISTINCT
    c.customer_id,
    c.customer_name,
    DATENAME (month, b.booking_date) AS booking_month
FROM
    Customer c
INNER JOIN
    Booking b ON c.customer_id = b.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
	DATENAME (month, b.booking_date)

--12. . Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT 
	venue_id, 
	venue_name,
	IsNULL((
		SELECT AVG(e.ticket_price)
		FROM Event e
		WHERE e.venue_id = v.venue_id
	), 0) AS [Avg Ticket Price]
FROM Venue v
Select * from Event




























