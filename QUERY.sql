
-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id SERIAL primary key,
    full_name VARCHAR(255) not null,
    email VARCHAR(255) not null unique,
    role VARCHAR(255) not null CHECK (role IN ('Ticket Manager', 'Football Fan')) ,
    phone_number VARCHAR(50)
  
    );


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id SERIAL primary key,
    fixture VARCHAR(255) not null,
    tournament_category VARCHAR(255) not null,
    base_ticket_price DECIMAL(8,2) not null CHECK (base_ticket_price >= 0) ,
    match_status VARCHAR(255) not null CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);



-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id SERIAL primary key,
    user_id INTEGER REFERENCES users(user_id) not null,
    match_id INTEGER REFERENCES matches(match_id) not null,
    seat_number VARCHAR(255),
    payment_status VARCHAR(255) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost DECIMAL(8,2) not null CHECK (total_cost >= 0)
);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);

-- =========================================================================
-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' 
-- where the match status is 'Available'.
-- =========================================================================

select * from matches
where tournament_category = 'Champions League' and match_status = 'Available';

-- =========================================================================
-- Query 2: Search for all users whose full names start 
-- with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
-- =========================================================================

select * from users
where full_name ilike 'Tanvir%' or full_name ilike '%Haque%';

-- =========================================================================
-- Query 3: Retrieve all booking records where the payment status
-- is missing (NULL), replacing the empty result with 'Action Required'.
-- ========================================================================

select booking_id,user_id,match_id, coalesce(payment_status,'Action Required') AS systematic_status from bookings
where payment_status is null

-- =========================================================================
-- Query 4: Retrieve match booking details along with the User's 
--   full name and the scheduled Match fixture teams.
-- =========================================================================

SELECT booking_id, full_name, fixture, total_cost FROM bookings
JOIN users ON bookings.user_id = users.user_id
JOIN matches ON bookings.match_id = matches.match_id;

-- =========================================================================
-- Query 5: Display a comprehensive list of all users and their booking IDs,
-- ensuring that fans who have never bought a ticket are still listed.
-- =========================================================================

select users.user_id, full_name, booking_id from users
left join bookings on bookings.user_id = users.user_id;

-- =========================================================================
-- Query 6: Find all ticket bookings where the total cost is 
-- strictly higher than the average cost of all ticket bookings.
-- =========================================================================

select booking_id, match_id, total_cost FROM bookings
WHERE total_cost > (select AVG(total_cost) FROM bookings);

-- =========================================================================
-- Query 7: Retrieve the top 2 most expensive matches sorted by 
-- base ticket price, skipping the absolute highest premium match.
-- =========================================================================

select match_id, fixture, base_ticket_price from matches
WHERE base_ticket_price < (select MAX(base_ticket_price) FROM matches)
ORDER BY base_ticket_price DESC
LIMIT 2;


