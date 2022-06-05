Задание: 135 (Serge I: 2016-12-16)
В пределах каждого часа, в течение которого выполнялись окраски,
найти максимальное время окраски (B_DATETIME).

---

with A as (
select CONVERT(date, B_DATETIME) as A, datepart(hh, B_DATETIME) as B, B_DATETIME from utB
)

select max(B_DATETIME) from A
group by A, B
