Задание: 148 (Serge I: 2009-08-11)
Для таблицы Outcomes преобразовать названия кораблей, содержащих более одного пробела, следующим образом.
Заменить все символы между первым и последним пробелами (исключая сами эти пробелы) на символы звездочки (*)
в количестве, равном числу замененных символов.
Вывод: название корабля, преобразованное название корабля

---

select 

ship,

substring(ship, 1, patindex('% %', ship))
 +
  replicate('*',
  (datalength(ship) - patindex('% %', REVERSE(ship))) - patindex('% %', ship)
  )
 +
substring(ship, (datalength(ship) - patindex('% %', REVERSE(ship))+1), len(ship))

from Outcomes 

where patindex('% %', ship) > 0
and patindex('% %', ship) <> len(ship) - patindex('% %', REVERSE(ship))+1

---

Вот разбор как к этому пришли:

with A as (
select ship 
--, patindex('% %', ship) as start
--, len(ship) - patindex('% %', REVERSE(ship))+1 as mean
--, patindex('% %', REVERSE(ship)) as stop
 from Outcomes
where patindex('% %', ship) > 0
and patindex('% %', ship) <> len(ship) - patindex('% %', REVERSE(ship))+1
),

B as (
select 
ship
, patindex('% %', ship) as start
, REVERSE(ship) as rever
, datalength(ship) - patindex('% %', REVERSE(ship))+1 as stop
, substring(ship, 1, patindex('% %', ship)) as first_word
, replicate('*',
  (datalength(ship) - patindex('% %', REVERSE(ship))) - patindex('% %', ship)
  ) as mean
, 
IIF(patindex('% %', REVERSE(ship)) = 1, ' ',
   substring(ship, (datalength(ship) - patindex('% %', REVERSE(ship))+1), len(ship))) 
   as last_word
from A
)

select ship, first_word + mean + last_word from B
