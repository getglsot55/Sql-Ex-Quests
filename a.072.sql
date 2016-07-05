
-- Среди тех, кто пользуется услугами только какой-нибудь одной компании,
-- определить имена разных пассажиров, летавших чаще других. 
-- Вывести: имя пассажира и число полетов. 

-- cost 0.09933427721262  operations 20 
select top 1 with ties name, t1.ct
from passenger 
 join 
	(select distinct id_psg, count(distinct ID_comp) as ccomp,
	count(*) as ct --, max(count(date)) over() as tmax
	from dbo.Pass_in_trip left join trip on pass_in_trip.trip_no=trip.trip_no
	group by id_psg)
as t1 on dbo.Passenger.ID_psg = t1.ID_psg
where t1.ccomp = 1
order by ct desc;


-- drafts 
-- cost 0.09933427721262 operations 20 
with tps as (
	select distinct id_psg, count(distinct ID_comp) as ccomp,
	count(date) as ct, max(count(date)) over() as tmax
from dbo.Pass_in_trip left join trip on pass_in_trip.trip_no=trip.trip_no
group by id_psg)
select top 1 with ties dbo.Passenger.name, tps.ct
from tps join dbo.Passenger on tps.ID_psg = dbo.Passenger.ID_psg
where tps.ccomp=1 --and tps.ct = tps.tmax
order by ct desc;

-- cost 0.050389043986797 operations 16 
with pit as (select dbo.Passenger.name,
(select count(distinct ID_comp) from dbo.Pass_in_trip join dbo.Trip
	on dbo.Pass_in_trip.trip_no = dbo.Trip.trip_no
	 where dbo.Pass_in_trip.ID_psg = dbo.Passenger.ID_psg) as cc,
	(select count([date])
	from dbo.Pass_in_trip where dbo.Pass_in_trip.ID_psg = dbo.Passenger.ID_psg) as ct
from dbo.Passenger)
select top 1 with ties name, ct
from pit
where cc = 1
order by ct desc;


-- cost cost 0.078060902655125 operations 29 
with pit as (select dbo.Passenger.name,
(select count(distinct ID_comp) from dbo.Pass_in_trip join dbo.Trip
	on dbo.Pass_in_trip.trip_no = dbo.Trip.trip_no
	 where dbo.Pass_in_trip.ID_psg = dbo.Passenger.ID_psg) as cc,
	(select count([date])
	from dbo.Pass_in_trip where dbo.Pass_in_trip.ID_psg = dbo.Passenger.ID_psg) as ct
from dbo.Passenger)
select name, ct
from pit
where cc = 1 and ct = (select max(ct) from pit where cc = 1);



with pit as (select dbo.Passenger.name,
(select count(distinct ID_comp) from dbo.Pass_in_trip join dbo.Trip
	on dbo.Pass_in_trip.trip_no = dbo.Trip.trip_no
	 where dbo.Pass_in_trip.ID_psg = dbo.Passenger.ID_psg) as cc,
	(select count([date])
	from dbo.Pass_in_trip where dbo.Pass_in_trip.ID_psg = dbo.Passenger.ID_psg) as ct
from dbo.Passenger)
select name, ct
from pit
where cc = 1  and ct = (select max(ct) from pit);