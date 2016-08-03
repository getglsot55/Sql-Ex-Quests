


-- Посчитать сумму цифр в номере каждой модели из таблицы Product
-- Вывод: номер модели, сумма цифр
-- Для этой задачи запрещено использовать: CTE


-- cost 0.1165714636445 operations 7 
select 
p.[model],
sum(case when substring(p.[model], n, 1) like '[0-9]' then cast(substring(p.[model], n, 1) as int) else 0 end) as digits_sum
from (
 select t1.[n] + t2.[n]*10 as [dig] from 
  (select [n] from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) as t(n)) as t1
   cross join 
  (select [n] from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) as t(n)) as t2
) AS I(n)
cross join [dbo].[Product] [p] group by p.[model];


select t1.[n] + t2.[n]*10 as [dig] from 
  (select [n] from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) as t(n)) as t1
   cross join 
  (select [n] from (values(0),(1),(2),(3),(4)) as t(n)) as t2
  order by [dig];


select model,
(datalength(model)-datalength(REPLACE(model, '1', '')))*1 +
(datalength(model)-datalength(REPLACE(model, '2', '')))*2 +
(datalength(model)-datalength(REPLACE(model, '3', '')))*3 +
(datalength(model)-datalength(REPLACE(model, '4', '')))*4 +
(datalength(model)-datalength(REPLACE(model, '5', '')))*5 +
(datalength(model)-datalength(REPLACE(model, '6', '')))*6 +
(datalength(model)-datalength(REPLACE(model, '7', '')))*7 +
(datalength(model)-datalength(REPLACE(model, '8', '')))*8 +
(datalength(model)-datalength(REPLACE(model, '9', '')))*9
from product