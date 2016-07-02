

-- Посчитать остаток денежных средств на начало дня 15/04/01 на каждом пункте приема для базы данных с отчетностью не чаще одного раза в день. Вывод: пункт, остаток.
-- Замечание. Не учитывать пункты, информации о которых нет до указанной даты. 


--cost 0.019530342891812  operations 10 
select point, sum(inc) - sum(out)
from (select point, [date], inc, 0 as [out] from dbo.Income_o union all select point, [date], 0 as inc, [out] from dbo.Outcome_o) as st
where [date] < datefromparts(2001, 04 ,15)
group by point
