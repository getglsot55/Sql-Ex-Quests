


-- Ќайдите корабли, "сохранившиес¤ дл¤ будущих сражений"; т.е. выведенные из стро¤ в одной битве (damaged), они участвовали в другой, произошедшей позже. 


-- cost 0.021958027034998 operations 8 
select distinct ship 
from dbo.Outcomes ouc1 join dbo.Battles btl1	on btl1.name = ouc1.battle
where result = 'damaged' and exists (
	select * 
	from dbo.Outcomes ouc2 join dbo.Battles btl2	on btl2.name = ouc2.battle
	where ouc2.ship = ouc1.ship and btl2.[date] > btl1.[date]);


with t1 as (
	select ship, 
	min(result) over(partition by ship order by btl.[date]) fres, 
	count(*) over(partition by ship) as cb
	from dbo.Outcomes ouc join dbo.Battles btl on btl.name = ouc.battle)
select distinct ship
from t1
where fres = 'damaged' and cb > 1
