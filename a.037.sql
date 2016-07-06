

-- Найдите классы, в которые входит только один корабль из базы данных (учесть также корабли в Outcomes). 

--
select t1.class
from (
select dbo.Classes.class, dbo.Ships.name
from dbo.Classes join dbo.Ships on Ships.class = Classes.class
union 
select dbo.Classes.class, dbo.Outcomes.ship
from dbo.Outcomes join dbo.Classes on dbo.Classes.class = dbo.Outcomes.ship) t1
group by t1.class
having count( t1.name) = 1



select cls.class
from dbo.Classes cls
where ((select count(name) from ships where ships.class = cls.class) +
			(select count(*) from dbo.Outcomes ouc where ouc.ship = cls.class and not exists (select name from dbo.Ships where name = ouc.ship))) = 1



SELECT name, cls.class FROM Ships join dbo.Classes cls on cls.class = Ships.class
union
SELECT ship, cls.class FROM Outcomes ouc join dbo.Classes cls on ouc.ship = cls.class;


--INSERT INTO Ships VALUES('Terplits', 'Bismarck', 1940) 