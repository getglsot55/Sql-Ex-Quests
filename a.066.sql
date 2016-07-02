

-- Для всех дней в интервале с 01/04/2003 по 07/04/2003 определить число рейсов из Rostov. 
-- Вывод: дата, количество рейсов 

-- cost 0.0079185478389263 operations 20 
with ds as (
	select cast(datefromparts(2003, 04, 01) as datetime) as [tdate]
	union all
	select dateadd(day, 1 , [tdate]) from ds 
	where datepart(day, [tdate]) < 07),
tbd as (
	select [date], count(trip.trip_no) num
	from dbo.Trip join (select distinct trip_no, [date] from pass_in_trip) as rts on trip.[trip_no] = rts.[trip_no]
	where [date] >= datefromparts(2003, 04, 01) and [date] <= datefromparts(2003, 04, 07) and town_from = 'Rostov'
	group by [date])
select [tdate], coalesce(num, 0) as num
from ds left join tbd on ds.tdate = tbd.date


-- drafts
select sql_variant_property(datefromparts(2003, 04, 01),'BaseType')