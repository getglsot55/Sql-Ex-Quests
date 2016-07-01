
-- Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships. 

-- cost 0.018918246030807 operations 4 
select distinct outcomes.battle
from outcomes join ships on outcomes.ship = ships.name --join classes on ships.class = classes.class
where ships.class = 'Kongo'