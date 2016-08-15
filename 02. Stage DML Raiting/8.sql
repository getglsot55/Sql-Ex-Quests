

-- Для каждого сражения определить день, являющийся последней пятницей месяца, в котором произошло данное сражение.
-- Вывод: сражение, дата сражения, дата последней пятницы месяца.
-- Даты представить в формате "yyyy-mm-dd"


-- cost 0.0033108000643551 operations 2 
select [b].[name],
	format([b].[date],'yyyy-MM-dd'),
	format(dateadd(dy,datediff(dy, '17530105', eomonth([b].[date],0))/7*7, '17530105'), 'yyyy-MM-dd') as [lf]
from [dbo].[Battles] [b];

--cost 0.0033108000643551 operations 2 
select [b].[name],
	convert(char(10), [b].[date],127) as [date],
	convert(char(10), DATEADD(DY,DATEDIFF(DY,'17530105',DATEADD(MM,DATEDIFF(MM,0,[b].[date]),30))/7*7,'17530105'), 127) as [lf]
from [dbo].[Battles] [b];
