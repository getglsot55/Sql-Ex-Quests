
-- ќпределить названи¤ всех кораблей из таблицы Ships, которые удовлетвор¤ют, по крайней мере, комбинации любых четырЄх критериев из следующего списка: 
-- numGuns = 8 
-- bore = 15 
-- displacement = 32000 
-- type = bb 
-- launched = 1915 
-- class=Kongo 
-- country=USA 


-- cost 0.017653619870543 operations 4 
with t1 as (select name,
0 + case when [numGuns] = 8 then 1 else 0 end  +
		case when [bore] = 15 then 1 else 0 end + 
		case when [displacement] = 32000 then 1 else 0 end + 
		case when [type] = 'bb' then 1 else 0 end +
		case when [launched] = 1915 then 1 else 0 end +
		case when ships.[class]='Kongo' then 1 else 0 end +
		case when [country]='USA' then 1 else 0 end as pcnt
from dbo.Ships join dbo.Classes on Classes.class = Ships.class)
select name
from t1
where pcnt >=4