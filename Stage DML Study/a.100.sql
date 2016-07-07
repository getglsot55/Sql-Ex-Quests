


-- Написать запрос, который выводит все операции прихода и расхода из таблиц Income и Outcome в следующем виде:
-- дата, порядковый номер записи за эту дату, пункт прихода, сумма прихода, пункт расхода, сумма расхода.
-- При этом все операции прихода по всем пунктам, совершённые в течение одного дня, упорядочены по полю code, 
-- и так же все операции расхода упорядочены по полю code.
-- В случае, если операций прихода/расхода за один день было не равное количество, 
-- выводить NULL в соответствующих колонках на месте недостающих операций.


-- cost 0.10797899216413 operations 28  SQS - 0,0040
select
	coalesce(t1.date, t2.date) as [date],
	coalesce(t1.ir, t2.ir) as [r],
	t1.point, t1.incs as inc,
	t2.point, t2.outs as out
from (
select it.[date], it.[point], it.code, rank() over(partition by it.date order by it.code) ir, it.inc as incs
from dbo.Income it ) t1 left join (
select ot.[date], ot.[point], ot.code, rank() over(partition by ot.date order by ot.code) ir, ot.out as outs
from dbo.Outcome ot ) t2 on t1.date = t2.date and t2.ir = t1.ir
union
select
	coalesce(t1.date, t2.date) as [date],
	coalesce(t1.ir, t2.ir) as [r],
	t1.point, t1.incs as inc,
	t2.point, t2.outs as out
from (
select it.[date], it.[point], it.code, rank() over(partition by it.date order by it.code) ir, it.inc as incs
from dbo.Income it ) t1 right join (
select ot.[date], ot.[point], ot.code, rank() over(partition by ot.date order by ot.code) ir, ot.out as outs
from dbo.Outcome ot ) t2 on t1.date = t2.date and t2.ir = t1.ir

-- cost 0.11983335018158 operations 28  SQS - 0,0010
with tinc as (select it.[date], it.[point], rank() over(partition by it.date order by it.code) ir, it.inc as incs
from dbo.Income it),
tout as (select ot.[date], ot.[point], rank() over(partition by ot.date order by ot.code) ir, ot.out as outs
from dbo.Outcome ot),
trs as (
select tinc.date idate, tout.date odate,
				tinc.incs,  tout.outs, tinc.ir iir, tout.ir oir, tinc.point ipoint, tout.point opoint
from tinc left join tout on tinc.date = tout.date and tinc.ir = tout.ir
union
select  tinc.date idate, tout.date odate,
				tinc.incs,  tout.outs, tinc.ir iir, tout.ir oir, tinc.point ipoint, tout.point opoint
from tinc right join tout on tinc.date = tout.date and tinc.ir = tout.ir)
select 
	coalesce(trs.idate, trs.odate) as [date],
	coalesce(trs.iir, trs.oir) as [r],
	trs.ipoint, trs.incs as inc,
	trs.opoint, trs.outs as out
from trs order by date, r