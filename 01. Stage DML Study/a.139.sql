Задание: 139 (Serge I: 2017-05-12)
Для каждого корабля, отсутствующего в таблице Outcomes, перечислить через запятую в хронологическом порядке сражения,
в которых этот корабль не смог бы принять участие. Если таких сражений нет, вывести NULL.
Замечание. Считать, что корабль может принимать участие в сражениях, произошедших в год спуска корабля на воду.
Вывод: имя корабля, список сражений

---

with A as (
select name, IIF(launched IS NULL, (
   select min(S_kid.launched) from Ships as S_kid
   where S_kid.name = s_main.class
   and S_kid.launched is not null
                                    ), launched) as launched 
from Ships as s_main
where name not in (select ship from Outcomes)
)

select A.name, string_agg(B.name, ',') within group (order by date) 
from A left join Battles as B
on year(B.date) < A.launched
group by A.name
