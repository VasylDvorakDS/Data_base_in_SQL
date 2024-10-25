create view view_stat as 
select OrderDate, count(*) from Orders o
group by OrderDate
