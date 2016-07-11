

-- Найдите производителей принтеров. Вывести: maker 

select distinct maker
from Product
where Product.type='Printer'