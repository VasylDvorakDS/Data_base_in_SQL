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
GROUP BY o.OrderID; 

/*
 Ответ:
 
 OrderID|avg_price|
-------+---------+
  10413|   881.33|
  10406|   500.20|
  10370|   486.67|
/-/-/-/-/-/-/-/-/-/-/
  10320|   630.00|
  10274|   329.00|
  10381|   140.00| 
 */

/*
Задание 2: Посчитать сколько заказов доставляет в месяц
каждая служба доставки. 
Определите, сколько заказов доставила United 
Package в декабре 2023 года
*/

WITH shippers_statistic AS (SELECT s.ShipperName , MONTH(o.OrderDate) AS 'month', YEAR(o.OrderDate) as 'year', count(OrderID) AS 'cnt_orders' FROM orders o 
JOIN shippers s ON o.ShipperID =s.ShipperID
GROUP BY o.ShipperID, MONTH(o.OrderDate), YEAR(o.OrderDate))

-- SELECT * FROM shippers_statistic;

SELECT * FROM shippers_statistic
WHERE YEAR ='2023' AND MONTH = '12' AND ShipperName = 'United Package';

/*
 Ответ:
 
 ShipperName     |month|year|cnt_orders|
----------------+-----+----+----------+
Federal Shipping|    7|2023|        18|
Speedy Express  |    7|2023|        14|
United Package  |    7|2023|        12|
Speedy Express  |    8|2023|        18|
United Package  |    8|2023|        16|
Federal Shipping|    8|2023|        16|
United Package  |    9|2023|        30|
Speedy Express  |    9|2023|         6|
Federal Shipping|    9|2023|        10|
United Package  |   10|2023|        20|
Federal Shipping|   10|2023|        20|
Speedy Express  |   10|2023|        12|
United Package  |   11|2023|        18|
Federal Shipping|   11|2023|        20|
Speedy Express  |   11|2023|        12|
United Package  |   12|2023|        16|
Speedy Express  |   12|2023|        14|
Federal Shipping|   12|2023|        32|
Federal Shipping|    1|2024|        16|
Speedy Express  |    1|2024|        28|
United Package  |    1|2024|        22|
Federal Shipping|    2|2024|         4|
United Package  |    2|2024|        14|
Speedy Express  |    2|2024|         4|


ShipperName   |month|year|cnt_orders|
--------------+-----+----+----------+
United Package|   12|2023|        16|
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


/*
Ответ:
CustomerName                      |LTV     |
----------------------------------+--------+
Ana Trujillo Emparedados y helados|  222.00|
Antonio Moreno Taquería           | 1008.00|
Around the Horn                   | 3390.00|
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
White Clover Markets              | 8740.00|
Wilman Kala                       | 1124.00|
Wolski                            | 1110.00|
 */
