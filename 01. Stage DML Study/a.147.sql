Задание: 147 (Serge I: 2011-02-11)
Пронумеровать строки из таблицы Product в следующем порядке: имя производителя в порядке убывания числа производимых им моделей (при одинаковом числе моделей имя производителя в алфавитном порядке по возрастанию), номер модели (по возрастанию).
Вывод: номер в соответствии с заданным порядком, имя производителя (maker), модель (model)

---

with A as (
select maker, count(model) over(partition by maker) as flag, model from Product
)

select row_number() over(order by flag desc, maker, model asc), maker, model from A
