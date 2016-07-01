

-- Для каждого класса определите год, когда был спущен на воду первый корабль этого класса.
-- Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год. 



-- cost 0.020956739783287 operations 7 

select classes.class,
case 
when launched is null
then (select min(launched) from Ships where Ships.class = Classes.class)
else launched
end as launched
from Classes left join ships on Classes.class = Ships.name


--select classes.class,
--case 
--when Classes.class = Ships.name
--then launched
--else 1111
--end as launched	
--from Classes, ships