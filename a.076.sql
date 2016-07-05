
-- Определить время, проведенное в полетах, для пассажиров, летавших всегда на разных местах.
-- Вывод: имя пассажира, время в минутах. 

-- cost 0.047292646020651 operations 19 
with t1 as (select ID_psg, max(count(place)) over(partition by ID_psg) as maxplace,
sum(datediff(minute,iif(time_out < time_in, time_out, dateadd(day,-1, time_out)),time_in)) as ft
from pass_in_trip join trip on pass_in_trip.trip_no = trip.trip_no
group by ID_psg, place)
select name, sum(ft)
from t1 join dbo.Passenger on t1.ID_psg = dbo.Passenger.ID_psg
where t1.maxplace = 1
group by dbo.Passenger.ID_psg, dbo.Passenger.name


-- cost 0.087690122425556 operations 16 
select [name],
sum(datediff(minute,iif(time_out < time_in, time_out, dateadd(day,-1, time_out)),time_in))
from dbo.Passenger join (select distinct ID_psg
from (select ID_psg, place, count(place) as cp
	from pass_in_trip
	group by ID_psg, place) as t1
group by t1.ID_psg
having max(cp) = 1) as t2 on dbo.Passenger.ID_psg = t2.ID_psg
join dbo.Pass_in_trip on Pass_in_trip.ID_psg = t2.ID_psg join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no
group by dbo.Passenger.ID_psg, dbo.Passenger.name



-- drafts 
select ID_psg,
datediff(minute,iif(time_out < time_in, time_out, dateadd(day,-1, time_out)),time_in) as ft
from pass_in_trip join trip on pass_in_trip.trip_no = trip.trip_no
where ID_psg = 10

select distinct ID_psg, max(count(place)) over(partition by ID_psg) as maxplace
from pass_in_trip
group by ID_psg, place

select ID_psg, max(count(place)) over(partition by ID_psg) as maxplace,
sum(datediff(minute,iif(time_out < time_in, time_out, dateadd(day,-1, time_out)),time_in)) as ft
from pass_in_trip join trip on pass_in_trip.trip_no = trip.trip_no
group by ID_psg, place
