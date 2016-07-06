

-- Найти производителей, которые выпускают только принтеры или только PC.
-- При этом искомые производители PC должны выпускать не менее 3 моделей. 


-- cost 0.049146074801683 operations 21 
with t1 as (select maker,
				sum(case when [type] = 'PC' then 1 else 0 end) as cpc,
				sum(case when [type] = 'Printer' then 1 else 0 end) as cpr
					from Product
					where [type] = 'PC' or [type] = 'Printer'
					group by maker)
select distinct  dbo.Product.maker
from Product join t1 on t1.maker = Product.maker
where dbo.Product.maker not in (select distinct maker from Product where [type] = 'Laptop')
	and ( 
		(t1.cpc <> 0 and t1.cpr = 0 and dbo.Product.maker in (select maker from Product where [type] = 'PC' group by maker having count(model) >= 3)) or 
		(t1.cpc = 0 and t1.cpr <> 0));

--
select maker
from product
group by maker
having count(distinct type)=1 and (count(model)> 2 and max(type)='PC' or max(type)='Printer')