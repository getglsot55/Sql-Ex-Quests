Задание: 145 (Serge I: 2019-01-04)
Для каждой пары последовательных дат, dt1 и dt2, поступления средств (таблица Income_o) найти сумму выдачи денег (таблица Outcome_o) в полуоткрытом интервале (dt1, dt2].
Вывод: сумма, левая граница интервала, правая граница интервала.

---

with A as (
select date as dt1, lead(date, 1) over(order by date) as dt2 from 
(select distinct date from Income_o) as B
)

select IIF(sum(out) !=0, sum(out), 0) as qty, dt1, dt2 
from A left join Outcome_o
on Outcome_o.date > dt1 and Outcome_o.date <= dt2
where dt2 is not NULL
group by dt1, dt2
