

-- Для каждой пятой модели (в порядке возрастания номеров
-- моделей) из таблицы Product
-- определить тип продукции и среднюю цену модели.

-- cost 0.022473121061921 operations 19 
select type, [r].[avg_price]
from (
select row_number() over(order by [model]) rn, [type], [model]
from [dbo].[Product] ) ta
cross apply (
select
	case 
	when ta.[type] = 'Printer'
	then (select avg(price) from [dbo].[Printer] where [model] = ta.[model])
	when ta.[type] = 'PC'
	then (select avg(price) from [dbo].[PC] where [model] = ta.[model])
	when ta.[type] = 'Laptop'
	then (select avg(price) from [dbo].[Laptop] where [model] = ta.[model])
	else 0
end [avg_price] ) r
where [ta].[rn] % 5 = 0

 
-- cost 0.03585597500205 operations 13 
with cte as (select row_number() over(order by [model]) rn, [type], [model]from [dbo].[Product])
select [cte].[type],
case when cte.[type] = 'PC' then avg(pc.[price])
when cte.[type] = 'Laptop' then avg([dbo].[Laptop].[price])
when cte.[type] = 'Printer' then avg([dbo].[Printer].[price])
else 0 end avg_price
from cte left join [dbo].[PC] on [PC].[model] = cte.[model] left join [dbo].[Laptop] on [Laptop].[model] = cte.[model]
left join [dbo].[Printer] on [Printer].[model] = cte.[model]
where [cte].[rn] % 5 = 0
group by [cte].[model], [cte].[type]