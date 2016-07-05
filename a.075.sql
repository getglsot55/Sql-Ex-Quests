

-- Для каждого корабля из таблицы Ships указать название первого по времени сражения из таблицы Battles,
-- в котором корабль мог бы участвовать после спуска на воду. Если год спуска на воду неизвестен,
-- взять последнее по времени сражение.
-- Если нет сражения, произошедшего после спуска на воду корабля, вывести NULL вместо названия сражения.
-- Считать, что корабль может участвовать во всех сражениях, которые произошли в год спуска на воду корабля.
-- Вывод: имя корабля, год спуска на воду, название сражения
-- Замечание: считать, что не существует двух битв, произошедших в один и тот же день. 


-- cost 0.044919840991497 operations 9 
with t1 as (select name, launched,
case
	when launched is null	then (select max([date]) from battles)
	else (select min([date]) from battles where datepart(year, [date]) >= launched)
end as xdate
from ships)
select t1.name, t1.launched, battles.name
from t1 left join [battles] on t1.xdate = battles.date

-- cost 0.34367164969444 operations 14 
select name, launched,
case 
	when launched is null
	then (select top 1 name from battles order by [date] desc)
	else
		case
		when exists (select * from battles where [date] >= datefromparts(launched, 1, 1))
		then (select top 1 name from battles where [date] >= datefromparts(launched, 1, 1) order by [date])
		else null
		end
end as [battle]
from ships;