	

-- Используя таблицы Income и Outcome, для каждого пункта приема определить дни, когда был приход, но не было расхода и наоборот.
-- Вывод: пункт, дата, тип операции (inc/out), денежная сумма за день. 


-- cost 0.01841352134943 operations 9 
with iof as (
	select point, [date], inc, 0 as [out]
	from dbo.Income
	union all
	select point, [date], 0 as inc, [out]
	from dbo.Outcome)
select [point], [date],
	case when sum(inc) = 0 then 'out' else 'inc' end as [operation],
	case when sum(inc) = 0 then sum([out]) else sum([inc]) end as [sum]
from iof
group by point,[date]
having sum([out]) = 0 or sum([inc]) = 0