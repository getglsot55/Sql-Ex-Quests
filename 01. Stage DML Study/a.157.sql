Задание: 157 (Kursist: 2021-09-17)
Для всех непотопленных кораблей из базы определить количество битв, в которых они участвовали.
Вывести название корабля, количество битв.

---

with A as (
select ship from Outcomes where result = 'sunk'
),

B as (
select name as name1, battle as ff from Ships left join Outcomes 
on Ships.name = Outcomes.ship
where name not in (select ship from Outcomes where result = 'sunk')
   union 
select ship as name1, battle as ff from Outcomes
where ship not in (select ship from Outcomes where result = 'sunk')
)

select name1, count(ff) from B group by name1
