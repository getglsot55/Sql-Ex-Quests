
-- Найдите названия кораблей, потопленных в сражениях, и название сражения, в котором они были потоплены.

-- cost 0.0033545999322087 operations 1 
select ship, battle
from outcomes
where result='sunk'
