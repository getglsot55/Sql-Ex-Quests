
-- Ќайти производителей, у которых больше всего моделей в таблице Product, а также тех, у которых меньше всего моделей.
-- ¬ывод: maker, число моделей 

-- cost 0.065286383032799 operations 14 
with t1 as (
	select top 1 with ties maker, count(model) as cnt
	from dbo.Product
	group by maker
	order by count(model) desc),
t2 as (
	select top 1 with ties maker, count(model) as  cnt
	from dbo.Product
	group by maker
	order by count(model))
select * from t1 
union 
select * from t2;

-- cost 0.016062099486589 operations 12 
with t1 as (
	select maker, count(model) as cnt,
		max(count(model)) over() vmax,
		min(count(model)) over() vmin
	from dbo.Product
	group by maker)
select t1.maker, t1.cnt
from t1
where t1.cnt = t1.[vmax] or t1.cnt = t1.[vmin];