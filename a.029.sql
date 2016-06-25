
---
select point,date, sum(inc), sum(out)
from
(
select point, date, inc, 0 as out
from income_o 
union
select point, date, 0, out
from outcome_o
) as t1
group by point, date

---
select *
FROM income_o i FULL JOIN outcome_o o
ON i.point = o.point AND i.date = o.date;


---
with t1 as (
select point, date, inc, null as out
from income_o 
union
select point, date, null, out
from outcome_o)
select point,date, sum(inc), sum(out)
from t1
group by point, date