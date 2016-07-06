
-- Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении.

-- cost 0.052322629839182 operations 9 
;with sc as(
select ships.name, classes.class
from ships join classes on ships.class = classes.class
union
select class as name, class
from classes)
select distinct class
from outcomes join sc on outcomes.ship = sc.name
where outcomes.result='sunk'