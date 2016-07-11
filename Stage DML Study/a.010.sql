

-- Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price 

Select model, price
from printer
where price = (select max(price) from printer)