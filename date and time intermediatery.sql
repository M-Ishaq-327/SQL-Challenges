--find the diff in days btwn two date.
--ex : calculate the number of days between the order_date and shipped_date columns in the Sales.Orders table.
use BikeStores;

SELECT order_date , shipped_date ,
DATEDIFF(DAY,order_date,shipped_date) as DiffInDays
FROM sales.orders;

--Find the difference in hours between two timestamps.
--ex:number of hours between the order_date and shipped_date columns in the Sales.Orders table.
SELECT order_date, shipped_date,
DATEDIFF(HOUR,order_date,shipped_date) as DiffInHour
FROM sales.orders;

--Add 7 days to a given date.
--display the order_date and a new date that is 7 days after order_date from the Sales.Orders table.
SELECT order_date,
DATEADD(DAY,7,order_date) as Add7DaysInOrderDate
FROM sales.orders;

--Subtract 1 month from a date.
SELECT order_date,
DATEADD(MONTH,-1,order_date) as OneMonthBeforeOrderDate
FROM sales.orders;

--Find all records from the last 30 days.
SELECT *
FROM Sales.Orders
WHERE order_date >= DATEADD(DAY, -30, CAST(GETDATE() AS DATE))
  AND order_date <= CAST(GETDATE() AS DATE);

--Find all records from the current month.
--query to retrieve all orders from the Sales.Orders table where the order_date falls within the current month.
SELECT *
FROM Sales.Orders
WHERE 
	order_date >= DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()), 1) --this gives current month ok.
AND order_date <  DATEADD(  MONTH,  1,                                     --now this gives the next month ok
					DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()), 1) );

