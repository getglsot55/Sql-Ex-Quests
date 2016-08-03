
-- Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). Вывод: ship.


-- cost 0.0033545999322087 operations 1 
select ship
from dbo.Outcomes
where result = 'sunk' and battle = 'North Atlantic'