


-- Сгруппировать все окраски по дням, месяцам и годам. Идентификатор каждой группы должен иметь вид "yyyy" для года,
-- "yyyy-mm" для месяца и "yyyy-mm-dd" для дня.
-- Вывести только те группы, в которых количество различных моментов времени (b_datetime), когда выполнялась окраска, более 10.
-- Вывод: идентификатор группы, суммарное количество потраченной краски.


-- cost 0.079849109053612 operations 19 
with cte as (
select convert(varchar(10), B_DATETIME, 127) fg, [B_DATETIME], [B_VOL] from [dbo].[utB]
union
select convert(varchar(7), B_DATETIME, 127) fg,  [B_DATETIME], [B_VOL] from [dbo].[utB]
union
select convert(varchar(4), B_DATETIME, 127) fg,  [B_DATETIME], [B_VOL] from [dbo].[utB])
select fg, sum(b_vol)
from cte
group by fg
having count(distinct [B_DATETIME]) > 10


-- cost 0.032300606369972 operations 8 
select DateStr, sum(B_VOL) SUMVOL
from utB b
cross apply(select convert(varchar(10), b.B_DATETIME, 127) DateStr
	union all select convert(varchar(7),  b.B_DATETIME, 127) 
	union all select convert(varchar(4),  b.B_DATETIME, 127)  /**/ ) d
group by DateStr
having count(distinct b.B_DATETIME) >  10

-- cost 0.031143957749009 operations 10 
SELECT date, sum(b_vol)vol
FROM( SELECT b_vol, b_datetime
           , convert(varchar(10),convert(char(10),b_datetime,120))ymd
           , convert(varchar(10),convert(char(7),b_datetime,120))ym
           , convert(varchar(10),convert(char(4),b_datetime,120))y
      FROM utb )p
UNPIVOT( date FOR xxx IN(ymd,ym,y) )AS unp
GROUP BY date
HAVING count(DISTINCT b_datetime)> 10