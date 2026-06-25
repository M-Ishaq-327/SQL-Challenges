use BikeStores;
--get current date and time from database.
SELECT 
	GETDATE() ;

--get today's date from database.
SELECT 
	CAST(GETDATE() AS date); --here date is datatype, GETDATE is function ,CAST is function.

--get current time only from database.
SELECT 
	CAST(GETDATE() AS time); --here time is datatype, GETDATE is function ,CAST is function.

--get current date from database.
SELECT 
	CAST(GETDATE() AS datetime); --here datetime is datatype, GETDATE is function ,CAST is function.

--get precise current date from database.
SELECT 
	CAST(GETDATE() AS datetime2); --here datetime2 is datatype, GETDATE is function ,CAST is function.

--NOTE : when some one ask current date then include date and time both, today's date include date only. (for interview and test remember).

--exteact year from given date
SELECT 
	YEAR('2026-06-25'); 

--find all record that are created today. (use sales.orders table , order_date column is there).
select * from sales.orders
WHERE
	order_date = CAST(GETDATE() AS DATE); --( note: in output : this database is old so you see no record for today)

	--find all recroder created yesterday.
select * from sales.orders
WHERE 
	order_date = DATEADD(DAY,-1,CAST(GETDATE() AS DATE))

--convert a datetime value into date only.
--ex:Write an SQL Server query to convert the datetime value '2026-06-25 14:35:20.123' into a value that contains only the date portion.
--we use cast to do this , because we don't have datetime col in our database , i dont write query here.

--convert a date value into datetime .
SELECT CAST (order_date AS datetime) 
FROM sales.orders ;

--find all the records where date is null.
SELECT * from sales.orders
WHERE order_date IS NULL;


