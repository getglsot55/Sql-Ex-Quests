
-- Вывести все строки из таблицы Product, кроме трех строк с наименьшими номерами моделей и трех строк с наибольшими номерами моделей. 

-- cost 0.027059406042099 operations 7 
select *
from product
where model not in (
	select top 3 model 
	from product
	order by model
	) and model not in(
	select top 3 model 
	from product
	order by model desc)