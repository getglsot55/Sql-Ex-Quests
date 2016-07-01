
-- Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

--
select count(*) as qty
from (
select maker
from product
group by maker
having count(model) = 1) as t1