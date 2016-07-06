
-- Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes).

-- cost 0.035917114466429 operations 9 
select ships.name
from ships join classes on ships.class = classes.class
where bore = 16
union
select class as name
from outcomes join classes on outcomes.ship = classes.class
where bore = 16 and outcomes.ship not in (select name from ships)
