

-- Какое максимальное количество черных квадратов можно было бы окрасить в белый цвет
-- оставшейся краской 

-- cost 0.042029786854982 operations 10  SQS - 170 ms
with cte as (
select ((count(distinct [V_ID]) * 255 - sum([B_VOL]))/ 255) as fv
from utv left join [dbo].[utB] on [utB].[B_V_ID] = [utV].[V_ID]
group by [V_COLOR])
select min(fv) as qty from cte;


-- cost 0.075648672878742 operations 11 SQS - 
with ctea as (
	select [V_COLOR], count([V_ID]) * 255 ec from [dbo].[utV] group by [V_COLOR]),
cteb as (
	select [V_COLOR], sum([B_VOL]) as sc 
	from [dbo].[utB] join [dbo].[utV] on [utB].[B_V_ID] = [utV].[V_ID]
	group by [V_COLOR]),
ctec as (
	select [ctea].[V_COLOR], (ec - sc)/255 as fv from ctea join cteb on [cteb].[V_COLOR] = [ctea].[V_COLOR])
select min(fv) as qty from ctec;