

-- ѕусть v1, v2, v3, v4, ... представл€ет последовательность вещественных чисел - объемов окрасок b_vol, 
-- упор€доченных по возрастанию b_datetime, b_q_id, b_v_id. 
-- Ќайти преобразованную последовательность P1=v1, P2=v1/v2, P3=v1/v2*v3, P4=v1/v2*v3/v4, ..., 
-- где каждый следующий член получаетс€ из предыдущего умножением на vi (при нечетных i) или делением на vi (при четных i). 
-- –езультаты представить в виде b_datetime, b_q_id, b_v_id, b_vol, Pi, где Pi - член последовательности, 
-- соответствующий номеру записи i. ¬ывести Pi с 8-ю знаками после зап€той. 

-- cost 0.049351383000612 operations 25 SQS - 20 ms
with cte1 as (
select	row_number() over(order by b_datetime, b_q_id, b_v_id) rn,
	(select count(*) from dbo.utB) as rc,	b_datetime, b_q_id, b_v_id, b_vol
from dbo.utB),
cte2 as (
select [rn], b_datetime, b_q_id, b_v_id, b_vol, cast(b_vol as float) as [Pi]
from cte1 where [rn] = 1
union all
select cte2.[rn] + 1, cte1.b_datetime, cte1.b_q_id, cte1.b_v_id, cte1.b_vol,
case when (cte2.[rn] + 1) % 2 = 0 then cte2.[Pi] / cast(cte1.[b_vol] as float) else cte2.[Pi] * cast(cte1.[b_vol] as float) end as [Pi]
from cte2 join cte1 on cte1.rn  = (cte2.rn + 1)
where cte2.rn <= rc)
select b_datetime, b_q_id, b_v_id, b_vol, cast([Pi] as decimal(18,8)) 
from cte2 OPTION (MAXRECURSION 300);


-- cost 0.049351383000612 operations 25 SQS - 20 ms
with cte1 as (
select	row_number() over(order by b_datetime, b_q_id, b_v_id) rn,
	count(*) over() as rc,	b_datetime, b_q_id, b_v_id, b_vol
from dbo.utB),
cte2 as (
select [rn], b_datetime, b_q_id, b_v_id, b_vol, cast(b_vol as float) as [Pi]
from cte1 where [rn] = 1
union all
select cte2.[rn] + 1, cte1.b_datetime, cte1.b_q_id, cte1.b_v_id, cte1.b_vol,
case
	when (cte2.[rn] + 1) % 2 = 0 then cte2.[Pi] / cast(cte1.[b_vol] as float) else cte2.[Pi] * cast(cte1.[b_vol] as float)
end as [Pi]
from cte2 join cte1 on cte1.rn  = (cte2.rn + 1)
where cte2.rn <= rc)
select b_datetime, b_q_id, b_v_id, b_vol, cast([Pi] as decimal(18,8)) from cte2 OPTION (MAXRECURSION 300);