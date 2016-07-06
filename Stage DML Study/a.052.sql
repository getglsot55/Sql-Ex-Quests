

-- Определить названия всех кораблей из таблицы Ships, которые могут быть линейным японским кораблем,
-- имеющим число главных орудий не менее девяти, калибр орудий менее 19 дюймов и водоизмещение не более 65 тыс.тонн 


select name
from Ships join Classes on ships.class = Classes.class
where country like 'Japan' and classes.type like 'bb' 
	and (numGuns >= 9 or numGuns is null)
	and (bore < 19 or bore is null)
	and (displacement <=65000 or displacement is null)