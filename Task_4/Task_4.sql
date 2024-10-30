/*
1.Ранжируйте продукты (по ProductRank) в каждой
категории на основе их общего объема продаж
(TotalSales).
2. Обратимся к таблице Clusters
Рассчитайте среднюю сумму кредита (AvgCreditAmount) для
каждого кластера и месяца, учитывая общую среднюю сумму
кредита за соответствующий месяц (OverallAvgCreditAmount).
Определите OverallAvgCreditAmount в первой строке
результатов запроса.
3.Сопоставьте совокупную сумму сумм кредита
(CumulativeSum) для каждого кластера, упорядоченную по
месяцам, и сумму кредита в порядке возрастания.
Определите CumulativeSum в первой строке результатов
запроса
*/

/*
Задание 1.Ранжируйте продукты (по ProductRank) в каждой
категории на основе их общего объема продаж
(TotalSales).
*/
with summa as(
select distinct  p.CategoryID, p.productid, p.ProductName,
sum(o.orderid) as 'sum'
from products p 
join orderdetails o on p.ProductID =o.ProductID 
group by p.CategoryID, p.productid, p.ProductName
)

select *,
rank() over (partition by s.Categoryid order by sum desc) as 'rank_sum'
from summa s


/*
 Ответ:
 
 CategoryID|productid|ProductName                     |sum   |rank_sum|
----------+---------+--------------------------------+------+--------+
         1|        2|Chang                           |113765|       1|
         1|       24|Guaraná Fantástica              |113484|       2|
         1|       76|Lakkalikööri                    |103554|       3|
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-
         8|       37|Gravad lax                      | 31004|      10|
         8|       73|Röd Kaviar                      | 20698|      11|
         8|       45|Røgede sild                     | 10388|      12|
 
 */



/* 
Задание 2. Обратимся к таблице Clusters
Рассчитайте среднюю сумму кредита (AvgCreditAmount) для
каждого кластера и месяца, учитывая общую среднюю сумму
кредита за соответствующий месяц (OverallAvgCreditAmount).
Определите OverallAvgCreditAmount в первой строке
результатов запроса.
*/

with overall_sum as(select month, cluster,
round(avg(credit_amount) over (partition by c.month),2) as 'OverallAvgCreditAmount'
from clusters c), 
avg_over as(select distinct 
cluster,
month,
OverallAvgCreditAmount,
round(avg(OverallAvgCreditAmount) over (partition by cluster),2) as 'AvgCreditAmount_cluster',
round(avg(OverallAvgCreditAmount) over (partition by month),2) as 'AvgCreditAmount_month'
from overall_sum
group by cluster, month
order by cluster, month),
avg_over_first as (select OverallAvgCreditAmount 
from avg_over
limit 1
)


select * from avg_over
select * from avg_over_first

/*
 Ответ:
 cluster|month|OverallAvgCreditAmount|AvgCreditAmount_cluster|AvgCreditAmount_month|
-------+-----+----------------------+-----------------------+---------------------+
      0|    1|              26194.24|               29123.29|             26194.24|
      0|    2|              30181.16|               29123.29|             30181.16|
      0|    3|              28443.04|               29123.29|             28443.04|
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
      6|    8|              28725.35|               29014.94|             28725.35|
      6|    9|              26272.06|               29014.94|             26272.06|
      6|   10|              29112.50|               29014.94|             29112.50|
      6|   11|              32574.71|               29014.94|             32574.71|
      
      
OverallAvgCreditAmount|
----------------------+
              26194.24|
 
 */



/* Задание 3.Сопоставьте совокупную сумму сумм кредита
(CumulativeSum) для каждого кластера, упорядоченную по
месяцам, и сумму кредита в порядке возрастания.
Определите CumulativeSum в первой строке результатов
запроса
*/
with sum_credit as (select distinct cluster, month,
sum(c.credit_amount) over(partition by c.cluster order by month) as CumulativeSum
from clusters c) 

select * from sum_credit

select CumulativeSum from sum_credit
limit 1


/*
 Ответ:
 
 cluster|month|CumulativeSum|
-------+-----+-------------+
      0|    1|       234000|
      0|    2|       705500|
      0|    3|      1078000|
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
      6|    9|       997000|
      6|   10|      1406000|
      6|   11|      1413500|
      
      
CumulativeSum|
-------------+
       234000| 
 */
