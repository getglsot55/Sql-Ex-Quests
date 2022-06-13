
-- Для семи последовательных дней, начиная от минимальной даты, когда из Ростова было совершено максимальное число рейсов, 
-- определить число рейсов из Ростова. 
-- Вывод: дата, количество рейсов

-- cost 0.073166266083717 operations 45 
--with tr as (
--	select date, count(distinct trip_no) as cnt
--	from Pass_in_trip
--	where trip_no in (select trip_no from Trip where town_from = 'Rostov')
--	group by date
--	),
--	ts as (
--	select dateadd(day, a, (select min(date) from tr where cnt = (select max(cnt) from tr))) as rd
--	from  (select 0 as a union select 1 union select 2 union select 3 union select 4 union select 5 union select 6) as t3
--	)
--select rd, coalesce((select cnt from tr where date = rd), 0) as qty
--from (


--	select date, count(distinct trip_no) as cnt
--	from Pass_in_trip
--	where trip_no in (select trip_no from Trip where town_from = 'Rostov')
--	group by date	



;With pt as (
	Select date,COUNT(distinct trip_no) count,MAX(COUNT(distinct trip_no)) over() max 
	from Pass_in_trip 
	Where trip_no in (Select trip_no  From Trip Where town_from like 'Rostov%') Group by date),
	da as (Select DATEADD(day,t.c,date) date
		From
		(SELECT 0 c UNION ALL 
		SELECT 1 UNION ALL 
		SELECT 2 UNION ALL 
		SELECT 3 UNION ALL 
		SELECT 4 UNION ALL 
		SELECT 5 UNION ALL 
		SELECT 6) t, (Select top 1 date From pt Where count = max) p)
Select date,ISNULL((Select count From pt Where date = da.date),0)
From da

---

Вот более интуитивно понятный вариант с рекурсивной CTE:

with A as ( select date
, count(distinct Trip.trip_no) cnt1
, max(count(distinct Trip.trip_no)) over() cnt2 
  from Pass_in_trip join Trip on Pass_in_trip.trip_no = Trip.trip_no
  where town_from = 'Rostov'
  group by date
          ),

B as (
select min(date) as d1, 0 as ff, 0 as flag from A where cnt1 = cnt2
  union all
select dateadd(day, 1, d1 ), 0, flag+1 from B where flag<6
      ),

C as (
select d1, cnt1 from B join A on B.d1 = A.date
  union 
select d1, ff from B
      )

select d1, sum(cnt1) from C group by d1
