
-- Найдите названия всех кораблей в базе данных, начинающихся с буквы R. 

-- cost 0.012425417080522 operations 4 
select name
from ships
where substring(name,1,1)='R'
union
select ship
from outcomes
where substring(ship,1,1)='R'
