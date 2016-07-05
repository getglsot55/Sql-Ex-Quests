

-- Определить дни, когда было выполнено максимальное число рейсов из
-- Ростова ('Rostov'). Вывод: число рейсов, дата. 

-- cost 0.022388862445951 operations 17 
with t1 as (
select trip.trip_no, [date], cast(Pass_in_trip.trip_no as varchar(12)) + '_' + convert(varchar(24), dbo.Trip.time_out, 126) tk
from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no
where town_from = 'Rostov'),
t2 as (select	count(distinct tk) as qty,
	[date], max(count(distinct tk)) over() as mt
from t1
group by t1.date)
select qty, [date]
from t2
where t2.qty = t2.mt;

-- cost 0.032931379973888 operations 11 
select top 1 with ties 
	count(distinct cast(Pass_in_trip.trip_no as varchar(12)) + '_' + convert(varchar(24), dbo.Trip.time_out, 126)) as qty,
	[date]
from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no
where town_from = 'Rostov'
group by [date]
order by count(distinct cast(Pass_in_trip.trip_no as varchar(12)) + '_' + convert(varchar(24), dbo.Trip.time_out, 126)) desc;

-- cost 0.032931379973888 operations 11 
with t1 as (
select trip.trip_no, [date], cast(Pass_in_trip.trip_no as varchar(12)) + '_' + convert(varchar(24), dbo.Trip.time_out, 126) tk
from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no
where town_from = 'Rostov')
select top 1 with ties 
	count(distinct tk) as qty,
	[date]
from t1
group by [date]
order by count(distinct t1.tk) desc;