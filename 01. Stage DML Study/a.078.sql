

-- Для каждого сражения определить первый и последний день
-- месяца,
-- в котором оно состоялось. 
-- Вывод: сражение, первый день месяца, последний
-- день месяца.
-- Замечание: даты представить без времени в формате "yyyy-mm-dd". 

-- cost 0.0033108000643551 operations 2 
select name,
	datefromparts(year([date]), month([date]), 1) as firstD,
	dateadd(day, -1, dateadd(month, 1, datefromparts(year([date]), month([date]), 1))) as lastD
from dbo.Battles