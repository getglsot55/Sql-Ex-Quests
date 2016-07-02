

-- Посчитать остаток денежных средств на всех пунктах приема для базы данных с отчетностью не чаще одного раза в день. 


--cost 0.0081115812063217 operations 12 
select sum(inc) - sum(out)
from (select inc, 0 as [out] from dbo.Income_o union all select 0 as inc, [out] from dbo.Outcome_o) as st