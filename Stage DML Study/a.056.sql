

-- Для каждого класса определите число кораблей этого класса, потопленных в сражениях.
-- Вывести: класс и число потопленных кораблей. 

--cost 0.054363735020161  operations 9 

with shs as (
	select ship 
	from Outcomes 
	where result = 'sunk')
select classes.class, count(distinct ship) cnt 
from classes left join ships on classes.class = ships.class 
	left join shs ON shs.ship = ships.name or shs.ship = classes.class 
group by classes.class

