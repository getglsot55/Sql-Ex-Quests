

-- Считая, что каждая окраска длится ровно секунду, определить непрерывные интервалы времени с длительностью более 1 секунды из таблицы utB.
-- Вывод: дата первой окраски в интервале, дата последней окраски в интервале. 


-- cost 1.6475174427032 operations 66 
with 
ctz as (select distinct [B_DATETIME] from [dbo].[utB]),
ctn as (
select row_number() over(order by a.[B_DATETIME]) rn, a.[B_DATETIME] a_date, [b].[B_DATETIME] b_date
from ctz a join ctz b on datediff(second, a.[B_DATETIME], b.[B_DATETIME]) = 1),
cta as (select *, (select count(*) from ctn) cng from ctn),
ctb as (select rn crn, [cta].[a_date], [cta].[b_date], cng from cta where rn = 1
union all
select
	crn + 1 crn,
	case when (select [b].[a_date] from cta b where b.rn = (cb.crn + 1)) = cb.b_date then [cb].[a_date]
			else (select [b].[a_date] from cta b where b.rn = (cb.crn + 1)) end [a_date],
	(select [b].[b_date] from cta b where b.rn = (cb.crn + 1)) b_date,
	cng
from ctb cb
where crn < cng)
select [ctb].[a_date] [date_begin], max([b_date]) [date_end] from ctb
group by [ctb].[a_date];



-- not worker yet
with cts as (select distinct [B_DATETIME] from [dbo].[utB]),
cta as (select row_number() over(order by [B_DATETIME]) rn, (select count(*) from cts) rc, [B_DATETIME] from [cts]),
ctb as (select rc, 1 sr, 1 cr, p.[B_DATETIME] as cdt
from cta p where p.[rn] = 1
union all
select rc,
case
	when datediff(second, [a].[cdt], (select [c].[B_DATETIME] from [cta] c where [c].[rn] = (a.[cr] + 1))) = 1 or 
				datediff(second, [a].[cdt], (select [c].[B_DATETIME] from [cta] c where [c].[rn] = (a.[cr] + 1))) = 0
	then a.[sr]
	else a.[cr] + 1
end [sr],
a.[cr] + 1 cr,
(select [c].[B_DATETIME] from [cta] c where [c].[rn] = a.[cr] + 1) cdt
from ctb a
where cr < rc)
select cz2.[B_DATETIME] a_date, max([cz1].[cdt]) b_date
from ctb cz1 join cta cz2 on [cz1].[sr] = [cz2].[rn]
where datediff(second, cz2.[B_DATETIME], [cz1].[cdt]) > 0
group by cz2.[B_DATETIME]