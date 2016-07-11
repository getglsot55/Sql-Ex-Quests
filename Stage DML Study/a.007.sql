


-- Найдите номера моделей и цены всех продуктов (любого типа), выпущенных производителем B (латинская буква). 

select distinct PC.model, price
from PC inner join Product on PC.model = Product.model
where Product.maker='B'
union
select distinct Laptop.model, price
from Laptop inner join Product on Laptop.model = Product.model
where Product.maker='B'
union
select distinct Printer.model, price
from Printer inner join Product on Printer.model = Product.model
where Product.maker='B'