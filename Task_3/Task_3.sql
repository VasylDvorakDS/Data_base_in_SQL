/*
1. Посчитать средний чек одного заказа.
2. Посчитать сколько заказов доставляет в месяц
каждая служба доставки. 
Определите, сколько заказов доставила United 
Package в декабре 2023 года
3. Определить средний LTV покупателя (сколько
денег покупатели в среднем тратят в магазине
за весь период)
*/

/*
Задание 1: Посчитать средний чек одного заказа.
*/
SELECT o.OrderID ,ROUND(AVG(p.Price * o.Quantity),2) AS 'avg_price' FROM orderdetails o 
JOIN products p ON p.ProductID =o.ProductID 
GROUP BY o.OrderID
ORDER BY o.OrderID; 

/*
 Ответ:
 
OrderID|avg_price|
-------+---------+
  10248|   187.33|
  10249|  1163.50|
  10250|   753.33|
/-/-/-/-/-/-/-/-/-/
  10441|  2150.00|
  10442|   736.67|
  10443|   333.00|
 */

/*
Задание 2: Посчитать сколько заказов доставляет в месяц
каждая служба доставки. 
Определите, сколько заказов доставила United 
Package в декабре 2023 года
*/

WITH shippers_statistic AS (SELECT s.ShipperName, YEAR(o.OrderDate) as 'year' , MONTH(o.OrderDate) AS 'month', count(OrderID) AS 'cnt_orders' FROM orders o 
JOIN shippers s ON o.ShipperID =s.ShipperID
GROUP BY o.ShipperID, YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY s.ShipperName, YEAR(o.OrderDate), MONTH(o.OrderDate))

-- SELECT * FROM shippers_statistic;

SELECT * FROM shippers_statistic
WHERE YEAR ='2023' AND MONTH = '12' AND ShipperName = 'United Package';

/*
 Ответ:
 
ShipperName     |year|month|cnt_orders|
----------------+----+-----+----------+
Federal Shipping|2023|    7|        18|
Federal Shipping|2023|    8|        16|
Federal Shipping|2023|    9|        10|
Federal Shipping|2023|   10|        20|
Federal Shipping|2023|   11|        20|
Federal Shipping|2023|   12|        32|
Federal Shipping|2024|    1|        16|
Federal Shipping|2024|    2|         4|
Speedy Express  |2023|    7|        14|
Speedy Express  |2023|    8|        18|
Speedy Express  |2023|    9|         6|
Speedy Express  |2023|   10|        12|
Speedy Express  |2023|   11|        12|
Speedy Express  |2023|   12|        14|
Speedy Express  |2024|    1|        28|
Speedy Express  |2024|    2|         4|
United Package  |2023|    7|        12|
United Package  |2023|    8|        16|
United Package  |2023|    9|        30|
United Package  |2023|   10|        20|
United Package  |2023|   11|        18|
United Package  |2023|   12|        16|
United Package  |2024|    1|        22|
United Package  |2024|    2|        14|


ShipperName   |year|month|cnt_orders|
--------------+----+-----+----------+
United Package|2023|   12|        16|
 */

/*
Задание 3: Определить средний LTV покупателя (сколько
денег покупатели в среднем тратят в магазине
за весь период)
 */

SELECT CustomerName ,ROUND(SUM(Quantity * Price)/COUNT(DISTINCT CustomerName),2) AS LTV FROM customers c 
JOIN orders o ON c.CustomerID =o.CustomerID
JOIN orderdetails od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
GROUP BY c.CustomerName 
ORDER BY LTV DESC;

/*
Ответ:
CustomerName                      |LTV     |
----------------------------------+--------+
Ernst Handel                      |70338.00|
Mère Paillarde                    |46514.00|
Save-a-lot Markets                |44580.00|
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
Centro comercial Moctezuma        |  252.00|
Ana Trujillo Emparedados y helados|  222.00|
Franchi S.p.A.                    |  124.00|
 */
