
-- Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

-- cost 0.014912073500454  operations 9 
-- SET ANSI_NULLS ON
select name, iif(datepart(yyyy, [date]) = null, 1, 0)
from battles
where datepart(yyyy, [date]) not in (select distinct [launched] from ships where [launched] is not null)

-- cost 0.017871307209134 operations 6 
select battles.name
from battles, ships
group by battles.name
having sum(iif(datepart(year, [date])=[launched], 1,0)) = 0

-- cost 0.024692656472325 operations 16 
select name
from battles
where DATEPART(yy, date) not in (select DATEPART(yy, date) from battles join ships on DATEPART(yy, date)=launched) 
