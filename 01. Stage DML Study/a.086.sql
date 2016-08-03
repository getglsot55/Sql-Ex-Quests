

-- Для каждого производителя перечислить в алфавитном порядке с разделителем "/" все типы выпускаемой им продукции.
-- Вывод: maker, список типов продукции


-- cost 0.027536956593394 operations 8 
select maker, replace(coalesce([1] + '/','') + coalesce([2] + '/','--') + 
coalesce([3],iif([2] is null, '/--','--')),'/--','')
from (
select distinct maker, [type], dense_rank() over(partition by maker order by [type]) rc
from dbo.Product) tr
pivot (max([type]) for [rc] in ([1], [2], [3])) pvt

