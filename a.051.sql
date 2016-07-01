

-- Найдите названия кораблей, имеющих наибольшее число орудий среди всех имеющихся кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes). 

-- cost 0.043066404759884 operations 16 
with shc as (select ships.name, Classes.numGuns, Classes.displacement
from ships join classes on ships.class = classes.class
union
select class as name, Classes.numGuns, Classes.displacement
from outcomes join classes on outcomes.ship = classes.class),
shnd as (select name, numGuns, max(numGuns) over(partition by displacement) max, displacement
from shc)
select name
from shnd
where numGuns = max


-- cost 0.043066404759884 operations 16 
select name
from(
select name, numGuns, max(numGuns) over(partition by displacement) max, displacement
from (
select ships.name, Classes.numGuns, Classes.displacement
from ships join classes on ships.class = classes.class
union
select class as name, Classes.numGuns, Classes.displacement
from outcomes join classes on outcomes.ship = classes.class) as t1
) as t2 where numGuns = max