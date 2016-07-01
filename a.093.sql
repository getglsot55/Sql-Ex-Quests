

-- Для каждой компании, перевозившей пассажиров, подсчитать время, которое провели в полете самолеты с пассажирами.
-- Вывод: название компании, время в минутах. 

-- cost 0.061480361968279 operations 9 
select company.name, sum(time_in_air)
from (
	select distinct trip.trip_no, Trip.ID_comp, Pass_in_trip.date, Trip.time_out, trip.time_in,
	datediff(minute, time_out, iif(time_out<=time_in, time_in, dateadd(day, 1, time_in))) as time_in_air
	from trip join Pass_in_trip on trip.trip_no = Pass_in_trip.trip_no) as t1
	join company on company.ID_comp = t1.ID_comp
group by company.name, company.ID_comp
