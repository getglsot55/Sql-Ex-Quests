


-- Для каждого класса крейсеров, число орудий которого известно, пронумеровать (последовательно от единицы) все орудия.
-- Вывод: имя класса, номер орудия в формате 'bc-N'. 

-- cost 0.014841427095234 operations 13   SQS - 15 ms (10 ms without order)
with cte as (
select class, cast(numGuns as int) ng, 'bc-' + cast(numGuns as  varchar(4)) num
from dbo.Classes where type = 'bc' and numGuns > 0
union all
select class, ng - 1, 'bc-' + cast(ng - 1 as  varchar(4))
from cte where ng > 1)
select class, num from cte order by class, num