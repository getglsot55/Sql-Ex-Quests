
-- В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)],
-- написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o. 

-- cost 0.013798980973661 operations 7 

select point,date, sum(inc) as inc, sum(out) as out
from
(
select point, date, inc, null as out
from income_o 
union
select point, date, null, out
from outcome_o
) as t1
group by point, date


-- cost 0.01376948133111  operations 4 

select 
case when i.point is null then o.point else i.point end as point,
case when i.point is null then o.[date] else i.[date] end as [date],
i.[inc], o.[out]
FROM income_o i FULL JOIN outcome_o o
ON i.point = o.point AND i.date = o.date;


-- cost 0.013798980973661  operations 7 

with t1 as (
select point, date, inc, null as out
from income_o 
union
select point, date, null, out
from outcome_o)
select point,date, sum(inc), sum(out)
from t1
group by point, date