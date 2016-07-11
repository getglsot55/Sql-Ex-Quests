

-- ѕо ¬ашингтонскому международному договору от начала 1922 г. запрещалось строить линейные корабли водоизмещением более 35 тыс.тонн.
-- ”кажите корабли, нарушившие этот договор (учитывать только корабли c известным годом спуска на воду). ¬ывести названи¤ кораблей. 

-- cost 0.011647455394268 operations 3 
select name
from dbo.Ships join dbo.Classes on dbo.Ships.class = dbo.Classes.class
where dbo.Ships.launched >= 1922 and dbo.Classes.[type] = 'bb' and displacement > 35000