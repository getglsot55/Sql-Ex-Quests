

-- Найти округленное до сотых долей среднее арифметическое следующих цен:
-- 1. Цена самых дешевых Laptop-ов от производителей РС с самой низкой скоростью CD;
-- 2. Цена самых дорогих РС от производителей самых дешевых принтеров;
-- 3. Цена самых дорогих принтеров от производителей Laptop-ов с наибольшим объемом памяти.
-- Замечание: При расчёте среднего отсутствующие цены не учитывать. 


-- cost 0.092657446861267 operations 44 
with cte as (select
(select top 1 price
from [dbo].[Laptop] join [dbo].[Product] on [Product].[model] = [Laptop].[model]
where [maker] in (
select maker
from pc join [dbo].[Product] on [Product].[model] = [PC].[model]
where cd = (select min(cd) from pc)) order by price) [1],
(select top 1 price
from [dbo].[PC] join [dbo].[Product] on [Product].[model] = [PC].[model]
where [maker] in (
select maker
from [dbo].[Printer] join [dbo].[Product] on [Product].[model] = [Printer].[model]
where [price] = (select min([price]) from [dbo].[Printer])) order by price desc) [2],
(select top 1 price
from [dbo].[Printer] join [dbo].[Product] on [Product].[model] = [Printer].[model]
where [maker] in (
select maker
from [dbo].[Laptop] join [dbo].[Product] on [Product].[model] = [Laptop].[model]
where [ram] = (select max([ram]) from [dbo].[Laptop])) order by price desc) [3])
select cast(val / iif([ca].[div] = 0, 1, [ca].[div]) as decimal(14, 2))
from cte
cross apply (
select (coalesce([cte].[1], 0) * 1.0 + coalesce([cte].[2], 0) * 1.0 + coalesce([cte].[3], 0) * 1.0) as val,
iif([cte].[1] is null, 0, 1) + iif([cte].[2] is null, 0, 1) + iif([cte].[3] is null, 0, 1) as [div]
from cte) ca;
