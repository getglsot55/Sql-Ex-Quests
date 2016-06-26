use [sql-ex]

select
	case
	when months/12 > 0
	then cast(months/12 as varchar(4)) + ' y., '
	else ''
	end +
	case
	when months - months/12 *12 > 0
	then cast(months - months/12 *12 as varchar(2)) + ' m.'
	else ''
	end  as age,
	datename(year,date1)+'-'+
	case
	when Month(date1)>=10 then cast(Month(date1) as char(2))
	else '0'+cast(Month(date1) as char(1))
	end +
	case
	when day(date1)>=10 then '-'+cast(day(date1) as char(2))
	else '-0'+cast(day(date1) as char(1))
	end
	as date1,
	datename(year,date2)+'-'+
	case
	when Month(date2)>=10 then cast(Month(date2) as char(2))
	else '0'+cast(Month(date2) as char(1))
	end +
	case
	when day(date2)>=10 then '-'+cast(day(date2) as char(2))
	else '-0'+cast(day(date2) as char(1))
	end
	as date2
from 
(
	select date1,date2, datediff(month, date1, date2) - iif(datepart(day, date1) > datepart(day, date2), 1, 0) as months
	from
	(	
		select date as date1,
		COALESCE((select min(date) from battles b where b.date > b2.date), GETDATE()) date2
		from battles b2
	) as t
) as t2
order by date1