Задание: 151 (Serge I: 2009-04-17)
Для каждого корабля из таблицы Ships указать название первого по времени сражения из таблицы Battles,
в котором корабль мог бы участвовать после спуска на воду. Если год спуска на воду неизвестен, взять последнее по времени сражение.
Если нет сражения, произошедшего после спуска на воду корабля, вывести NULL вместо названия сражения.
Считать, что корабль может участвовать во всех сражениях, которые произошли в год спуска на воду корабля.
Вывод: имя корабля, год спуска на воду, название сражения

Замечание: считать, что не существует двух битв, произошедших в один и тот же день.

---

with A as (
select Ships.name as nn
, launched
, IIF(
      launched is NULL, 
      (select top(1) Battles.name from Battles order by date desc), 
      Battles.name
     ) as name
, row_number() over(partition by Ships.name order by Battles.date, Ships.name) as flag
from Ships left join Battles on Ships.launched <= year(Battles.date)
)

select nn, launched, name from A where flag = 1
