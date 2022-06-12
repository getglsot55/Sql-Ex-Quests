Задание: 152 (Serge I: 2020-01-24)
Рассматривается таблица Product. Упорядоченные по номеру модели принтеры образуют группы (model - номер группы).
В каждую группу (в порядке возрастания) добавляются по одной модели ПК в порядке возрастания номера модели.
После добавления ПК в последнюю группу процесс продолжается с первой группы до тех пор, пока не закончатся модели ПК.
Выполнить нумерацию в порядке по возрастанию: принтеры по номеру группы, затем модели ПК в группе.
Вывод: номер по порядку, model, type
Замечание. Модели ноутбуков не учитывать и не выводить.

---

with A as (
select model, type, row_number() over(order by model) f1, 0 f2 from Product where type = 'Printer'
   union all
select model, type
, IIF(
   row_number() over(order by model) % (select count(*) from Product where type = 'Printer') = 0,
   (select count(*) from Product where type = 'Printer'), 
   row_number() over(order by model) % (select count(*) from Product where type = 'Printer') 
     )
, row_number() over(order by model)
from Product where type = 'PC'
)

select row_number() over(order by f1, f2), model, type from A order by f1, f2
