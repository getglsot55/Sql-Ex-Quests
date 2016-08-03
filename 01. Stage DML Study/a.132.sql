

-- Для каждой даты битвы (date1) взять дату следующей в хронологическом порядке битвы (date2), а если такой даты нет, то текущую дату.
-- Определить на дату date2 возраст человека, родившегося в дату date1 (число полных лет и полных месяцев).
-- Замечания:
-- 1) считать, что полное число месяцев исполняется в дату дня рождения, или ранее, при условии, что более поздних дат в искомом месяце нет; 
-- за полный год принимаются 12 полных месяцев; все битвы произошли в разные даты и до сегодняшнего дня.
-- 2) даты представить без времени в формате "yyyy-mm-dd", возраст в формате "Y y., M m.", не выводить год или месяц если они равны 0, 
-- для возраста менее 1 мес. выводить пустую строку. 
-- Вывод: возраст, date1, date2. 

-- cost 0.0095267798751593 operations 6 
with cte as (select [date] as date1, date2,
	datediff(month, [date], date2) - 
	iif(datepart(day, date2) < datepart(day, [date]) and 
			datepart(day, [date]) <= datepart(day,eomonth(date2)), 1, 0)   as months
from battles cross apply 
(select coalesce(min(date), getdate()) date2 from battles b where b.date > battles.date) x)
select
	case
		when months/12 > 0 then cast(months/12 as varchar(4)) + 
			case when months - months/12 *12 > 0 then ' y., ' else ' y.' end
		else '' end +
	case when months - months/12 *12 > 0 then cast(months - months/12 * 12 as varchar(2)) + ' m.' else '' end  as age,
	convert(varchar(10), [date1], 127) as date1,
	convert(varchar(10), [date2], 127) as date2
from cte





declare @d1 datetime = cast('2014-01-28 00:00:00.000' as datetime);
--declare @d2 datetime = cast('2014-02-28 00:00:00.000' as datetime);
--declare @d1 datetime = cast('2016-06-25 00:00:00.000' as datetime);
--declare @d2 datetime = cast('2016-07-10 00:00:00.000' as datetime);
select convert(varchar(10), @d1, 127)
--select --@d1, @d2, @d3,
--	datediff(month, @d1, @d2) as m11,
--	datediff(month, @d1, @d2) - 
--	iif(datepart(day, @d2) < datepart(day, @d1) and datepart(day, @d1) <= datepart(day,eomonth(@d2)), 1, 0) 
--	m12
