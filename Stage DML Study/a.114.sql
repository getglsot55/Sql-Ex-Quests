

-- Определить имена разных пассажиров, которым чаще других доводилось лететь на одном и том же месте.
-- Вывод: имя и количество полетов на одном и том же месте. 

-- cost 0.043349102139473 operations 13 
with cte as(select [ID_psg], count(*) c from [dbo].[Pass_in_trip] group by [Pass_in_trip].[ID_psg], [place]),
ctb as (select distinct [ID_psg], [c] from cte where [cte].[c] = (select max(c) from [cte]))
select [name],[ctb].[c]
from ctb join [dbo].[Passenger] on [Passenger].[ID_psg] = [ctb].[ID_psg];

-- cost 0.044454202055931 operations 9 
select [name], [tz].[c]
from (
select distinct * from(
select top 1 with ties [ID_psg], c
from (select [ID_psg], count(*) c from [dbo].[Pass_in_trip] group by [Pass_in_trip].[ID_psg], [place]) tr
order by c desc) ty ) tz join [dbo].[Passenger] on [Passenger].[ID_psg] = [tz].[ID_psg];

-- cost 0.03812874481082 operations 15 
select name, [c]
from (
select distinct [ID_psg], [tr].[c]
from ( 
select [ID_psg], count(*) c, max(count(*)) over() cm
from [dbo].[Pass_in_trip] group by [Pass_in_trip].[ID_psg], [place] ) tr
where [tr].[c] = [tr].[cm]) trr  join [dbo].[Passenger] on [Passenger].[ID_psg] = [trr].[ID_psg]

-- cost 0.033165704458952 operations 8 
select top 1 with ties [name], [tr].[c]
from (
select distinct [ID_psg], count(*) c 
from [dbo].[Pass_in_trip] 
group by [Pass_in_trip].[ID_psg], [place]
) tr join [dbo].[Passenger] on [Passenger].[ID_psg] = [tr].[ID_psg]
order by [tr].[c] desc

