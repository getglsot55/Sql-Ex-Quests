

-- Из таблицы Outcome получить все записи за тот месяц (месяцы), с учетом года, в котором суммарное значение расхода (out) было максимальным. 


-- cost 0.047638323158026 operations 9 
with t1  as(
select top 1 with ties datepart(year, [date]) [eyear], datepart(month, [date]) [emonth]
from dbo.Outcome
group by datepart(year, [date]), datepart(month, [date])
order by sum([out]) desc)
select code, [point], [date], [out]
from t1 join dbo.Outcome as o on t1.[eyear] = datepart(year, o.[date]) and t1.[emonth] = datepart(month, o.[date])