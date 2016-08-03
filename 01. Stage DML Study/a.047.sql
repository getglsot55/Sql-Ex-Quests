
-- Пронумеровать строки из таблицы Product в следующем порядке: имя производителя в порядке убывания числа производимых им моделей 
-- (при одинаковом числе моделей имя производителя в алфавитном порядке по возрастанию), номер модели (по возрастанию).
-- Вывод: номер в соответствии с заданным порядком, имя производителя (maker), модель (model) 

-- cost 0.19724513590336 operations 15 
;with mcnt as (
select count(*) as cnt, p1.maker, p1.model
from product p1 join product p2 on p1.maker = p2.maker
group by p1.maker, p1.model)
select count(*) as cn, t2.maker, t2.model
from mcnt as t1 join mcnt as t2 on (t1.model <= t2.model and t1.maker=t2.maker) or t1.cnt>t2.cnt or (t1.cnt=t2.cnt and t1.maker < t2.maker)
group by t2.maker, t2.model
order by cn, t2.maker

--cost 0.029105504974723 operations 16 
select count(*) over (order by t1.countM desc, t1.maker, t1.model) cnt, t1.maker, t1.model
	from (
		select count(*) over(partition by maker) countM, maker,model
		from product
	) as t1
