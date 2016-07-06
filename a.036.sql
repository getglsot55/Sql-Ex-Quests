

-- Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes). 

select distinct dbo.Classes.class
from dbo.Classes left join dbo.Ships on Ships.class = Classes.class left join dbo.Outcomes on dbo.Classes.class = dbo.Outcomes.ship
where dbo.Ships.name = dbo.Classes.class or (dbo.Classes.class = dbo.Outcomes.ship)

--select *
--from dbo.Ships
--where name = class
--union 