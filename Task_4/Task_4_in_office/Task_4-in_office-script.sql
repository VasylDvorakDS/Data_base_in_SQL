/*
 Рассчитайте среднее количество товаров, 
заказанных каждым покупателем (используя
оконную функцию).
 */

select 
avg(Quantity),
CustomerID
from orders o 
join orderdetails od on od.OrderID =od.OrderID 
group by o.CustomerID 


select distinct 
avg(Quantity) over(partition by o.CustomerID) as AvgQuantity,
CustomerID
from orders o 
join orderdetails od on od.OrderID =od.OrderID 


/*
Определите первую и последнюю даты
заказа для каждого клиента
*/

select 
min(OrderDate),
max(OrderDate),
count(*), 
CustomerID 
from orders o 
group by CustomerID 


select distinct 
min(OrderDate) over(partition by CustomerID) as min_date,
max(OrderDate) over(partition by CustomerID) as max_date,
count(*) over(partition by CustomerID) as cnt, 
CustomerID 
from orders o 


/*
 Получите общее количество заказов для
каждого клиента, а также имя и город клиента.
 */

select distinct 
c.CustomerID,
City,
orderdate,
count(*) over(partition by c.CustomerID) as cnt
from orders o 
join customers c on o.CustomerID =c.CustomerID



select distinct 
c.CustomerID,
City,
orderdate,
count(*)
from orders o 
join customers c on o.CustomerID =c.CustomerID
group by c.CustomerID, City 


/*
 Ранжируйте сотрудников на основе общего
количества обработанных ими заказов.
 */

select 
o.EmployeeID,
rank()over(order by count(orderid) ) as 'EmploierRank'
from orders o
group by o.EmployeeID 


/*
Определите среднюю цену товаров внутри
каждой категории, рассматривая только
категории, в которых более девяти товаров.
 */

with product_prices as(
select distinct 
CategoryID,
avg(Price) over(partition by CategoryID) as avg_price,
count(ProductID) over (partition by CategoryID) as cnt 
from products p)

select *
from product_prices
where cnt>9


/*
 Рассчитайте процент от общего объема (выручки) 
продаж каждого продукта в своей категории.
 */

select 
productname,
round((sum(price*Quantity)/ sum(sum(price*Quantity)) over(partition by CategoryId)) *100,1) as cash
from orderdetails od 
join products p on p.ProductID = od.ProductID 
group by p.ProductID, CategoryID 


/*
 Для каждого заказа сделайте новую колонку
в которой определите общий объем продаж
за каждый месяц, учитывая все годы.
 */

select distinct 
year(o.orderdate) as Year,
month(o.orderdate) as Month,
sum(od.Quantity*p.Price) over (partition by month(o.OrderDate),
year(o.OrderDate) order by year(o.orderdate)) as TotalSales
from orders o 
join orderdetails od on o.OrderID = od.OrderID 
join products p on p.ProductID =od.ProductID 
order by year, month 


/*
 Вам поручено анализировать совокупные продажи в
двух европейских городах (Лондоне и Мадриде) к
концу каждой недели с начала апреля 2023 года. 
Используйте оконные функции SQL для расчета и
отслеживания совокупных продаж с течением
времени в этих двух городах.
 */

select 
OrderDate,
City,
SUM(Quantity) over (partition by City 
order by OrderDate) as CumulativeSales
from (
select
o.OrderDate,
c.City,
od.Quantity
from Orders o
join Customers c on o.CustomerID = 
c.CustomerID
join OrderDetails od on o.OrderID = 
od.OrderID
where (c.City = 'London' or c.City = 'Madrid')
and o.OrderDate >= '2023-04-01'
) as CumulativeSales
order by orderdate


/*
Рассчитайте промежуточную сумму заказанных
количеств для каждого продукта.
 */
select 
OrderID,
ProductID,
Quantity,
SUM(Quantity) over (partition by ProductID order by OrderID) as RunningTotal
FROM OrderDetails

/*
 Рассчитайте разницу в общем объеме продаж за
каждый день по сравнению с предыдущим днем.
 */

select
	OrderDate, 
	SUM(Quantity * Price) as DailySales,
	lag(SUM(Quantity * Price)) over (order by OrderDate) as PreviousDaySales, 
	SUM(Quantity * Price) - lag(SUM(Quantity * Price)) over (order by OrderDate) as SalesDifference
from Orders
join OrderDetails on Orders.OrderID = OrderDetails.OrderID
join Products on OrderDetails.ProductID =  Products.ProductID
group by OrderDate

/*
 Рассчитайте среднюю стоимость заказа для
каждого сотрудника, учитывая только заказы
после 01-01-2023.
 */

select
	e.EmployeeID,
	AVG(TotalAmount) over (partition by e.EmployeeID) as AvgOrderValue
from (select
		o.EmployeeID,
		o.OrderID,
		SUM(od.Quantity * p.Price) over (partition by o.OrderID) as TotalAmount
	from Orders o
	join OrderDetails od on o.OrderID = od.OrderID
	join Products p on od.ProductID = p.ProductID
	where OrderDate >= '01-01-2023') as e
