-- =========================================================
-- OLA BOOKING DATA ANALYSIS
-- SQL DATA ANALYST PROJECT
-- Database: Ola
-- Table: bookings
-- =========================================================

USE Ola;


-- =========================================================
-- BASIC DATA CHECK
-- =========================================================

-- 1. View sample records
SELECT *
FROM bookings
LIMIT 10;


-- 2. Check total number of records
SELECT COUNT(*) AS total_records
FROM bookings;


-- =========================================================
-- QUESTION 1
-- Retrieve all successful bookings
-- =========================================================

CREATE OR REPLACE VIEW successful_bookings AS
SELECT *
FROM bookings
WHERE Booking_Status = 'Success';


-- Retrieve answer
SELECT *
FROM successful_bookings;


-- =========================================================
-- QUESTION 2
-- Find the average ride distance for each vehicle type
-- =========================================================

CREATE OR REPLACE VIEW average_ride_distance AS
SELECT
    Vehicle_Type,
    AVG(Ride_Distance) AS average_ride_distance
FROM bookings
WHERE Ride_Distance IS NOT NULL
GROUP BY Vehicle_Type
ORDER BY average_ride_distance DESC;


-- Retrieve answer
SELECT *
FROM average_ride_distance;


-- =========================================================
-- QUESTION 3
-- Get the total number of rides cancelled by customers
-- =========================================================

CREATE OR REPLACE VIEW customer_cancelled_rides AS
SELECT
    COUNT(*) AS total_customer_cancelled_rides
FROM bookings
WHERE Canceled_Rides_by_Customer IS NOT NULL
  AND LOWER(TRIM(Canceled_Rides_by_Customer)) <> 'null';


-- Retrieve answer
SELECT *
FROM customer_cancelled_rides;


-- =========================================================
-- QUESTION 4
-- List the top 5 customers who booked the highest
-- number of rides
-- =========================================================

CREATE OR REPLACE VIEW top_5_customers AS
SELECT
    Customer_ID,
    COUNT(Booking_ID) AS total_rides
FROM bookings
WHERE Customer_ID IS NOT NULL
GROUP BY Customer_ID
ORDER BY total_rides DESC
LIMIT 5;


-- Retrieve answer
SELECT *
FROM top_5_customers;


-- =========================================================
-- QUESTION 5
-- Get the number of rides cancelled by drivers due to
-- personal and car-related issues
-- =========================================================

CREATE OR REPLACE VIEW driver_cancelled_personal_car_issues AS
SELECT
    COUNT(*) AS total_cancelled_rides
FROM bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';


-- Retrieve answer
SELECT *
FROM driver_cancelled_personal_car_issues;


-- =========================================================
-- QUESTION 6
-- Find the maximum and minimum driver ratings for
-- Prime Sedan bookings
-- =========================================================

CREATE OR REPLACE VIEW prime_sedan_driver_ratings AS
SELECT
    MAX(Driver_Ratings) AS max_rating,
    MIN(Driver_Ratings) AS min_rating
FROM bookings
WHERE Vehicle_Type = 'Prime Sedan';


-- Retrieve answer
SELECT *
FROM prime_sedan_driver_ratings;


-- =========================================================
-- QUESTION 7
-- Retrieve all rides where payment was made using UPI
-- =========================================================

CREATE OR REPLACE VIEW upi_payment_rides AS
SELECT *
FROM bookings
WHERE Payment_Method = 'UPI';


-- Retrieve answer
SELECT *
FROM upi_payment_rides;


-- =========================================================
-- QUESTION 8
-- Find the average customer rating for each vehicle type
-- =========================================================

CREATE OR REPLACE VIEW average_customer_rating AS
SELECT
    Vehicle_Type,
    AVG(Customer_Rating) AS average_customer_rating
FROM bookings
WHERE Customer_Rating IS NOT NULL
GROUP BY Vehicle_Type
ORDER BY average_customer_rating DESC;


-- Retrieve answer
SELECT *
FROM average_customer_rating;


-- =========================================================
-- QUESTION 9
-- Calculate the total booking value of rides completed
-- successfully
-- =========================================================

CREATE OR REPLACE VIEW total_successful_ride_value AS
SELECT
    SUM(Booking_Value) AS total_successful_ride_value
FROM bookings
WHERE Booking_Status = 'Success';


-- Retrieve answer
SELECT *
FROM total_successful_ride_value;


-- =========================================================
-- QUESTION 10
-- List all incomplete rides along with the reason
-- =========================================================

CREATE OR REPLACE VIEW incomplete_rides_reason AS
SELECT
    Booking_ID,
    Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes';


-- Retrieve answer
SELECT *
FROM incomplete_rides_reason;


-- =========================================================
-- PROJECT VERIFICATION
-- =========================================================

-- Check successful bookings
SELECT *
FROM successful_bookings
LIMIT 10;

-- Check average ride distance
SELECT *
FROM average_ride_distance;

-- Check customer cancellations
SELECT *
FROM customer_cancelled_rides;

-- Check top 5 customers
SELECT *
FROM top_5_customers;

-- Check driver cancellations
SELECT *
FROM driver_cancelled_personal_car_issues;

-- Check Prime Sedan ratings
SELECT *
FROM prime_sedan_driver_ratings;

-- Check UPI rides
SELECT *
FROM upi_payment_rides
LIMIT 10;

-- Check average customer rating
SELECT *
FROM average_customer_rating;

-- Check successful ride value
SELECT *
FROM total_successful_ride_value;

-- Check incomplete rides
SELECT *
FROM incomplete_rides_reason
LIMIT 10;
