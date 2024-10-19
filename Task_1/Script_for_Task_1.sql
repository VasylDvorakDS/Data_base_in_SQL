/*
Техническое задание

1. В каких странах проживают наши клиенты (таблица Customers)?
Сколько уникальных стран вы получили в ответе?
2. Сколько клиентов проживает в Argentina?
3. Посчитайте среднюю цену и количество товаров в 8 категории (таблица Products ).
Найдите количество товаров в 8 категории
4. Посчитайте средний возраст работников (таблица Employees)
5. Вам необходимо получить заказы, которые сделаны в течении 35 дней до даты 2023-10-10 (то есть с 5
сентября до 10 октября включительно). Использовать функцию DATEDIFF, определить переменные для
даты и диапазона.
Определите CustomerID, который оказался в первой строке запроса.
6. Вам необходимо получить количество заказов за сентябрь месяц (тремя способами, через LIKE, с
помощью YEAR и MONTH и сравнение начальной и конечной даты).
*/

-- Задания выполнены в MySQL

-- Задание 1: В каких странах проживают наши клиенты (таблица Customers)? Сколько уникальных стран вы получили в ответе?
SELECT DISTINCT Country as 'unique countries' FROM Customers c;
SELECT COUNT(DISTINCT Country) FROM Customers c;
/* Ответ: 21 уникальных страны
 
unique countries|
----------------+
Germany         |
Mexico          |
UK              |
Sweden          |
France          |
Spain           |
Canada          |
Argentina       |
Switzerland     |
Brazil          |
Austria         |
Italy           |
Portugal        |
USA             |
Venezuela       |
Ireland         |
Belgium         |
Norway          |
Denmark         |
Finland         |
Poland          |
*/


-- Задание 2: Сколько клиентов проживает в Argentina?
SELECT COUNT(CustomerName) FROM Customers c
		WHERE Country = 'Argentina'; 
-- Ответ: 3 клиента проживает в Argentina


	
-- Задание 3: Посчитайте среднюю цену и количество товаров в 8 категории (таблица Products ). Найдите количество товаров в 8 категории
SELECT AVG(Price) as 'average price',
	   COUNT(ProductName) as 'total products'
FROM Products p 
WHERE CategoryID = 8; 

-- Ответ: Средняя цена товаров восьмой категории 20.6825. Количество товаров в 8 категории 12

/* 
 average price|total products|
-------------+--------------+
      20.4167|            12|
  */

		
-- Задание 4: Посчитайте средний возраст работников (таблица Employees)
SELECT FLOOR(AVG(YEAR(CURDATE()) - YEAR(BirthDate))) AS 'Average Age' FROM Employees e; 


-- Ответ: Cредний возраст работников 66 лет

/* 
 Average Age|
-----------+
         66|
  */


/* Задание 5: Вам необходимо получить заказы, которые сделаны в течении 35 дней до даты 2023-10-10 (то есть с 5
сентября до 10 октября включительно). Использовать функцию DATEDIFF, определить переменные для
даты и диапазона.
Определите CustomerID, который оказался в первой строке запроса. */

SET @start = '2023-09-05';
SET @finish = '2023-10-10';
SELECT OrderID, CustomerID FROM Orders 
where orderdate 
BETWEEN @start AND @finish;


SET @start = '2023-09-05';
SET @finish = '2023-10-10';
SELECT CustomerID FROM Orders 
where orderdate 
BETWEEN @start AND @finish
limit 1;

/* Ответ:
 OrderID|CustomerID|
-------+----------+
  10298|        37|
  10299|        67|
  10300|        49|
  10301|        86|
  10302|        76|
  10303|        30|
  10304|        80|
  10305|        55|
  10306|        69|
  10307|        48|
  10308|         2|
  10309|        37|
  10310|        77|
  10311|        18|
  10312|        86|
  10313|        63|
  10314|        65|
  10315|        38|
  10316|        65|
  10317|        48|
  10318|        38|
  10319|        80|
  10320|        87|
  10321|        38|
  10322|        58|
  10323|        39|
  10324|        71|
  10325|        39|
  10326|         8|
 */



/* Задание 6: Вам необходимо получить количество заказов за сентябрь месяц (тремя способами, через LIKE, с
помощью YEAR и MONTH и сравнение начальной и конечной даты). */

select COUNT(OrderID) from orders o 
	where OrderDate like '%-09-%';
	
select COUNT(OrderID) from orders o 
	where month (OrderDate) ='09' and year (OrderDate) ='2023';


select COUNT(OrderID) from orders o 
	where  OrderDate between '2023-09-01' and '2023-09-30';

-- Ответ: количество заказов за сентябрь месяц 23

