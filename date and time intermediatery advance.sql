use BikeStores;
--Count how many records were created per day.
 --SQL Server query to display the number of orders created per day from the Sales.Orders table.
 SELECT COUNT(order_id) as TotalOrder,
 order_date
 FROM sales.orders
 GROUP BY order_date;

 --Count how many records were created per month.
SELECT
    YEAR(order_date) AS OrderYear,
    MONTH(order_date) AS OrderMonth,
    COUNT(order_id) AS TotalOrders
FROM Sales.Orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    OrderYear,
    OrderMonth;

--Count how many records were created per year.
SELECT COUNT(order_id) TotalOrders,YEAR(order_date) as OrderYear
FROM sales.orders
GROUP BY  YEAR(order_date);

--Find the day of the week for a given date.
--SQL Server query to display the day of the week for each order_date in the Sales.Orders table.

SELECT order_date,DATEPART(WEEKDAY,order_date) as WeekDay
FROM sales.orders; --this is for weekday in numeric
--below query is for weekday in alphabetic.
SELECT order_date, DATENAME(WEEKDAY,order_date) as WeekDay
FROM sales.orders;

--find records created on weekEnds.
SELECT order_date, DATENAME(WEEKDAY,order_date) as DayName
FROM sales.orders
WHERE DATENAME(WEEKDAY,order_date) IN ('Saturday','Sunday');


--find record created on weekDays.
SELECT order_date, DATENAME(WEEKDAY,order_date) as DayName
FROM sales.orders
WHERE DATENAME(WEEKDAY,order_date) NOT IN ('Saturday','Sunday');

--Find records created between two dates (inclusive). maybe '2016-1-1' to '2026-1-22'
SELECT order_id , order_date
FROM sales.orders
WHERE order_date BETWEEN ('2016-01-01') AND ('2016-01-22') ;

--recomended way is below:
SELECT order_id,order_date
FROM sales.orders
WHERE order_date >= '2016-01-01' AND order_date <= '2016-01-22';

--Find records created in the last 24 hours.
SELECT * FROM sales.orders WHERE order_date = CAST(GETDATE() AS date);
