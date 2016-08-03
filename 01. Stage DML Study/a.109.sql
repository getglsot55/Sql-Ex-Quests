

-- Вывести:
-- 1. Названия всех квадратов черного или белого цвета.
-- 2. Общее количество белых квадратов.
-- 3. Общее количество черных квадратов

--select *
--from dbo.utQ left join dbo.utB on utB.B_Q_ID = utQ.Q_ID left join dbo.utV on utV.V_ID = utB.B_V_ID
--group by B_Q_ID, V_COLOR


--select Q_ID, sum(B_VOL), V_COLOR
--from dbo.utQ left join dbo.utB on utB.B_Q_ID = utQ.Q_ID left join dbo.utV on utV.V_ID = utB.B_V_ID
--group by Q_ID, V_COLOR

-- cost 0.072603791952133 operations 17 

--DBCC DROPCLEANBUFFERS
--DBCC FREEPROCCACHE
--GO
--SET STATISTICS IO ON;
--SET STATISTICS TIME ON;
--GO

select tr.Q_NAME,
	sum(case when Col = 'W' then 1 else 0 end) over() [Whites],
	sum(case when Col = 'B' then 1 else 0 end) over() [Blacks]
from (
select pvt.Q_NAME,
	case
		when coalesce(pvt.R, 0) = 255 and coalesce(pvt.G, 0) = 255 and coalesce(pvt.B, 0) = 255 then 'W'
		when coalesce(pvt.R, 0) = 0 and coalesce(pvt.G, 0) = 0 and coalesce(pvt.B, 0) = 0 then 'B'
		else 'S'
	end as Col
from (
select Q_ID, Q_NAME, B_VOL, V_COLOR
from dbo.utQ left join dbo.utB on utB.B_Q_ID = utQ.Q_ID left join dbo.utV on utV.V_ID = utB.B_V_ID) t1
pivot(sum(B_VOL) for V_COLOR in ([R], [G], [B])) pvt ) tr
where Col = 'W' or Col = 'B'

--SET STATISTICS IO OFF;
--SET STATISTICS TIME OFF;
--GO


with tr as (
select pvt.Q_NAME,
	case
		when coalesce(pvt.R, 0) = 255 and coalesce(pvt.G, 0) = 255 and coalesce(pvt.B, 0) = 255 then 'W'
		when coalesce(pvt.R, 0) = 0 and coalesce(pvt.G, 0) = 0 and coalesce(pvt.B, 0) = 0 then 'B'
		else 'S'
	end as Col
from (
select Q_ID, Q_NAME, B_VOL, V_COLOR
from dbo.utQ left join dbo.utB on utB.B_Q_ID = utQ.Q_ID left join dbo.utV on utV.V_ID = utB.B_V_ID) t1
pivot(sum(B_VOL) for V_COLOR in ([R], [G], [B])) pvt ) 
select tr.Q_NAME,
	sum(case when Col = 'W' then 1 else 0 end) over() [Whites],
	sum(case when Col = 'B' then 1 else 0 end) over() [Blacks]
from tr
where Col = 'W' or Col = 'B'