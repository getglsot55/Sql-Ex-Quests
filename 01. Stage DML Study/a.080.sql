

-- Найти производителей компьютерной техники, у которых нет моделей ПК, не представленных в таблице PC. 

-- cost 0.044419646263123 operations 11 
select distinct maker
from product 
where maker not in (
select distinct maker
from Product left join PC on PC.model = Product.model
where [type]='PC' --and pc.model is not null
group by maker
having sum( iif(pc.model is null, 1, 0)) > 0)


-- cost 0.042236093431711 operations 10 
select distinct maker
from product 
where maker not in (
select distinct maker
from Product left join PC on PC.model = Product.model
where [type]='PC' and pc.model is null
group by maker
)