
-- Найти тех производителей ПК, все модели ПК которых имеются в таблице PC. 

-- cost 0.027341773733497 operations 7 
select maker
from product left join PC on product.model = pc.model
where [type] = 'PC'
group by maker
having sum(iif(pc.model is null, 1, 0)) = 0