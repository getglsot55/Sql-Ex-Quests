


-- Считая, что первый пункт вылета является местом жительства, найти пассажиров, которые находятся вне дома.
-- Вывод: имя пассажира, город проживания 

-- cost 0.097485534846783 operations 27 
with cta as (
select [ID_psg], [town_from], [town_to], [date] + [time_out] as date_out,
min([date] + [time_out]) over (partition by [dbo].[Pass_in_trip].[ID_psg]) mnd,
max([date] + [time_out]) over (partition by [dbo].[Pass_in_trip].[ID_psg]) mxd
from [dbo].[Pass_in_trip] join [dbo].[Trip] on [Trip].[trip_no] = [Pass_in_trip].[trip_no])
select [dbo].[Passenger].[name], [jta].[b_town]
from (
select [cta].[ID_psg], [cta].[town_from] as b_town
from cta where [cta].[date_out] = [cta].[mnd]) jta join (
select [cta].[ID_psg], [cta].[town_to] as c_town
from cta where [cta].[date_out] = [cta].[mxd]) jtb on [jtb].[ID_psg] = [jta].[ID_psg] 
join [dbo].[Passenger] on [Passenger].[ID_psg] = [jta].[ID_psg]
where [jta].[b_town] <> [jtb].[c_town]


-- cost 2.9947855472565 operations 57 
with cta as (
select [ID_psg], [town_from], [town_to], [date] + [time_out] as date_out,
min([date] + [time_out]) over (partition by [dbo].[Pass_in_trip].[ID_psg]) mnd,
max([date] + [time_out]) over (partition by [dbo].[Pass_in_trip].[ID_psg]) mxd
from [dbo].[Pass_in_trip] join [dbo].[Trip] on [Trip].[trip_no] = [Pass_in_trip].[trip_no])
select distinct [dbo].[Passenger].[name],
(select [cta].[town_from] from cta where [cta].[date_out] = [cta].[mnd] and [cta].[ID_psg] = ta.[ID_psg]) [town]
from 
cta ta join [dbo].[Passenger] on [Passenger].[ID_psg] = [ta].[ID_psg]
where (select [cta].[town_from] from cta where [cta].[date_out] = [cta].[mnd] and [cta].[ID_psg] = ta.[ID_psg]) <>
	(select [cta].[town_to] from cta where [cta].[date_out] = [cta].[mxd] and [cta].[ID_psg] = ta.[ID_psg])