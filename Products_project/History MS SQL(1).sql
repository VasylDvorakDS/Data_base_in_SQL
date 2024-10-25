--- 25-10-2024 14:38:42
--- MY_SQL_code
CREATE TABLE draft_table (dt date,cnt int);

--- 25-10-2024 14:40:40
--- MY_SQL_code
Drop TABLE if EXISTS table_notes;

--- 25-10-2024 14:41:21
--- MY_SQL_code
if OBJECT_ID('draft_table') IS not NULL
BEGIN
DROP TABLE draft_table
end;

--- 25-10-2024 14:41:30
--- MY_SQL_code
if OBJECT_ID('draft_table') IS not NULL
BEGIN
DROP TABLE draft_table
end;

--- 25-10-2024 14:58:07
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near 'AUTO_INCREMENT'.
 ----- 
CREATE TABLE Planets(
ID int NOT NULL AUTO_INCREMENT,
PlanetName varchar(10) NOT NULL,
Radius float,
SunSeason float,
OpeningYear int,
Opener varchar(30)
);
*****/

--- 25-10-2024 15:00:00
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near 'AUTO_INCREMENT'.
 ----- 
CREATE TABLE Planets(
ID int NOT NULL AUTO_INCREMENT,
PlanetName varchar(10) NOT NULL,
Radius float,
SunSeason float,
OpeningYear int,
Opener varchar(30)
);
*****/

--- 25-10-2024 15:46:18
--- MS_SQL_code
/***** ERROR ******
Error 156 Incorrect syntax near the keyword 'NOT'.
 ----- 
ID int NOT NULL AUTO_INCREMENT,
PlanetName varchar(10) NOT NULL,
Radius float,
SunSeason float,
OpeningYear int,
HavingRights bit,
Opener varchar(30)
);
*****/

--- 25-10-2024 15:47:26
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near 'AUTO_INCREMENT'.
 ----- 
CREATE TABLE Planets(
ID int NOT NULL AUTO_INCREMENT,
PlanetName varchar(10) NOT NULL,
Radius float,
SunSeason float,
OpeningYear int,
HavingRights bit,
Opener varchar(30)
);
*****/

--- 25-10-2024 15:49:16
--- MS_SQL_code
CREATE TABLE Planets(
ID int IDENTITY(1,1) NOT NULL,
PlanetName varchar(10) NOT NULL,
Radius float,
SunSeason float,
OpeningYear int,
HavingRights bit,
Opener varchar(30)
);

--- 25-10-2024 16:01:25
--- MS_SQL_code
/***** ERROR ******
Error 343 Unknown object type 'PROCUDURE' used in a CREATE, DROP, or ALTER statement.
 ----- 
CREATe PROCUDURE S_S @TN VARCHAR(50), @N int=10
AS
BEGIN
	DECLARE @query VARCHAR(1000)
set @query ='SELECT TOP('+CAST(@N AS VARCHAR(10)+') *FROM)'+@TN
EXEC (@query)
END;
*****/

--- 25-10-2024 16:02:11
--- MS_SQL_code
/***** ERROR ******
Error 343 Unknown object type 'PROCUDURE' used in a CREATE, DROP, or ALTER statement.
 ----- 
CREATe PROCUDURE S_S @TN VARCHAR(50), @N int=10
AS
BEGIN
	DECLARE @query VARCHAR(1000)
set @query ='SELECT TOP('+CAST(@N AS VARCHAR(10))+') *FROM)'+@TN
EXEC (@query)
END;
*****/

--- 25-10-2024 16:02:51
--- MS_SQL_code
/***** ERROR ******
Error 343 Unknown object type 'PROCUDURE' used in a CREATE, DROP, or ALTER statement.
 ----- 
CREATe PROCUDURE S_S @TN VARCHAR(50), @N int=10
AS
BEGIN
	DECLARE @query VARCHAR(1000)
set @query ='SELECT TOP('+CAST(@N AS VARCHAR(10))+') *FROM)'+@TN
EXEC (@query)
END;
*****/

--- 25-10-2024 16:04:33
--- MS_SQL_code
CREATe PROCEDURE S_S @TN VARCHAR(50), @N int=10
AS
BEGIN
	DECLARE @query VARCHAR(1000)
