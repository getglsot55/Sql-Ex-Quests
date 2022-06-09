Задание: 156 (Serge I: 2006-11-17)
Распределить по трем столбцам (построчно) квадраты из таблицы utq в порядке возрастания их идентификаторов.
Если последняя строка окажется незаполненной, использовать NULL для отсутствующих значений.
Например, для последовательности идентификаторов {1,2,3,4,5,6,7,8} результат должен выглядеть так:

1   2   3

4   5   6

7   8   NULL

---

with A as (
select Q_ID
, lead(Q_ID) over(order by Q_ID) as f
, lead(Q_ID, 2) over(order by Q_ID) as ff
, row_number() over(order by Q_ID)+2 as fff
from utq
)

select Q_ID, f, ff from A where fff % 3 = 0
