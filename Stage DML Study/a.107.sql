


-- Для пятого по счету пассажира из числа вылетевших из Ростова в апреле 2003 года определить компанию, номер рейса и дату вылета.
-- Замечание. Считать, что два рейса одновременно вылететь из Ростова не могут. 

select dbo.Company.name, Pass_in_trip.trip_no, dbo.Pass_in_trip.[date]
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no join dbo.Company on Company.ID_comp = Trip.ID_comp
where town_from = 'Rostov' and year([date]) = 2003 and month([date]) = 4
order by [date], [time_out] offset 5 row fetch next 1 row only



select *
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no join dbo.Company on Company.ID_comp = Trip.ID_comp
where town_from = 'Rostov' and year([date]) = 2003 and month([date]) = 4
order by [date], [time_out] -- offset 5 row fetch next 1 row only


