Задание: 154 (Kursist: 2020-04-17)
Считать, что во всех таблицах поле point с одним и тем же номером указывает на один и тот же пункт.
Для каждого пункта посчитать сумму расхода и прихода за каждый день когда были операции у этого пункта отдельно по таблицам с отчетностью один раз в день и отдельно с отчетностью несколько раз в день.
Если в один день у пункта были операции как по отчетности один раз в день, так и с отчетностью несколько раз в день, то такие данные не выводить.

Вывод: пункт, дата, сумма прихода, сумма расхода, 'once' - если тип отчетности один раз в день и 'several' если несколько.
Замечание: При отсутствии прихода/расхода выводить 0.

---

with Dates_Once as ( select point, date from Income_o 
   union
 select point, date from Outcome_o ),

Dates_Several as ( select point, date from Income 
   union
 select point, date from Outcome ),

A as (
select AA.point, AA.date, sum(inc) as inc, null as out, 'once' as how 
from Income_o as AA
where AA.date not in (select date from Dates_Several where point = AA.point)
group by AA.point, AA.date
   union 
select CC.point, CC.date, sum(inc) as inc, null as out, 'several' as how 
from Income as CC
where CC.date not in (select date from Dates_Once where point = CC.point)
group by CC.point, CC.date
),

B as (
select BB.point as point2, BB.date as date2, null as inc2, sum(out) as out2
, 'once' as how2 from Outcome_o as BB
where BB.date not in (select date from Dates_Several where point = BB.point)
group by BB.point, BB.date
   union 
select DD.point, DD.date, null, sum(out)
, 'several' as how from Outcome as DD
where DD.date not in (select date from Dates_Once where point = DD.point)
group by DD.point, DD.date
)

select  coalesce(point, point2) as point
, coalesce(date, date2) date
, IIF(coalesce(inc, inc2) is null, 0, coalesce(inc, inc2)) inc
, IIF(coalesce(out, out2) is null, 0, coalesce(out, out2)) as out
, coalesce(how, how2) how
 from A full outer join B
on A.point = B.point2 and A.date = B.date2
