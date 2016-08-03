
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

-- cost 0.017385620623827 operations 3 
select cl.class, ships.name, cl.country
from ships join classes as cl on ships.class=cl.class
where cl.numGuns>=10
