
-- Для каждой страны определить сражения, в которых не участвовали корабли данной страны.
-- Вывод: страна, сражение

-- cost 0.089595675468445 operations 14 
select t1.country, t2.name
from 
(select distinct country from classes) as t1 cross join 
(select name from dbo.Battles) as t2
left join 
(select distinct c.country, o.battle
from outcomes o left join ships s on o.ship = s.name left join classes c on s.class = c.class or o.ship = c.class
where c.country is not null) as t3 on t1.country = t3.country and t2.name = t3.battle
where t3.country is null;

-- cost 0.071487873792648 operations 11 
with
	t1 as (select distinct country, name from classes cross join Battles),
	t2 as (select distinct c.country, o.battle
		from outcomes o left join ships s on o.ship = s.name left join classes c on s.class = c.class or o.ship = c.class
		where c.country is not null)
select t1.country, t1.name from t1
except
select country, battle from t2;

-- cost 0.072546534240246 operations 14 
select  country, name
from    Classes
        cross join Battles
except
select distinct
        country, battle
from    Classes
        inner join Outcomes on ship = Classes.class or exists ( select
                                                              name
                                                              from
                                                              Ships
                                                              where
                                                              name = Outcomes.ship and class = Classes.class );


-- drafts

-- cost 0.065262377262115 operations 9 
select distinct country, battle
from classes join outcomes on outcomes.ship = classes.class 
or exists (select name from ships where ships.name = outcomes.ship and ships.class = classes.class)

-- cost 0.049860898405313 operations 6 
select distinct c.country, o.battle
from outcomes o left join ships s on o.ship = s.name left join classes c on s.class = c.class or o.ship = c.class
where c.country is not null


--select *
--from classes join outcomes on outcomes.ship = classes.class 
--	left join ships on outcomes.ship = ships.name and classes.class = ships.class