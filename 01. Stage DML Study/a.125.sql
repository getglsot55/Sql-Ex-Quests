

-- Данные о продаваемых моделях и ценах (из таблиц Laptop, PC и Printer) объединить в одну таблицу LPP 
-- и создать в ней порядковую нумерацию (id) без пропусков и дубликатов. 
-- Считать, что модели внутри каждой из трёх таблиц упорядочены по возрастанию поля code.
-- Единую нумерацию записей LPP сделать по следующему правилу: сначала идут первые модели из таблиц (Laptop, PC и Printer),
-- потом последние модели, далее - вторые модели из таблиц, предпоследние и т.д. 
-- При исчерпании моделей определенного типа, нумеровать только оставшиеся модели других типов. 
-- Вывести: id, type, model и price. Тип модели type является строкой 'Laptop', 'PC' или 'Printer'.

-- cost 0.059047196060419 operations 49 
with cta as (
select case when ca > ceiling((cc*1.0)/2) then cd * 2 else cc - cd + ca end as crn , 1 as tt,*
from (select row_number() over(order by code) ca,	row_number() over(order by code desc) cd,	count(*) over() cc,
	'Laptop' as type, [model], [price] from [dbo].[Laptop]) tr
union
select case when ca > ceiling((cc*1.0)/2) then cd * 2 else cc - cd + ca end as crn , 2 as tt,*
from (select row_number() over(order by code) ca,	row_number() over(order by code desc) cd,	count(*) over() cc,
	'PC' as type, [model], [price] from [dbo].PC) tr
union
select case when ca > ceiling((cc*1.0)/2) then cd * 2 else cc - cd + ca end as crn , 3 as tt,*
from (select row_number() over(order by code) ca,	row_number() over(order by code desc) cd,	count(*) over() cc,
	'Printer' as type, [model], [price] from [dbo].[Printer]) tr)
select row_number() over(order by [cta].[crn], [cta].[tt]) id, [cta].[type], [cta].[model], [cta].[price]
from cta
order by crn, [cta].[tt]



select * from (
	select case when ca > ceiling((cc*1.0)/2) then cd * 2 else cc - cd + ca end as crn , 2 as tt,*
from (select row_number() over(order by code) ca,	row_number() over(order by code desc) cd,	count(*) over() cc,
	'PC' as type, [model], [price] from [dbo].PC) tr) tr1 order by [tr1].[crn]