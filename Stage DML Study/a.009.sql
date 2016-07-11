

-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker 

select distinct maker
from product inner join PC on product.model = PC.model
where PC.speed >= 450