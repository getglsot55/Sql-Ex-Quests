


-- Определить имена разных пассажиров, которые летали
-- только между двумя городами (туда и/или обратно). 

--select dbo.Pass_in_trip.ID_psg, count(distinct town_from) as tf, count(distinct town_to) as tt
--from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no
--group by dbo.Pass_in_trip.ID_psg
--having count(distinct town_from) = count(distinct town_to) 

-- cost 0.094412282109261 operations 14 
with trp as (
select ID_psg, town_from, town_to
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no)
select dbo.Passenger.name
from (
select ID_psg, town_from as [town]
from trp
union
select ID_psg, town_to as [town]
from trp) tr join dbo.Passenger on Passenger.ID_psg = tr.ID_psg
group by tr.ID_psg, dbo.Passenger.name
having count(distinct tr.town) = 2

-- cost 1.2559515237808 operations 14 
select psg.name from
dbo.Passenger psg
where 
(select count(*) from
	(select distinct town_from 
	from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no where ID_psg = psg.ID_psg
	union 
	select distinct town_to 
	from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no where ID_psg = psg.ID_psg) te
) = 2

with cte as (select distinct town_from as [town] from dbo.Trip
union
select town_to from trip),
pit as (
select ID_psg,town_from, town_to
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no)
select distinct pit.ID_psg, cte.town
from pit join cte on pit.town_from = cte.town or pit.town_to = cte.town


with t1 as (
Select ID_psg, town_from, town_to,
 dense_rank()over(partition by ID_psg order by town_from) [n3],
 dense_rank()over(partition by ID_psg order by town_to) [n4]
FROM Pass_in_trip pt
join trip t on t.trip_no = pt.trip_no
)
select (select name from Passenger where ID_psg = a.ID_psg) [name]
from t1 a 
 left join t1 b on b.ID_psg = a.ID_psg and a.town_from = b.town_to
group by a.ID_psg
having count(a.ID_psg)=1 
 or (count(a.ID_psg)=count(b.ID_psg) and max(a.n3)<3 and max(a.n4)<3)
 or (max(a.n3)=1 and max(a.n4)=1)