

-- Найти количество маршрутов, которые обслуживаются наибольшим числом рейсов.
-- Замечания. 
-- 1) A - B и B - A считать ОДНИМ И ТЕМ ЖЕ маршрутом.
-- 2) Использовать только таблицу Trip

-- cost 0.0159130115062 operations 15 
with ptrips as (
	select trip_no,
		replace((case when town_from > town_to then town_from + town_to else town_to + town_from end), ' ', '') as townkey
	from trip),
ctrips as (
	select townkey, count(trip_no) as cnt, max(count(trip_no)) over () as max
	from ptrips
	group by ptrips.townkey)
select count(*) as qty
from ctrips where cnt = max