set @query ='SELECT TOP('+CAST(@N AS VARCHAR(10))+') *FROM)'+@TN
EXEC (@query)
END;

--- 25-10-2024 16:06:19
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near ')'.
 ----- 
S_S @TN=Clusters;
*****/

--- 25-10-2024 16:08:21
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near 'CAST'.
 ----- 
CREATe PROCEDURE S_S @TN VARCHAR(50), @N int=10
AS
BEGIN
	DECLARE @query VARCHAR(1000)
set @query ='SELECT *FROM '+@TN +' LIMIT 'CAST(@N AS VARCHAR(10))
EXEC (@query)
END

S_S @TN=Clusters;
*****/

--- 25-10-2024 16:10:22
--- MS_SQL_code
/***** ERROR ******
Error 2714 There is already an object named 'S_S' in the database.
 ----- 
CREATE PROCEDURE S_S @TN VARCHAR(50), @N int = 10
AS
BEGIN
    DECLARE @query VARCHAR(1000)
    SET @query = 'SELECT TOP ' + CAST(@N AS VARCHAR(10)) + ' * FROM ' + @TN
    EXEC (@query)
END;
*****/

--- 25-10-2024 16:10:28
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near ')'.
 ----- 
EXEC S_S @TN = 'Clusters';
*****/

--- 25-10-2024 16:12:10
--- MS_SQL_code
/***** ERROR ******
Error 2714 There is already an object named 'S_S' in the database.
 ----- 
CREATE PROCEDURE S_S @TN VARCHAR(50), @N int = 10
AS
BEGIN
    DECLARE @query VARCHAR(1000)
    SET @query = 'SELECT TOP ' + CAST(@N AS VARCHAR(10)) + ' * FROM ' + QUOTENAME(@TN)
    EXEC (@query)
END

EXEC S_S @TN = 'Clusters';
*****/

--- 25-10-2024 16:12:19
--- MS_SQL_code
/***** ERROR ******
Error 2714 There is already an object named 'S_S' in the database.
 ----- 
CREATE PROCEDURE S_S @TN VARCHAR(50), @N int = 10
AS
BEGIN
    DECLARE @query VARCHAR(1000)
    SET @query = 'SELECT TOP ' + CAST(@N AS VARCHAR(10)) + ' * FROM ' + QUOTENAME(@TN)
    EXEC (@query)
END;
*****/

--- 25-10-2024 16:12:25
--- MS_SQL_code
DROP PROCEDURE S_S;

--- 25-10-2024 16:12:28
--- MS_SQL_code
CREATE PROCEDURE S_S @TN VARCHAR(50), @N int = 10
AS
BEGIN
    DECLARE @query VARCHAR(1000)
    SET @query = 'SELECT TOP ' + CAST(@N AS VARCHAR(10)) + ' * FROM ' + QUOTENAME(@TN)
    EXEC (@query)
END;

--- 25-10-2024 16:12:31
--- MS_SQL_code
EXEC S_S @TN = 'Clusters';

--- 25-10-2024 16:12:59
--- MS_SQL_code
EXEC S_S @TN = Clusters;

--- 25-10-2024 16:14:33
--- MS_SQL_code
EXEC S_S @TN = Clusters, @N=1;

--- 25-10-2024 16:14:44
--- MS_SQL_code
S_S @TN = Clusters, @N=1;

--- 25-10-2024 16:14:54
--- MS_SQL_code
S_S @TN = Clusters, @N=2;

--- 25-10-2024 16:32:34
--- MS_SQL_code
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

--- 25-10-2024 16:35:06
--- MS_SQL_code
/***** ERROR ******
Error 208 Invalid object name 'Orders_stat'.
 ----- 
SELECT COUNT(*) FROM Orders_stat;
*****/

--- 25-10-2024 16:35:15
--- MS_SQL_code
Small_ETL @start='2023-05-01',@finish ='2023-12-01';

--- 25-10-2024 16:35:18
--- MS_SQL_code
SELECT COUNT(*) FROM Orders_stat;

--- 25-10-2024 16:35:38
--- MS_SQL_code
Small_ETL @start='2023-06-01',@finish ='2023-12-01', @to_del=1;

--- 25-10-2024 16:35:41
--- MS_SQL_code
SELECT COUNT(*) FROM Orders_stat;

