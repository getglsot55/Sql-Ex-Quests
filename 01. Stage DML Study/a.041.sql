
-- Для ПК с максимальным кодом из таблицы PC вывести все его характеристики (кроме кода) в два столбца:
-- - название характеристики (имя соответствующего столбца в таблице PC);
-- - значение характеристики 

-- cost 0.0033168171066791 operations 6 
select [char],[value]
from (
select 
	model, 
	cast(speed as varchar(50)) speed, 
	cast(ram as varchar(50)) ram,
	cast(hd as varchar(50)) hd,
	cast(cd as varchar(50)) cd,
	cast(price as varchar(50)) price
from pc
where code = (select max(code) from pc)
) p
unpivot ([value] for [char] in (model, speed, ram, hd, cd, price)) as unpvt