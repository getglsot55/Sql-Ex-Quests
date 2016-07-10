


-- Для каждого производителя подсчитать: сколько имеется в наличии его продуктов (любого типа)
-- с неуникальной для этого производителя ценой и количество таких неуникальных цен. 
-- Вывод: производитель, количество продуктов, количество цен. 

-- cost 0.25109097361565 operations 41 
with cte as (select [maker], [Product].[model], coalesce([dbo].[PC].[price], coalesce([dbo].[Laptop].[price], [dbo].[Printer].[price])) [price]
from [dbo].[Product] left join [dbo].[PC] on [PC].[model] = [Product].[model]
left join [dbo].[Laptop] on [Laptop].[model] = [Product].[model]
left join [dbo].[Printer] on [Printer].[model] = [Product].[model]),
ctp as (select [cte].[maker], [cte].[price], count(*) as pc
from cte
where [cte].[price] is not null
group by maker, [cte].[price]
having count(*) > 1),
ctm as (select distinct maker from [dbo].[Product]),
ctr as (select cte.maker, count(model) cm, count(distinct cte.price) cp
from [cte] join [ctp] on ctp.[maker] = cte.[maker] and ctp.[price] = [cte].[price]
group by cte.maker)
select ctm.[maker], coalesce(cm, 0), coalesce(cp, 0)
from [ctm] left join [ctr] on [ctr].[maker] = [ctm].[maker]


-- cost 0.10649686306715 operations 20 
with cta as (
select [maker], coalesce([dbo].[PC].[price], coalesce([dbo].[Laptop].[price], [dbo].[Printer].[price])) price, count(*) pc
from [dbo].[Product] left join [dbo].[PC] on [PC].[model] = [Product].[model]
left join [dbo].[Laptop] on [Laptop].[model] = [Product].[model]
left join [dbo].[Printer] on [Printer].[model] = [Product].[model]
where [PC].[price] is not null or [Laptop].[ram] is not null or [Printer].[price] is not null
group by [maker], coalesce([dbo].[PC].[price], coalesce([dbo].[Laptop].[price], [dbo].[Printer].[price]))
having count(*) > 1),
ctm as (select distinct maker from [dbo].[Product])
select [ctm].[maker], sum(coalesce(pc,0)) as mc, count(price) as pc
from ctm left join cta on [cta].[maker] = [ctm].[maker]
group by [ctm].[maker]