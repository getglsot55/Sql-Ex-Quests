

-- Для каждой даты битвы (date1) взять дату следующей в хронологическом порядке битвы (date2), а если такой даты нет, то текущую дату.
-- Определить на дату date2 возраст человека, родившегося в дату date1 (число полных лет и полных месяцев).
-- Замечания:
-- 1) считать, что полное число месяцев исполняется в дату дня рождения, или ранее, при условии, что более поздних дат в искомом месяце нет; 
-- за полный год принимаются 12 полных месяцев; все битвы произошли в разные даты и до сегодняшнего дня.
-- 2) даты представить без времени в формате "yyyy-mm-dd", возраст в формате "Y y., M m.", не выводить год или месяц если они равны 0, 
-- для возраста менее 1 мес. выводить пустую строку. 
-- Вывод: возраст, date1, date2. 

-- 
select
	case when months/12 > 0 then cast(months/12 as varchar(4)) + ' y., ' else '' end +
	case when months - months/12 *12 > 0 then cast(months - months/12 * 12 as varchar(2)) + ' m.' else '' end  as age,
	datename( year, date1) + '-' + 
	case when Month(date1)>=10 then cast(Month(date1) as char(2)) else '0' + cast(Month(date1) as char(1)) end +
	case when day(date1)>=10 then '-'+cast(day(date1) as char(2)) else '-0' + cast(day(date1) as char(1)) end as date1,
	datename(year,date2) + '-' +
	case when Month(date2)>=10 then cast(Month(date2) as char(2)) else '0' + cast(Month(date2) as char(1)) end +
	case when day(date2)>=10 then '-'+cast(day(date2) as char(2)) else '-0' + cast(day(date2) as char(1)) end as date2
from 
(
	select date1, date2,
		datediff(month, date1, date2) - 
		iif(datepart(day, date1) > datepart(day, date2) and (datepart(day,eomonth(date2)) >= datepart(day, date1)), 1, 0) as months
	from
	(	
		select date as date1, coalesce((select min(date) from battles b where b.date > b2.date), GETDATE()) date2
		from battles b2
	) as t
) as t2
order by date1


select
	case when months/12 > 0 then cast(months/12 as varchar(4)) + ' y., ' else '' end +
	case when months - months/12 *12 > 0 then cast(months - months/12 * 12 as varchar(2)) + ' m.' else '' end  as age,
	format([t2].[date1], 'yyyy-MM-dd', 'en-US' ) as date1,
	format([t2].[date2], 'yyyy-MM-dd', 'en-US' ) as date2
from 
(
	select date1, date2,
		datediff(month, date1, date2) - 
	iif(datepart(day, date1) > datepart(day, date2) and (datepart(day,eomonth(date2)) >= datepart(day, date1)), 1, 0) +
	iif(date2 = eomonth(date2) and datepart(day, date1) > datepart(day, date2), 1, 0) as months
	from
	(	
		select date as date1, coalesce((select min(date) from battles b where b.date > b2.date), GETDATE()) date2
		from battles b2
	) as t
) as t2
order by date1



declare @d1 datetime = cast('2014-01-31 00:00:00.000' as datetime);
declare @d2 datetime = cast('2015-02-28 00:00:00.000' as datetime);
declare @d3 datetime = cast('2014-02-28 00:00:00.000' as datetime);
select --@d1, @d2, @d3,
	datediff(month, @d1, @d3) as m13a,
	datediff(month, @d1, @d3) - 
	iif(datepart(day, @d1) > datepart(day, @d3) and (datepart(day,eomonth(@d3)) >= datepart(day, @d1)), 1, 0) +
	iif(@d3 = eomonth(@d3) and datepart(day, @d1) > datepart(day, @d3), 1, 0) m13b
	--datediff(month, @d1, @d2) - iif(datepart(day, @d1) > datepart(day, @d2), 1, 0) as m1,
	--datediff(month, @d1, @d2) as m2,
	--datediff(month, @d1, @d2) - iif(datepart(day, @d1) > datepart(day, @d2) and (datepart(day,eomonth(@d2)) >= datepart(day, @d1)), 1, 0) m3,
	--datepart(day, @d1) m4,
	--datepart(day,eomonth(@d2)) m5

