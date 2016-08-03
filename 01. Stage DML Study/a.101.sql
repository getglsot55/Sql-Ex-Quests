


-- Таблица Printer сортируется по возрастанию поля code. 
-- Упорядоченные строки составляют группы: первая группа начинается с первой строки, 
-- каждая строка со значением color='n' начинает новую группу, группы строк не перекрываются.
-- Для каждой группы определить: наибольшее значение поля model (max_model), 
-- количество уникальных типов принтеров (distinct_types_cou) и среднюю цену (avg_price). 
-- Для всех строк таблицы вывести: code, model, color, type, price, max_model, distinct_types_cou, avg_price. 

-- cost 0.026772938668728 operations 19 
with cte as (select *,
	case color when 'n' then 0 else row_number() over(order by code) end +
	case color when 'n' then 1 else -1 end * row_number() over(partition by color order by code) grp
from Printer),
ctb as ( select *, dense_rank() over(partition by grp order by type) as rt from cte)
select [ctb].[code], [ctb].[model], [ctb].[color],[ctb].[type], [ctb].[price],
	max(model) over(partition by [ctb].[grp]) [max_model],
	max(rt) over(partition by grp) as [distinct_types_cou],
	avg(price) over(partition by [ctb].[grp]) [avg_price]
from ctb;

--select code, model, color, [type], price , sum(case when color = 'n' then 1 ELSE 0 end) over(order by code) grp
--from Printer 

--with cte as (select *,
--	case color when 'n' then 0 else row_number() over(order by code) end +
--	case color when 'n' then 1 else -1 end * row_number() over(partition by color order by code) Grp
--from Printer)
--select *, dense_rank() over(partition by grp order by type) as rt from cte