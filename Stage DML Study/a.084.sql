
-- Для каждой компании подсчитать количество перевезенных пассажиров (если они были в этом месяце) по декадам апреля 2003.
-- При этом учитывать только дату вылета. 
-- Вывод: название компании, количество пассажиров за каждую декаду 

-- cost 0.047272656112909 operations 9 
with t1 as (select dbo.Company.name,
sum(case when [date] >= datefromparts(2003, 4, 1) and [date] <= datefromparts(2003, 4, 10) then 1 else 0 end) as [1-10],
sum(case when [date] >= datefromparts(2003, 4, 11) and [date] <= datefromparts(2003, 4, 20) then 1 else 0 end) as [10-20],
sum(case when [date] >= datefromparts(2003, 4, 21) and [date] <= datefromparts(2003, 4, 30) then 1 else 0 end) as [20-30]
from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no join dbo.Company on Company.ID_comp = Trip.ID_comp
group by dbo.Company.ID_comp, dbo.Company.name)
select *
from t1 
where t1.[1-10] > 0 or t1.[10-20] > 0 or t1.[20-30] > 0;