


-- Выбрать из таблицы Trip такие города, названия которых содержат минимум 2 разные буквы из списка (a,e,i,o,u) 
-- и все имеющиеся в названии буквы из этого списка встречаются одинаковое число раз. 

-- cost 0.033160284161568 operations 17 
with ctea as (
select distinct town_from [town] from [dbo].[Trip] union select town_to from [dbo].[Trip]),
cteb as (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u'),
ctec as (
select [town], DATALENGTH([ctea].[town]) - DATALENGTH(replace([ctea].[town], s, '')) as cs
from ctea, cteb),
ctee as (select [town], [cs], count(*) over(partition by [ctec].[town]) cc,
max(cs)  over(partition by [ctec].[town]) mxc, min(cs) over(partition by [ctec].[town]) mnc
from ctec where cs > 0)
select distinct town from ctee where cc > 1 and mxc = mnc;


with ctea as (
select distinct town_from [town] from [dbo].[Trip] union select town_to from [dbo].[Trip]),
cteb as (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u'),
ctec as (
select [town], LEN([ctea].[town]) - LEN(replace([ctea].[town], s, '')) as cs
from ctea, cteb),
ctee as (select [town], [cs], count(*) over(partition by [ctec].[town]) cc,
max(cs)  over(partition by [ctec].[town]) mxc, min(cs) over(partition by [ctec].[town]) mnc
from ctec where cs > 0)
select * from ctee
--select distinct town from ctee where cc > 1 and mxc = mnc;