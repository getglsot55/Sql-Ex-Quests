
-- Одной из характеристик корабля является половина куба калибра его главных орудий (mw).
-- С точностью до 2 десятичных знаков определите среднее значение mw для кораблей каждой страны,
-- у которой есть корабли в базе данных. 

-- cost 0.041289858520031 operations 11 
with sc as (
select name, ships.class, country, bore
from ships join classes on ships.class = classes.class
union
select ship, class, country, bore
from Outcomes join classes on Outcomes.ship = Classes.class)
select country, cast(avg((bore*bore*bore*1.0)/2) as numeric(12,2)) as [weight]
from sc
group by country

-- cost 0.041230361908674  operations 12 
select ss.country, cast(avg(power(ss.bore,3)/2) as numeric(6,2)) as weight
from (
	select c.country, c.class, s.name as ship_name, c.bore  from classes c join ships s on s.class = c.class
	union
	select distinct c.country, c.class, o.ship as ship_name, c.bore
	from classes c join outcomes o on o.ship = c.class) ss
group by ss.country