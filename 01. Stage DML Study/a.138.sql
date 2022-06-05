Задание: 138 (Serge I: 2017-03-10)
Найти все уникальные пары нечёрных квадратов (q_id1 и q_id2), которые окрашивались одним и тем же множеством баллончиков.
Вывод: q_id1, q_id2, где q_id1 < q_id2.

---

with A as (
select distinct Q_ID, B_V_ID, count(*) over(partition by Q_ID) as flag 
from utQ join utB
on utQ.Q_ID = utB.B_Q_ID
),

B as (
select Q_ID, B_V_ID, count(*) over(partition by Q_ID) as flag from A
),

CC as (
select C.Q_ID as F1, C.flag, D.Q_ID, count(*) over(partition by C.Q_ID, D.Q_ID) as cnt from B as C, B as D
where C.Q_ID < D.Q_ID
and C.B_V_ID = D.B_V_ID
and C.flag = D.flag
)

select distinct CC.F1, CC.Q_ID from CC
where flag = cnt
