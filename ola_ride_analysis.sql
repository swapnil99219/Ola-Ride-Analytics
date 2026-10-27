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
  AND TRIM(Canceled_Rides_by_Customer) <> ''
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

-- ============================================
-- OLA RIDE ANALYTICS
-- ADVANCED SQL BUSINESS QUESTIONS
-- Q11 TO Q25
-- ============================================


-- Q11. Calculate the booking success rate (%).

SELECT
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN Booking_Status = 'Success' THEN 1 ELSE 0 END)
        AS successful_bookings,
    ROUND(
        100.0 * SUM(CASE WHEN Booking_Status = 'Success' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS success_rate_percentage
FROM bookings;


-- Q12. Calculate the cancellation rate for each vehicle type.

SELECT
    Vehicle_Type,
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN Booking_Status LIKE '%Cancel%' THEN 1
        ELSE 0
    END) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(CASE
            WHEN Booking_Status LIKE '%Cancel%' THEN 1
            ELSE 0
        END) / NULLIF(COUNT(*), 0),
        2
    ) AS cancellation_rate_percentage
FROM bookings
GROUP BY Vehicle_Type
ORDER BY cancellation_rate_percentage DESC;


-- Q13. Find the top 5 vehicle types by total booking value.

SELECT
    Vehicle_Type,
    ROUND(SUM(Booking_Value), 2) AS total_booking_value
FROM bookings
GROUP BY Vehicle_Type
ORDER BY total_booking_value DESC
LIMIT 5;


-- Q14. Calculate bookings and booking value by payment method.

SELECT
    Payment_Method,
    COUNT(*) AS total_bookings,
    ROUND(SUM(Booking_Value), 2) AS total_booking_value
FROM bookings
GROUP BY Payment_Method
ORDER BY total_booking_value DESC;


-- Q15. Find the top 10 customers by total booking value.

SELECT
    Customer_ID,
    COUNT(*) AS total_bookings,
    ROUND(SUM(Booking_Value), 2) AS total_booking_value
FROM bookings
WHERE Customer_ID IS NOT NULL
GROUP BY Customer_ID
ORDER BY total_booking_value DESC
LIMIT 10;


-- Q16. Compare average ride distance by booking status.

SELECT
    Booking_Status,
    ROUND(AVG(Ride_Distance), 2) AS average_ride_distance,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY Booking_Status
ORDER BY average_ride_distance DESC;


-- Q17. Find the most common customer cancellation reason.

SELECT
    TRIM(Canceled_Rides_by_Customer) AS cancellation_reason,
    COUNT(*) AS cancellation_count
FROM bookings
WHERE Canceled_Rides_by_Customer IS NOT NULL
  AND TRIM(Canceled_Rides_by_Customer) <> ''
  AND LOWER(TRIM(Canceled_Rides_by_Customer)) <> 'null'
GROUP BY TRIM(Canceled_Rides_by_Customer)
ORDER BY cancellation_count DESC
LIMIT 1;


-- Q18. Find the most common driver cancellation reason.

SELECT
    TRIM(Canceled_Rides_by_Driver) AS cancellation_reason,
    COUNT(*) AS cancellation_count
FROM bookings
WHERE Canceled_Rides_by_Driver IS NOT NULL
  AND TRIM(Canceled_Rides_by_Driver) <> ''
  AND LOWER(TRIM(Canceled_Rides_by_Driver)) <> 'null'
GROUP BY TRIM(Canceled_Rides_by_Driver)
ORDER BY cancellation_count DESC
LIMIT 1;


-- Q19. Find daily booking counts and the highest-booking day.

SELECT
    DATE(Date) AS booking_date,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY DATE(Date)
ORDER BY total_bookings DESC;


-- Q20. Compare monthly booking value with the previous month.

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Date, '%Y-%m') AS booking_month,
        SUM(Booking_Value) AS monthly_booking_value
    FROM bookings
    GROUP BY DATE_FORMAT(Date, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        booking_month,
        monthly_booking_value,
        LAG(monthly_booking_value) OVER (
            ORDER BY booking_month
        ) AS previous_month_value
    FROM monthly_sales
)
SELECT
    booking_month,
    ROUND(monthly_booking_value, 2) AS monthly_booking_value,
    ROUND(previous_month_value, 2) AS previous_month_value,
    ROUND(
        monthly_booking_value - previous_month_value,
        2
    ) AS value_change
FROM monthly_comparison
ORDER BY booking_month;


-- Q21. Calculate running total of booking value over time.

WITH daily_sales AS (
    SELECT
        DATE(Date) AS booking_date,
        SUM(Booking_Value) AS daily_booking_value
    FROM bookings
    GROUP BY DATE(Date)
)
SELECT
    booking_date,
    ROUND(daily_booking_value, 2) AS daily_booking_value,
    ROUND(
        SUM(daily_booking_value) OVER (
            ORDER BY booking_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS running_total_booking_value
FROM daily_sales
ORDER BY booking_date;


-- Q22. Rank vehicle types by successful booking count.

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_bookings,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS vehicle_rank
FROM bookings
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY vehicle_rank;


-- Q23. Find customers whose booking value exceeds
-- the average total booking value per customer.

WITH customer_totals AS (
    SELECT
        Customer_ID,
        SUM(Booking_Value) AS total_customer_value
    FROM bookings
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    ROUND(total_customer_value, 2) AS total_customer_value
FROM customer_totals
WHERE total_customer_value > (
    SELECT AVG(total_customer_value)
    FROM customer_totals
)
ORDER BY total_customer_value DESC;


-- Q24. Calculate each payment method's contribution
-- to total booking value (%).

SELECT
    Payment_Method,
    ROUND(SUM(Booking_Value), 2) AS payment_method_value,
    ROUND(
        100.0 * SUM(Booking_Value)
        / NULLIF(SUM(SUM(Booking_Value)) OVER (), 0),
        2
    ) AS contribution_percentage
FROM bookings
GROUP BY Payment_Method
ORDER BY payment_method_value DESC;


-- Q25. Find the top 3 customers by booking value
-- within each vehicle type.

WITH customer_vehicle_totals AS (
    SELECT
        Vehicle_Type,
        Customer_ID,
        SUM(Booking_Value) AS total_booking_value
    FROM bookings
    WHERE Customer_ID IS NOT NULL
    GROUP BY Vehicle_Type, Customer_ID
),
ranked_customers AS (
    SELECT
        Vehicle_Type,
        Customer_ID,
        total_booking_value,
        DENSE_RANK() OVER (
            PARTITION BY Vehicle_Type
            ORDER BY total_booking_value DESC
        ) AS customer_rank
    FROM customer_vehicle_totals
)
SELECT
    Vehicle_Type,
    Customer_ID,
    ROUND(total_booking_value, 2) AS total_booking_value,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3
ORDER BY Vehicle_Type, customer_rank;


-- ============================================
-- END OF ADVANCED BUSINESS ANALYSIS
-- ============================================
