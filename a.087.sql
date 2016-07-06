
-- —чита€, что пункт самого первого вылета пассажира €вл€етс€ местом жительства, найти не москвичей, которые прилетали в ћоскву более одного раза. 
-- ¬ывод: им€ пассажира, количество полетов в ћоскву 

-- cost 0.16776588559151 operations 25 
with t1 as (
select dbo.Pass_in_trip.[ID_psg], dbo.Trip.town_from, [time_out]
from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no
where [date] = (select min([date]) from dbo.Pass_in_trip pit where pit.ID_psg = dbo.Pass_in_trip.ID_psg)),
t2 as (
	select t1.ID_psg, t1.town_from
	from t1
	where t1.time_out	= (select min(tt1.time_out) from t1 as tt1 where tt1.ID_psg = t1.ID_psg))
select 
	dbo.Passenger.[name], 
	count(dbo.Pass_in_trip.[trip_no]) qty
from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no join dbo.Passenger on Passenger.ID_psg = Pass_in_trip.ID_psg
	join t2 on t2.ID_psg = Passenger.ID_psg
where town_to = 'Moscow' and t2.town_from <> 'Moscow'
group by dbo.Passenger.ID_psg, dbo.Passenger.name
having count(dbo.Pass_in_trip.[trip_no]) > 1