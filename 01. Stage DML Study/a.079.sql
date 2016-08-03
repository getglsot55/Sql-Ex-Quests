

-- Определить пассажиров, которые больше других времени провели в полетах. 
-- Вывод: имя пассажира, общее время в минутах, проведенное в полетах 


-- cost 0.067926518619061 operations 11 
select top 1 with ties dbo.Passenger.name,
sum(datediff(minute, [time_out], iif([time_in] >= [time_out], [time_in], dateadd(day, 1, [time_in])))) as tit
from pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no join dbo.Passenger on Passenger.ID_psg = Pass_in_trip.ID_psg
group by dbo.Passenger.ID_psg, dbo.Passenger.name
order by sum(datediff(minute, [time_out], iif([time_in] >= [time_out], [time_in], dateadd(day, 1, [time_in])))) desc;


-- cost 0.067926518619061 operations 11 
with t1 as (
	select dbo.Passenger.name,
	sum(datediff(minute, [time_out], iif([time_in] >= [time_out], [time_in], dateadd(day, 1, [time_in])))) as tit
	from pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no join dbo.Passenger on Passenger.ID_psg = Pass_in_trip.ID_psg
	group by dbo.Passenger.ID_psg, dbo.Passenger.name)
select top 1 with ties name, tit
from t1
order by tit desc;