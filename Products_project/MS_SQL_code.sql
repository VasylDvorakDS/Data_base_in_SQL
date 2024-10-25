SELECT sh.ShipperName,COUNT(DISTINCT orderid), COUNT(*) 
FROM Orders o
JOIN Shippers sh ON o.ShipperID = sh.ShipperID
GROUP by sh.ShipperName


SELECT count (DISTINCT categoryname), orderdate
FROM Orders o
JOIN OrderDetails od on o.OrderID=od.OrderID
join Products pr on pr.ProductID=od.ProductID
join Categories c on c.CategoryID = pr.CategoryID
Order by orderdate




WITH avg_income as (SELECT Cluster, AVG(income) as avg_income
				FROM Clusters c
                    WHERE cluster>4
				GROUP by cluster)
SELECT income,c.cluster, avg_c.* from Clusters c
left join avg_income avg_c on c.cluster=avg_c.cluster

where income>avg_income


SELECT c1.CategoryName, c2.CategoryName
From Categories c1, Categories c2


SELECT count (*)
FROM Categories c1

select credit_amount, credit_amount*(case when credit_amount<20000 THEN  1.2 else 1.4 end) as total_amount
FROM Clusters


select credit_amount, credit_amount*1.2 as total_amount
FROM Clusters
WHERE credit_amount <20000
UNION ALL
select credit_amount*1.4 as total_amount, 'first'  
FROM Clusters
WHERE credit_amount >=20000
order by credit_amount

SELECT categoryname,
COUNT (DISTINCT customerid) as cnt_distinct
FROM Orders o
JOIN OrderDetails od On o.OrderID = od.OrderID
JOIN Products p On p.ProductID = od.ProductID
JOIN Categories c On c.CategoryID = p.CategoryID
GROUP BY categoryname
UNION
SELECT 'TOTAL',  count(DISTINCT customerid)
From Orders


SELECT DISTINCT credit_amount
FROM Clusters
WHERE credit_amount>20000
INTERSECT
SELECT DISTINCT credit_amount
FROM Clusters
WHERE credit_amount>25000


varchar vs  nvarchar


SELECT categoryid, productname, price FROM Products
ORDER by categoryid, price, productname


with prod as (SELECT categoryid
,productname
,sum(Price) over (partition by categoryid) as sum_Price
,price*1/avg(price) over (partition by categoryid) as part_avg_Price
,avg(price) over (partition by categoryid) as avg_Price
,COUNT(Price) over (partition by categoryid) as count_Price
,min(price) over (partition by categoryid) as min_Price
,max(price) over (partition by categoryid) as max_Price
From Products p
ORDER by avg_Price, categoryid, productname)

SELECT * FROM prod
WHERE part_avg_Price <1




SELECT categoryid, sum(Price) from Products
GROUP by categoryid



SELECT categoryid
,productname
,price
,ROW_NUMBER() over (ORDER by price) as ROW_NUMBER_Price
,RANK() over (partition by categoryid ORDER by price) as RANK_Price
,DENSE_RANK() over (partition by categoryid ORDER by price) as DENSE_RANK_Price
,CUME_DIST() over (partition by categoryid ORDER by price) as CUME_DIST_Price
From Products p
ORDER by  ROW_NUMBER_Price, categoryid, productname



