

-- Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных,
-- вывести имя класса и число потопленных кораблей. 

-- cost 0.11402809619904 operations 23 
with shs as (
		select ship 
		from Outcomes 
		where result = 'sunk'),
	fsc as (
		select ships.name, Classes.class
		from ships join classes on ships.class = classes.class
		union
		select class as name, Classes.class
		from outcomes join classes on outcomes.ship = classes.class),
	ssc as (
	select classes.class, count(distinct ship) cnt 
	from classes left join ships on classes.class = ships.class 
		left join shs ON shs.ship = ships.name or shs.ship = classes.class 
		group by classes.class)
select ssc.class, ssc.cnt
from ssc join fsc on ssc.class = fsc.class
where ssc.cnt >0
group by ssc.class, ssc.cnt
having count(*) > 2


-- cost 0.058634020388126 operations 14 
with ssc as (
		select ships.name, Classes.class
		from ships join classes on ships.class = classes.class
		union
		select class as name, Classes.class
		from outcomes join classes on outcomes.ship = classes.class)
select class, count(result) as sunk 
from (
	select class, result, name 
	from ssc left join Outcomes ON ship=name AND class IS NOT NULL AND result = 'sunk'
) T 
group by class 
having count(class) > 2 and countT(result) > 0


--
select class, count(result) as sunk 
from (
	select class, result, name 
	from Ships LEFT JOIN Outcomes ON ship=name AND class IS NOT NULL AND result = 'sunk'
) T 
GROUP BY class 
HAVING COUNT(class) > 0 AND COUNT(result) > 0


select class, count(result) as sunk 
from (
	select class, result, name 
	from Ships LEFT JOIN Outcomes ON ship=name AND class IS NOT NULL AND result = 'sunk'
	union
	select class, result, Outcomes.ship as name
	from Outcomes join Classes on Outcomes.ship = Classes.class and result = 'sunk'
) T 
GROUP BY class 
HAVING COUNT(class) > 0 AND COUNT(result) > 0

	select class, result, name 
	from Ships LEFT JOIN Outcomes ON ship=name AND class IS NOT NULL AND result = 'sunk'
	union
	select class, result, Outcomes.ship as name
	from Outcomes join Classes on Outcomes.ship = Classes.class and result = 'sunk'


	select class, result, name 
	from Ships left join Outcomes ON ship=name AND class IS NOT NULL AND result = 'sunk'
	union
	select class, result, Outcomes.ship as name
	from Outcomes left join Classes on Outcomes.ship = Classes.class and result = 'sunk'





