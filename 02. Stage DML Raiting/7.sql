

-- Среди пассажиров, летавших на самолетах только одного типа, определить тех, кто прилетал в один и тот же город не менее 2-х раз.
-- Вывести имена пассажиров.

-- cost 0.085055135190487 operations 19 
select [p].[name]--, [t1].[pc], [t2].[tc]
from [dbo].[Passenger] [p]
cross apply (select count(distinct [plane]) as [pc] from [dbo].[Trip] [t] join [dbo].[Pass_in_trip] [pit] on [t].[trip_no] = [pit].[trip_no]
			where [pit].[ID_psg] = [p].[ID_psg]) as t1
cross apply (select count(ltrim(rtrim([t].[town_to]))) as [tc]
			from [dbo].[Pass_in_trip] [pit] join [dbo].[Trip] [t] on [pit].[trip_no] = [t].[trip_no]
			where [pit].[ID_psg] = [p].[ID_psg]
			group by [t].[town_to]) as t2
where [t1].[pc] = 1 and [t2].[tc] >= 2
group by [p].[ID_psg],  [p].[name];
--order by [p].[name];


-- cost 0.061584934592247  operations 24  
with cte as (select [pit].[ID_psg], [t].[plane], [t].[town_to],
dense_rank() over (partition by [pit].[ID_psg] order by [t].[plane]) + dense_rank() over (partition by [pit].[ID_psg] order by [t].[plane] desc) - 1 as [pc],
count([t].[town_to]) over(partition by [pit].[ID_psg], [t].[town_to]) as [tc]
from [dbo].[Pass_in_trip] [pit] join [dbo].[Trip] [t] on [pit].[trip_no] = [t].[trip_no])
select [p].[name] from [dbo].[Passenger] as  [p] where [p].[ID_psg] in (
	select [ID_psg] from [cte] where [cte].[pc] = 1 and [cte].[tc] >= 2);