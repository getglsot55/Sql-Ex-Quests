


-- Определить лидера по сумме выплат в соревновании между каждой существующей парой пунктов с одинаковыми номерами 
-- из двух разных таблиц - outcome и outcome_o - на каждый день, когда осуществлялся прием вторсырья хотя бы на одном из них.
-- Вывод: Номер пункта, дата, текст:
-- - "once a day", если сумма выплат больше у фирмы с отчетностью один раз в день;
-- - "more than once a day", если - у фирмы с отчетностью несколько раз в день;
-- - "both", если сумма выплат одинакова. 

-- cost 0.048341192305088 operations 13 
with
cta as (
select [point], [date], sum(out) s
from outcome
where [point] in (select point from [dbo].[Outcome_o])
group by [point], [date]),

ctb as (
select [point], [date], sum(out) s
from outcome_o
where [point] in (select point from [dbo].[Outcome])
group by [point], [date]),

ctc as (select
	coalesce([cta].[point], ctb.[point]) as point,
	coalesce([cta].[date], [ctb].[date]) as [date],
	coalesce([cta].[s], 0) as [sa],
	coalesce([ctb].[s], 0) as [sb]
from cta full join ctb on [ctb].[date] = [cta].[date] and [ctb].[point] = [cta].[point])
select 
	[ctc].[point],
	[ctc].[date],
	case
		when sa > sb then 'more than once a day'
		when sa < sb then 'once a day'
		else 'both'
	end lider
from ctc
order by [ctc].[point],[ctc].[date]