Задание: 161 (Kursist: 2021-11-13)
Выведите страны, корабли которых не участвовали ни в одной битве.

---

with A as (
select Classes.country from Battles join Outcomes 
on Battles.name = Outcomes.battle
join Classes on Outcomes.ship = Classes.class
   union
select distinct Classes.country from Battles join Outcomes
on Battles.name = Outcomes.battle
join Ships on Outcomes.ship = Ships.name
join Classes on Ships.class= Classes.class
)


select distinct country from Classes except (select * from A)
