
-- Найдите названия всех кораблей в базе данных, состоящие из трех и более слов (например, King George V).
-- Считать, что слова в названиях разделяются единичными пробелами, и нет концевых пробелов.

-- cost 0.018483765423298 operations 6 
select * 
from (
select name, (len(name) - len(replace(name, ' ', '')) + 1) as cw
from ships
union
select ship as name, (len(ship) - len(replace(ship, ' ', '')) + 1) as cw
from outcomes) as t1
where cw > 2
