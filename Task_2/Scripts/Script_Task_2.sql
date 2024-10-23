/*Техническое задание
1. Вам необходимо проверить влияние семейного
положения (family_status) на средний	доход
клиентов (income) и запрашиваемый кредит
(credit_amount) .
2. Сколько товаров в категории Meat/Poultry.
3. Какой товар (название) заказывали в сумме в
самом большом количестве (sum(Quantity) в
таблице OrderDetails)
*/

/*
 Задание 1:
Вам необходимо проверить влияние семейного
положения (family_status) на средний	доход
клиентов (income) и запрашиваемый кредит
(credit_amount) .
  */

select income, credit_amount, family_status from clusters c
group by family_status 
order by income, credit_amount;

/* Ответ:
 
 income|credit_amount|family_status|
------+-------------+-------------+
 21000|         7000|Another      |
 26000|        14500|Married      |
 31000|        10000|Unmarried    |
 
 */



/*
Задание 2:
Сколько товаров в категории Meat/Poultry.
*/

select 
sum(case when ProductName like '%Meat%' then 1 else 0 end) as 'cnt_Meat',
sum(case when ProductName like '%Poultry%' then 1 else 0 end) as 'cnt_Poultry'
from products; 

/* Ответ:
 
cnt_Meat|cnt_Poultry|
--------+-----------+
       1|          0|
 */


/*
Задание 3:
Какой товар (название) заказывали в сумме в
самом большом количестве (sum(Quantity) в
таблице OrderDetails)
*/

select ProductName from products p 
 where ProductID in 
 (select ProductID from orderdetails o 
 where o.Quantity = (select max(Quantity) from orderdetails))
 
 /* Ответ:
 
ProductName |
------------+
Pâté chinois|
 
 */
