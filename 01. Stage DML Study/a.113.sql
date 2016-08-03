


-- Сколько каждой краски понадобится, чтобы докрасить все Не белые квадраты до белого цвета.
-- Вывод: количество каждой краски в порядке (R,G,B) 

-- cost 0.044770773500204 operations 12 
select * from (
select [V_COLOR], (select count(*) from [dbo].[utQ]) * 255 - sum([B_VOL]) as v
from [dbo].[utB] join [dbo].[utV] on [utV].[V_ID] = [utB].[B_V_ID]
group by [V_COLOR]) tr
pivot(sum(v) for [V_COLOR] in ([R], [G], [B])) pvt
