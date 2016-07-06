

-- Пронумеровать уникальные пары {maker, type} из Product, упорядочив их следующим образом:
-- - имя производителя (maker) по возрастанию;
-- - тип продукта (type) в порядке PC, Laptop, Printer.
-- Если некий производитель выпускает несколько типов продукции, то выводить его имя только в первой строке;
-- остальные строки для ЭТОГО производителя должны содержать пустую строку символов (''). 

-- cost 0.051361322402954 operations 12 
with pmq as (
	select [maker], [type],
	case when [type] = 'PC' then 0 when [type] = 'Laptop' then 1 else 2 end as [s],
	case 
		when [type] = 'Laptop' and maker in (select maker from [Product] where [type] = 'PC')
		then ''
		when [type] = 'Printer' and maker in (select maker from [Product] where [type] = 'PC' or [type]='Laptop')
		then ''
		else [maker]
	end as m
	from [dbo].[Product]
	group by [maker], [type])
select row_number() over(order by [maker],[s]) num, [m],[type]
from [pmq]
order by  [maker], [s]