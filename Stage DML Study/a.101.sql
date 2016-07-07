


-- Таблица Printer сортируется по возрастанию поля code. 
-- Упорядоченные строки составляют группы: первая группа начинается с первой строки, 
-- каждая строка со значением color='n' начинает новую группу, группы строк не перекрываются.
-- Для каждой группы определить: наибольшее значение поля model (max_model), 
-- количество уникальных типов принтеров (distinct_types_cou) и среднюю цену (avg_price). 
-- Для всех строк таблицы вывести: code, model, color, type, price, max_model, distinct_types_cou, avg_price. 

--select *, rank() over(order by code ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
--from Printer


select *,
	row_number() over(order by code),
	row_number() over( partition by color order by code),
	case color when 'n' then 0 else row_number() over(order by code) end +
	case color when 'n' then 1 else -1 end * row_number() over(partition by color order by code) Grp 
from Printer 
order by code