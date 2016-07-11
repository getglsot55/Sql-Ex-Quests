


-- Предполагая, что среди идентификаторов квадратов имеются пропуски, найти минимальный и максимальный "свободный" идентификатор 
-- в диапазоне между имеющимися максимальным и минимальным идентификаторами. 
-- Например, для последовательности идентификаторов квадратов 1,2,5,7 результат должен быть 3 и 6.
-- Если пропусков нет, вместо каждого искомого значения выводить NULL.

-- cost 0.020263006910682 operations 23 
select (
select top 1 [mo].[Q_ID] + 1 id
from [dbo].[utQ] mo
where not exists (select  null from [dbo].[utQ] mi where mi.[Q_ID] = mo.[Q_ID] + 1)
and [mo].[Q_ID] < (select max([Q_ID]) from [dbo].[utQ])
order by [mo].[Q_ID]) minq,
(
select top 1 [mo].[Q_ID] - 1 id
from [dbo].[utQ] mo
where not exists (select  null from [dbo].[utQ] mi where mi.[Q_ID] = mo.[Q_ID] - 1)
and [mo].[Q_ID] > (select min([Q_ID]) from [dbo].[utQ])
order by [mo].[Q_ID] desc
) maxq



-- select all holes
with cta as (
select row_number() over(order by [mo].[Q_ID]) rn, [mo].[Q_ID] + 1 id
from [dbo].[utQ] mo
where not exists (select  null from [dbo].[utQ] mi where mi.[Q_ID] = mo.[Q_ID] + 1)
and [mo].[Q_ID] < (select max([Q_ID]) from [dbo].[utQ])),
ctb as (select row_number() over(order by [mo].[Q_ID]) rn, [mo].[Q_ID] - 1 id
from [dbo].[utQ] mo
where not exists (select  null from [dbo].[utQ] mi where mi.[Q_ID] = mo.[Q_ID] - 1)
and [mo].[Q_ID] > (select min([Q_ID]) from [dbo].[utQ]))
select cta.[id], [ctb].[id]
from cta join ctb on [ctb].[rn] = [cta].[rn]


--with ctss as (select 1 n union all select 3  union all select 4  union all select 7  union all 
--select 8  union all select 9  union all select 10  union all select 11  union all select 12)
--select * from ctss;

--select q_id+1 as id from [dbo].[utQ]
--except 
--select q_id from [dbo].[utQ]

--select * from [dbo].[utQ]