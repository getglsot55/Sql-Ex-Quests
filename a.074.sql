

-- Вывести классы всех кораблей России (Russia). Если в базе данных нет классов кораблей России, вывести классы для всех имеющихся в БД стран. 
-- Вывод: страна, класс 


-- cost 0.026031417772174 operations 10 
select distinct country, class 
from classes
where country like iif((select count(*) from classes where country = 'Russia') > 0, 'Russia','%')

select distinct country, class 
from classes
where country like iif(exists (select country from classes where country = 'Russia'), 'Russia','%')