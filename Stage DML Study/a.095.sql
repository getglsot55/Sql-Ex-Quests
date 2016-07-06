

-- На основании информации из таблицы Pass_in_Trip, для каждой авиакомпании определить:
-- 1) количество выполненных перелетов;
-- 2) число использованных типов самолетов;
-- 3) количество перевезенных различных пассажиров;
-- 4) общее число перевезенных компанией пассажиров.
-- Вывод: Название компании, 1), 2), 3), 4). 

-- cost 0.15421839058399 operations 31 
select name,
	count(distinct concat(Trip.trip_no,'-',[date])) as flyc,
	count(distinct plane) as flyt,
	count(distinct ID_psg) as psc,
	count(*) as total_psngrs
from Pass_in_trip as pit join Trip on pit.trip_no = trip.trip_no join Company on trip.ID_comp = Company.ID_comp
group by Company.ID_comp, name;


-- cost 0.063148617744446 operations 20 
with t0 as(
	select distinct t.ID_comp, pt.date, t.trip_no, t.plane
	from Pass_in_Trip pt, Trip t where pt.trip_no = t.trip_no) --select * from t0
	, t1 as(
	select ID_comp, count(*) as C1, count(distinct plane) C2 from t0 group by ID_comp)
	, t2 as(
	select t.ID_comp, count(distinct pt.ID_psg) C3, count(pt.ID_psg) C4
	from Pass_in_Trip pt, Trip t where pt.trip_no = t.trip_no
	group by t.ID_comp)
select
	(select name from Company c where t1.ID_comp = c.ID_comp) name,
	C1, C2, C3, C4
from t1, t2 where t1.ID_comp = t2.ID_comp