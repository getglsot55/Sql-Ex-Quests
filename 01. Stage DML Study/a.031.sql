


-- Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну. 

--
select class, country
from classes
where bore>=16