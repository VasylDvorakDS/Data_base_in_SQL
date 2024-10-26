/*
Приджойним к данным о заказах данные о
покупателях. Данные, которые нас интересуют —
имя заказчика и страна, из которой совершается
покупка.
*/

select o.*, CustomerName, Country from customers c
join orders as o on c.CustomerID = c.CustomerID 


/*
 Проверить, Customer пришедшие из какой
страны совершили наибольшее число Orders. 
Используем сортировку по убыванию по полю
числа заказов. 
Вывести сверху в результирующей таблице
название лидирующей страны.
 */

select count(*) as cnt, Country from customers c 
join orders o on c.CustomerID =o.CustomerID
group by Country
order by cnt desc
limit 1


/*
 А теперь напишем запрос, который обеспечит
целостное представление деталей заказа, 
включая информацию как о клиентах, 
так и о сотрудниках. 
Будем использовать JOIN для соединения
информации из таблиц Orders, Customers 
и Employees.
 */

select * 
from customers c 
join orders o on c.CustomerID =o.CustomerID
join employees e on e.EmployeeID =o.EmployeeID 


/*
 Проанализировать
данные заказа, рассчитать ключевые показатели, 
связанные с выручкой, и соотнести результаты
с ценовой информацией из таблицы Products.
Давайте посмотрим на общую выручку, а также
минимальный, максимальный чек в разбивке
по странам.
 */

select 
c.Country ,
sum(p.Price * od.Quantity) as 'perfit_sum',
max(p.Price * od.Quantity) as 'perfit_max',
min(p.Price * od.Quantity) as 'perfit_min'
from customers c 
join orders o on c.CustomerID =o.CustomerID
join orderdetails od on od.OrderID = o.OrderID 
join products p on p.ProductID =od.ProductID 
group by c.Country 
order by perfit_sum desc

/*
Выведем имена покупателей, которые совершили
как минимум одну покупку 12 декабря
*/

select distinct c.CustomerName 
from customers c 
join orders o on c.CustomerID =o.CustomerID
where orderdate = '2023-12-12'

/*
 Напишем SQL-запрос для создания отчета
об исследовании продукта, показывающего
потенциальный интерес к каждому продукту
в разных странах. Используем CROSS JOIN 
операцию для создания комбинаций стран и
продуктов. 
Это PotentialInterest должно представлять собой
гипотетическую оценку, основанную на общем
количестве клиентов из этой страны, которые могут
быть заинтересованы в конкретном продукте.
CROSS JOIN создаёт все возможные комбинации
стран и названий продуктов.
 */

SELECT
c.Country,
p.ProductName,
p.Price,
COUNT(DISTINCT c.CustomerID) AS PotentialInterestScore
FROM
Customers  c
CROSS JOIN
Products p
GROUP BY
c.Country, p.ProductName, p.Price;

/*
 Проанализируем разнообразие
поставщиков в категориях продуктов. 
Необходим SQL-запрос для определения
поставщиков, предлагающих широкий
ассортимент продукции в разных категориях.
 */
SELECT
s.SupplierID,
s.SupplierName,
s.Country,
COUNT(DISTINCT p.CategoryID) AS ProductCategoryDiversity
FROM
Suppliers s
JOIN
Products p ON s.SupplierID = p.SupplierID
GROUP BY
s.SupplierID, s.SupplierName, s.Country
ORDER BY
ProductCategoryDiversity DESC


/*
 Наша компания заинтересована в том, чтобы
понять, в каких странах появились новые
клиенты, которые еще не разместили заказы. 
Напишите SQL-запрос, позволяющий
идентифицировать страны, в которых клиенты
зарегистрировались, но не сделали заказов.
 */
WITH Cust AS (
    SELECT c.*
    FROM Customers c
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Orders o 
        WHERE c.CustomerID = o.CustomerID))
SELECT country, COUNT(DISTINCT customerid)
FROM Cust
GROUP BY country;

/*
Наша компания хочет выявить
клиентов, которые приобрели товары как
стоимостью менее 30, так и стоимостью более
150 долларов США. 
Напишите запрос SQL, INTERSECT чтобы найти
клиентов, которые делали покупки в обоих этих
ценовых диапазонах.
 */

SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
JOIN OrderDetails AS od ON o.OrderID = od.OrderID
JOIN Products AS p ON od.ProductID = p.ProductID
WHERE p.Price < 30
  AND c.CustomerID IN (
      SELECT c2.CustomerID
      FROM Customers AS c2
      JOIN Orders AS o2 ON c2.CustomerID = o2.CustomerID
      JOIN OrderDetails AS od2 ON o2.OrderID = od2.OrderID
      JOIN Products AS p2 ON od2.ProductID = p2.ProductID
      WHERE p2.Price > 150
  );
 
 /*
  Cоздать набор
результатов, который включает уникальные
записи о клиентах как для США, так и для
Канады. 
  */
 
 select CustomerID, CustomerName from Customers
where Country = 'USA'
UNION 
select CustomerID, CustomerName from Customers
where Country = 'Canada';

