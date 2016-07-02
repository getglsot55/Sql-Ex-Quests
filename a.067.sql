

-- Найти количество маршрутов, которые обслуживаются наибольшим числом рейсов.
-- Замечания. 
-- 1) A - B и B - A считать РАЗНЫМИ маршрутами.
-- 2) Использовать только таблицу Trip

-- cost 0.027798492461443 operations 9 
with tmc as (
	select town_from, town_to, count(trip_no) as cnt
	from dbo.Trip
	group by town_from, town_to)
select count(*)
from tmc
where cnt = (select max(cnt) from tmc);

-- cost 0.017890842631459 operations 14 
with tmc as (
	select town_from, town_to, count(trip_no) as cnt, max(count(trip_no)) over () as max
	from dbo.Trip
	group by town_from, town_to)
select count(*) as qnty
from tmc
where cnt = max;
