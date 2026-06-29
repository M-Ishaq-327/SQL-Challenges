/* ===============================
   STEP 0: USE CORRECT DATABASE
   =============================== */
USE SqlDatePractice;
GO

/* ===============================
   STEP 1: DELETE EVERYTHING
   =============================== */
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Logins;
DROP TABLE IF EXISTS Users;
GO

/* ===============================
   STEP 2: CREATE TABLES
   =============================== */
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    created_at DATETIME
);

CREATE TABLE Logins (
    user_id INT,
    login_time DATETIME
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    amount DECIMAL(10,2)
);
GO

/* ===============================
   STEP 3: INSERT DATA
   =============================== */

-- Users
INSERT INTO Users VALUES
(1, 'Ali',    '2026-06-01 10:15:00'),
(2, 'Sara',   '2026-06-02 23:59:59'),
(3, 'John',   '2026-05-31 00:00:00'),
(4, 'Ayesha', '2026-06-15 08:30:00');

-- Logins
INSERT INTO Logins VALUES
-- User 1: consecutive days
(1, '2026-06-10 09:00:00'),
(1, '2026-06-11 09:10:00'),
(1, '2026-06-12 09:20:00'),

-- User 2: gap
(2, '2026-06-01 18:00:00'),
(2, '2026-06-05 18:00:00'),

-- User 3: multiple same day
(3, '2026-06-20 08:00:00'),
(3, '2026-06-20 18:00:00'),

-- Weekend + midnight
(4, '2026-06-21 00:00:00'),
(4, '2026-06-22 10:00:00');

-- Orders
INSERT INTO Orders VALUES
(101, '2026-06-01 10:00:00', 250.00),
(102, '2026-06-30 23:59:59', 450.00), -- month end
(103, '2026-05-31 00:00:00', 300.00), -- midnight
(104, '2026-06-15 14:30:00', 150.00),
(105, '2026-06-21 09:00:00', 500.00);
GO

--now practicing the questions.
--Find users who logged in on consecutive days.
USE SqlDatePractice;

SELECT
    user_id,
    login_time,
    LEAD(login_time) OVER (
        PARTITION BY user_id
        ORDER BY login_time
    ) AS next_login
FROM Logins;

select * from Logins;

--Find the longest gap (in days) between two consecutive logins per user.

SELECT
    user_id,
    MAX(gap_days) AS longest_gap_days
FROM
(
    SELECT
        user_id,
        DATEDIFF(
            DAY,
            login_time,
            LEAD(login_time) OVER (
                PARTITION BY user_id
                ORDER BY login_time
            )
        ) AS gap_days
    FROM Logins
) AS t
GROUP BY user_id;

--Group records into weekly buckets.
SELECT
    DATEPART(WEEK, order_date) AS WeeklyBucket,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DATEPART(WEEK, order_date)
ORDER BY WeeklyBucket;
;


--Find records created in the last full calendar week.
SELECT order_id
FROM Orders
WHERE order_date >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) - 1, 0) --start of last weeek calendar
  AND order_date <  DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0); --end of last tweek calendar

--Calculate the Age from DOB.

SELECT DATEDIFF(YEAR,'2002-01-17',GETDATE()) AS Age;

--Find employees whose work anniversary is today.
 -- i dont have the kind of data ,it will be done by companing hire month to the currect month only !!


--Find records where time part is exactly midnight (00:00:00).
SELECT user_id, login_time
FROM Logins
WHERE CAST(login_time AS TIME) = '00:00:00';

--Convert UTC time zone to LocalTime
SELECT
    login_time AT TIME ZONE 'UTC'
               AT TIME ZONE 'Pakistan Standard Time' AS LocalTime
FROM Logins;



