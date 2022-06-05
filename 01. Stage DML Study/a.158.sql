Задание: 158 (Serge I: 2021-10-08)
Для таблицы outcome определить прирост расхода каждого дня относительно среднедневного расхода двух предшествующих дней (когда был расход).
Вывод: дата, прирост.

---

with A as (
select date, sum(out) as out from outcome
group by date
)

select date, out - avg(out) over(order by date rows between 2 preceding
and 1 preceding) from A
