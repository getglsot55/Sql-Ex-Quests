

-- Посчитать остаток денежных средств на всех пунктах приема на начало дня 15/04/01 для базы данных с отчетностью не чаще одного раза в день

--cost 0.019530342891812  operations 10 
select sum(inc) - sum(out)
from (select [date], inc, 0 as [out] from dbo.Income_o union all select [date], 0 as inc, [out] from dbo.Outcome_o) as st
where [date] < datefromparts(2001, 04 ,15)