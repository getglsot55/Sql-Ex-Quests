

-- Задание: 3 (Serge I: 2007-08-03) 
-- Для таблицы Product получить результирующий набор в виде таблицы со столбцами maker, pc, laptop и printer, 
-- в которой для каждого производителя требуется указать, производит он (yes) или нет (no) соответствующий тип продукции. 
-- В первом случае (yes) указать в скобках без пробела количество имеющихся в наличии 
-- (т.е. находящихся в таблицах PC, Laptop и Printer) различных по номерам моделей соответствующего типа.;
;


--cost 0.049722243100405  operations 26 

select 
	pvt.maker,
	case when [pvt].[PC] is not null then 'yes(' + cast([pvt].[PC] as varchar(4)) +')'
	else 'no' end as [PC],
	case when [pvt].[Laptop] is not null then 'yes(' + cast([pvt].[Laptop] as varchar(4)) +')'
	else 'no' end as [Laptop],
	case when [pvt].[Printer] is not null then 'yes(' + cast([pvt].[Printer] as varchar(4)) +')'
	else 'no' end as [Printer]
from(
select [p].[maker], [p].[type], [t].[mc]
from [dbo].[Product] [p]
cross apply (
select
	case
	when [p].[type] = 'PC' then (select count(distinct [p1].[model]) from [dbo].[PC] [p1] where [p].[model] = [p1].[model])
	when [p].[type] = 'Laptop' then (select count(distinct [l].[model]) from [dbo].[Laptop] [l] where [p].[model] = [l].[model])
	when [p].[type] = 'Printer' then (select count(distinct [pr].[model]) from [dbo].[Printer] [pr] where [p].[model] = [pr].[model])
	end as mc
	) as t ) as tt
pivot(sum([tt].[mc]) for [type] in (PC, Laptop, Printer)) as pvt;