--- 25-10-2024 16:36:14
--- MS_SQL_code
Small_ETL @start='2023-05-01',@finish ='2023-12-01';

--- 25-10-2024 16:36:18
--- MS_SQL_code
SELECT COUNT(*) FROM Orders_stat;

--- 25-10-2024 16:37:29
--- MS_SQL_code
SELECT * FROM Orders_stat;

--- 25-10-2024 16:39:57
--- MS_SQL_code
SELECT orderdate, COUNT(*) FROM Orders
GROUP by orderdate;

--- 25-10-2024 16:40:01
--- MS_SQL_code
SELECT orderdate, COUNT(*) FROM Orders
GROUP by orderdate;

--- 25-10-2024 16:42:28
--- MS_SQL_code
/***** ERROR ******
Error 102 Incorrect syntax near '('.
 ----- 
create table Orders2 as (ID int, date varchar(10));
*****/

--- 25-10-2024 16:42:55
--- MS_SQL_code
create table Orders2 (ID int, date varchar(10));

--- 25-10-2024 16:43:28
--- MS_SQL_code
SELECT * from Orders2;

--- 25-10-2024 16:44:39
--- MS_SQL_code
INSERT into Orders2
VALUES (1, '2023-01-01')



SELECT * from Orders2;

--- 25-10-2024 16:45:17
--- MS_SQL_code
/***** ERROR ******
Error 156 Incorrect syntax near the keyword 'SELECT'.
 ----- 
INSERT into Orders2
VALUES (1, '2023-01-01'),
(2, '2023-01-02'),


SELECT * from Orders2;
*****/

--- 25-10-2024 16:45:29
--- MS_SQL_code
INSERT into Orders2
VALUES (1, '2023-01-01'),
(2, '2023-01-02')


SELECT * from Orders2;

--- 25-10-2024 16:46:11
--- MS_SQL_code
DELETE FROM Orders2 where id=1;

--- 25-10-2024 16:46:14
--- MS_SQL_code
SELECT * from Orders2;

--- 25-10-2024 16:46:29
--- MS_SQL_code
DELETE FROM Orders2 where id=1 


SELECT * from Orders2;

--- 25-10-2024 16:46:39
--- MS_SQL_code
INSERT into Orders2
VALUES (1, '2023-01-01'),
(2, '2023-01-02');

--- 25-10-2024 16:46:42
--- MS_SQL_code
SELECT * from Orders2;

--- 25-10-2024 16:47:32
--- MS_SQL_code
update Orders2 set date='2023=01-05'WHERE ID=2;

--- 25-10-2024 16:47:35
--- MS_SQL_code
SELECT * from Orders2;

--- 25-10-2024 16:47:45
--- MS_SQL_code
update Orders2 set date='2023-01-05'WHERE ID=2;

--- 25-10-2024 16:47:47
--- MS_SQL_code
SELECT * from Orders2;

--- 25-10-2024 16:48:22
--- MS_SQL_code
DELETE from Orders2;

--- 25-10-2024 16:48:25
--- MS_SQL_code
SELECT * from Orders2;

--- 25-10-2024 16:58:45
--- MS_SQL_code
/***** ERROR ******
Error 156 Incorrect syntax near the keyword 'SELECT'.
 ----- 
create view view_stat as 
select OrderDate, count(*) from Orders o
group by OrderDate

SELECT * from view_stat vs
where OrderDate > '2023-07-05';
*****/

--- 25-10-2024 16:59:02
--- MS_SQL_code
/***** ERROR ******
Error 156 Incorrect syntax near the keyword 'SELECT'.
 ----- 
create view view_stat as 
select OrderDate, count(*) from Orders o
group by OrderDate

SELECT * from view_stat vs
where OrderDate > '2023-07-05';
*****/

--- 25-10-2024 17:01:31
--- MS_SQL_code
/***** ERROR ******
Error 156 Incorrect syntax near the keyword 'SELECT'.
 ----- 
CREATE VIEW view_stat AS 
SELECT OrderDate, COUNT(*) AS OrderCount 
FROM Orders o
GROUP BY OrderDate;

SELECT * FROM view_stat vs
WHERE OrderDate > '2023-07-05';
*****/

