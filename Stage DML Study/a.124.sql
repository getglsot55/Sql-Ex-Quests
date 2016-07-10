

-- Среди пассажиров, которые пользовались услугами не менее двух авиакомпаний, 
-- найти тех, кто совершил одинаковое количество полётов самолетами каждой из этих авиакомпаний. Вывести имена таких пассажиров. 

-- cost 0.040437519550323 operations 18 
with	[cte]
				as (select	[ID_psg], [ID_comp], max(count(*)) over (partition by [ID_psg]) as [mxctc],
										min(count(*)) over (partition by [ID_psg]) as [mnctc], count(*) over (partition by [ID_psg]) as [cc]
						from		[dbo].[Pass_in_trip]
										join [dbo].[Trip] on [Trip].[trip_no] = [Pass_in_trip].[trip_no]
						group by [ID_psg], [ID_comp])
	select	[name]
	from		[dbo].[Passenger]
					join [cte] on [cte].[ID_psg] = [Passenger].[ID_psg]
	where		[cte].[mxctc] = [cte].[mnctc] and [cte].[cc] >= 2
	group by [Passenger].[ID_psg], [name];
