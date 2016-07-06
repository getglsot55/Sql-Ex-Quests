

--  Для каждого типа продукции и каждого производителя из таблицы Product 
--  c точностью до двух десятичных знаков найти процентное отношение 
--  числа моделей данного типа данного производителя к общему числу моделей этого производителя.
--  Вывод: maker, type, процентное отношение числа моделей данного типа к общему числу моделей производителя

-- cost 0.10638891160488 operations 26
;with pcj as (select * from (select distinct [maker] from product ) as tp cross join (select distinct [type] from Product ) as tt)
select distinct pcj.maker, pcj.type, 
cast(count(model) over(partition by pcj.[maker],pcj.[type]) *100.0/count(model) over(partition by pcj.[maker]) as numeric(10,2)) as val
from pcj left join product on pcj.maker = product.maker and pcj.type = product.type
 


-- cost 0.073575757443905 operations 18 
;with pcj as (select * from (select distinct [maker] from product ) as tp cross join (select 'PC' as [type] union select 'Laptop' union select 'Printer') as tt)
select distinct pcj.maker, pcj.type, 
cast( (select count(model) from product as p where p.maker=pcj.[maker] and p.[type]=pcj.[type])*100.0
	/(select count(model) from product as p where p.maker=pcj.[maker]) as numeric(10,2)) as val
from pcj left join product on pcj.maker = product.maker and pcj.type = product.type
order by maker 