SELECT categoryid
,productname
,price
,first_value(productname) over (partition by categoryid ORDER by price) as first_value_productname
,last_value(productname) over (partition by categoryid ORDER by price RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as last_value_productname_with_last_command
,first_value(productname) over (partition by categoryid ORDER by price DESC) as last_value_productname_right
,lag(productname) over (partition by categoryid ORDER by price) as lag_productname
,lead(productname) over (partition by categoryid ORDER by price) as lead_productname
From Products p
ORDER by  categoryid, productname



--Посчитать интервал в датах между заказами

with analitic as (SELECT
Customerid
,1.0*DATEDIFF(day,CAST(orderdate as date)
,CAST(LEAD(orderdate) over (partition by customerid Order BY orderdate) as date)) as diff
FROM Orders),

analitic2 as (SELECT customerid ,avg(diff) as avg_diff, 1.0*count(*) AS cnt from analitic
GROUP by customerid)
SELECT avg(avg_diff),avg(cnt) From analitic2



--Определить клиентов с зарплатой более средней по кластеру

With avg_income AS(SELECT Cluster
,sex
,income
,AVG(income) over (partition by cluster) as avg_clus_inc
FROM Clusters)
SELECT *
FROM avg_income
where avg_clus_inc <income
order by avg_clus_inc, income, sex


--Получить для каждого непрерывного диапазон работы дату начала и дату конца соответствующего периода
SELECT DISTINCT orderdate 
FROM Orders
ORDER by orderdate

with dt as(SELECT DISTINCT orderdate
from Orders),
dif_dt as (SELECT *
, datediff(day, GETDATE(), orderdate)as ddCategories
,ROW_NUMBER() over (order by orderdate) as row_numCategories
,datediff(day, GETDATE(), orderdate) - ROW_NUMBER() over (order by orderdate) as dif
FROM dt)

SELECT min(orderdate) as start, max(orderdate) as finish from dif_dt
GROUP by dif

--В какие пять дней месяца были самые большие продажи

WITH day_sum as (SELECT orderdate
,sum(od.Quantity *p.Price) as cash
FROM Orders o                 
join OrderDetails od on o.OrderID =od.OrderID
join Products p on p.ProductID=od.ProductID
GROUP by o.OrderDate),
rn as (SELECT orderdate
,cash
,ROW_NUMBER() over (partition by YEAR(orderdate), month(orderdate) ORDER by cash DESC) as row_number_cash
FROM day_sum)
SELECT *
FROM rn
WHERE row_number_cash<=5                 
ORDER by YEAR(orderdate), month(orderdate), row_number_cash                 
                 
                 


CREATE TABLE draft_table (dt date,cnt int)

Drop TABLE if EXISTS table_notes

if OBJECT_ID('draft_table') IS not NULL
BEGIN
DROP TABLE draft_table
end;


DELETE FROM USERS WHERE ID=2 LIMIT 1
DELETE FROM USERS WHERE ID>5;
DELETE FROM USERS
TRUNCATE TABLE USERS


UPDATE USERS SET NAME=Мышь WHERE ID=3 LIMIT 1
UPDATE USERS SET NAME=Мышь, FOOD=Сыр WHERE ID=3 LIMIT 1

CREATE TABLE Planets(
ID int IDENTITY(1,1) NOT NULL,
PlanetName varchar(10) NOT NULL,
Radius float,
SunSeason float,
OpeningYear int,
HavingRights bit,
Opener varchar(30)
)



CREATE PROCEDURE S_S @TN VARCHAR(50), @N int = 10
AS
BEGIN
    DECLARE @query VARCHAR(1000)
    SET @query = 'SELECT TOP ' + CAST(@N AS VARCHAR(10)) + ' * FROM ' + QUOTENAME(@TN)
    EXEC (@query)
END

S_S @TN = Clusters, @N=2



--Собраить подневную статистику продаж

create PROC Small_ETL @start date, @finish date, @to_del BIT=0
AS
IF OBJECT_ID('[dbo].[Orders_stat]') is not NULL and @to_del =1
	BEGIN
	DROP TABLE Orders_stat
	end;
IF OBJECT_ID('[dbo].[Orders_stat]') is NULL
	BEGIN
	CREATE TABLE Orders_stat(dt date, cnt int)
	end;
DELETE FROM Orders_stat WHERE dt >= @start and dt < @finish
while @start < @finish
BEGIN
INSERT INTO Orders_stat
SELECT @start as dt, COUNT(*) as cnt
FROM Orders
WHERE orderdate = @start
set @start=dateadd(day,1,@start)
end;

Small_ETL @start='2023-05-01',@finish ='2023-12-01'
Small_ETL @start='2023-06-01',@finish ='2023-12-01', @to_del=1

SELECT COUNT(*) FROM Orders_stat

SELECT * FROM Orders_stat
                 
SELECT orderdate, COUNT(*) FROM Orders
GROUP by orderdate




create table Orders2 (ID int, date varchar(10))

INSERT into Orders2
VALUES (1, '2023-01-01'),
(2, '2023-01-02')

DELETE FROM Orders2 where id=1 


SELECT * from Orders2

update Orders2 set date='2023-01-05'WHERE ID=2

DELETE from Orders2



CREATE VIEW view_stat AS 
SELECT OrderDate, COUNT(*) AS OrderCount 
FROM Orders o
GROUP BY OrderDate;

SELECT * FROM view_stat vs
WHERE OrderDate > '2023-07-05';


