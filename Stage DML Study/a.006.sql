


-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт,
-- найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

select distinct maker, speed
from Product inner join Laptop on Product.model = Laptop.model
where Laptop.hd >= 10