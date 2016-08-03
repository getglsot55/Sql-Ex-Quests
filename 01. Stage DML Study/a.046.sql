
-- Для каждого корабля, участвовавшего в сражении при Гвадалканале (Guadalcanal), вывести название, водоизмещение и число орудий.

-- cost 0.028191285207868 operations 8 
with sc as(
	select name, displacement, numguns
	from ships  inner join classes on ships.class = classes.class
	union
	select class as name, displacement, numguns
	from classes)
select outcomes.ship, displacement, numguns
from outcomes left join sc on outcomes.ship = sc.name
where outcomes.battle='Guadalcanal'

-- cost 0.028191285207868 operations 8 
select ship, displacement, numGuns
from outcomes left join (
	select name, displacement, numGuns
	from ships join classes on classes.class=ships.class 
	union
	select class as name, displacement, numGuns
	from classes) as t1
 on outcomes.ship=t1.name 
 WHERE battle = 'Guadalcanal'