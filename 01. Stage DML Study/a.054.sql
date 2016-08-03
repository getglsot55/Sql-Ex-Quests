

-- С точностью до 2-х десятичных знаков определите среднее число орудий всех линейных кораблей (учесть корабли из таблицы Outcomes). 


-- cost 0.032328709959984 operations 11 
with shc as (select ships.name, Classes.numGuns
from ships join classes on ships.class = classes.class
where [type]='bb'
union
select class as name, Classes.numGuns
from outcomes join classes on outcomes.ship = classes.class
where [type]='bb')
select cast(avg(numGuns * 1.0) as numeric(10,2))
from shc