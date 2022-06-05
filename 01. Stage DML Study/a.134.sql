Задание: 134 (Serge I: 2003-12-26)
Выполняется докраска квадратов до белого цвета каждым цветом по следующей схеме:
- сначала закрашиваются квадраты, для которых требуется меньше краски соответствующего цвета;
- при одинаковом необходимом количестве краски сначала закрашиваются квадраты с меньшим q_id.
Найти идентификаторы НЕ белых квадратов, оставшихся после израсходования всей краски.

---

with A as (
   select 'R' as col, 0 as vol
union all
   select 'G', 0
union all
   select 'B', 0
), 

B as (
select utQ.Q_ID, coalesce(utV.V_COLOR, '') as color, utB.B_VOL volume 
   from utQ left join utB on utQ.Q_ID = utB.B_Q_ID left join utV 
on utB.B_V_ID  = utV.V_ID
   union all
select Q_ID, col, vol from utQ, A
),

C as (
select Q_ID, color, sum(volume) vol from B group by Q_ID, color
),

D as (
select V_ID, V_COLOR, 255-sum(coalesce(B_VOL, 0)) as ost 
   from utV left join utB
on utV.V_ID = utB.B_V_ID 
   group by V_ID, V_COLOR
   having sum(coalesce(B_VOL, 0)) < 255
),

E as (
select V_COLOR, sum(ost) as ost from D group by V_COLOR
),

F as (
select *, sum(vol) over(partition by Q_ID) sum_col from C join E on C.color = E.V_COLOR
),

G as (
select 255-vol as nuzno, Q_ID, color,  ost, ost-sum(255-vol) over(partition by color order by 255-vol asc, Q_ID ROWS UNBOUNDED PRECEDING) as kopit from F
where sum_col < 765
)

select distinct Q_ID from G
where kopit < 0
