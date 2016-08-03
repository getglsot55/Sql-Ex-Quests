

-- Вывести все записи из Outcome и Income, даты которых отстоят не менее чем на 2 календарных месяца 
-- от максимальной даты в обеих таблицах (т.е. при максимальной дате 2009-12-05 последняя выводимая дата должна быть меньше 2009-10-01).
-- Выполнить помесячное разбиение этих записей, присвоив порядковый номер каждому месяцу (с учётом года), попавшему в выборку.
-- Вывод: порядковый номер месяца, первый день месяца в формате "yyyy-mm-dd", 
-- последний день месяца в формате "yyyy-mm-dd", код записи, пункт, дата, сумма (для таблицы Outcome должна быть отрицательной);


-- cost 0.036231175065041 operations 18 

with cte as (
select date, code, point, -out as [sum] from Outcome
union all
select date, code, point, inc as sum from Income)
select
dense_rank() over(order by year(date), month(date)),
cast(DATEADD(month, DATEDIFF(month, 0, date), 0) as date) as [startDate],
eomonth(date) as [endDate], code, point, date,
[sum]
from cte
where date < (select dateadd(d, 1, eomonth(dateadd(m, -3, max(date)))) from cte)
order by date;