

-- Среди тех, кто пользуется услугами только одной компании, определить имена разных пассажиров, летавших чаще других. 
-- Вывести: имя пассажира, число полетов и название компании. 


-- cost 0.096719481050968 operations 25 
with t1 as (
	select ID_psg,
		count(distinct dbo.trip.ID_comp) as cc,
		max(trip.ID_comp) as comp,
		count(distinct convert(varchar(24), [date], 121) + '_' + convert(varchar(24), [time_out], 121)) as ct
		from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no
	group by ID_psg)
select top 1 with ties dbo.Passenger.[name], ct, dbo.Company.name
from t1 join dbo.Passenger on Passenger.ID_psg = t1.ID_psg join dbo.Company on dbo.Company.ID_comp = t1.comp
where cc = 1
order by ct desc;


-- cost 0.093034960329533 operations 26 
with t1 as (select dbo.Passenger.[name],
	count(distinct convert(varchar(24), [date], 121) + '_' + convert(varchar(24), [time_out], 121)) as ct,
	max(trip.ID_comp) as comp
	from dbo.Pass_in_trip join trip on Trip.trip_no = Pass_in_trip.trip_no 
		join dbo.Passenger on Passenger.ID_psg = Pass_in_trip.ID_psg
group by dbo.Passenger.[ID_psg], dbo.Passenger.[name]
having count(distinct dbo.trip.ID_comp) = 1)
select top 1 with ties t1.[name], t1.ct, dbo.Company.name
from t1 join dbo.Company on Company.ID_comp = t1.comp
order by ct desc

SELECT (SELECT name FROM Passenger WHERE id_psg=Psg1Comp.id_psg) as psgName,qtdTrip, 
       (SELECT name FROM Company WHERE id_comp=Psg1Comp.id_comp) as CompName
FROM (
 SELECT PT.id_psg,
        COUNT(*) as qtdTrip,
        MAX(COUNT(*)) OVER() as qtdMaxTrip,
        MAX(id_comp) as id_comp
 FROM Pass_in_Trip PT JOIN Trip T ON(PT.trip_no =T.trip_no)
 GROUP BY PT.id_psg  HAVING MIN(id_comp) = MAX(id_comp)
) Psg1Comp 
WHERE qtdTrip=qtdMaxTrip