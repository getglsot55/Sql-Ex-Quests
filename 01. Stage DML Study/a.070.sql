

-- Укажите сражения, в которых участвовало по меньшей мере три корабля одной и той же страны. 


-- cost 0.064089268445969 operations 15 
with fss as (
	select name, ships.[class], [country]
	from ships join dbo.Classes on ships.class = dbo.Classes.class
	union
	select ship as [name], class, [country]
	from dbo.Outcomes join dbo.Classes on dbo.Outcomes.ship = dbo.Classes.class)
select battle
from outcomes join fss on  outcomes.ship = fss.name
group by battle, country
having count(*) > 2

-- cost 0.049884766340256 operations 10 
select distinct [battle]
from dbo.Outcomes left join ships on outcomes.ship = ships.name
	left join classes on ships.class = dbo.Classes.class or dbo.Outcomes.ship = classes.class
where [country] is not null
group by [battle], [country]
having count([ship]) > 2

-- 
select battle, count(outcomes.ship)
from outcomes join (
select classes.class, coalesce(ships.name, outcomes.ship) as ship, classes.country as country
from classes left join ships on classes.class = ships.class
left join outcomes on classes.class = outcomes.ship) as t1 on outcomes.ship = t1.ship
group by [battle], t1.[country]
having count(outcomes.ship) > 2