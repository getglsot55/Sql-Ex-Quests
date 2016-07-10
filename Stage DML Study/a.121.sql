


-- Найдите названия всех тех кораблей из базы данных, о которых можно определенно сказать, что они были спущены на воду до 1941 г. 


-- Корабли, спущенные на воду до 1941 года
select  [name]
from    [dbo].[Ships]
where   [launched] < 1941
union 
-- Корабли, принимавшие участие в сражениях до 1941 года
select  [ship]
from    [dbo].[Outcomes]
        join [dbo].[Battles] on [name] = [battle]
where   [date] < '19410101'
union 
-- Головные корабли из Outcomes, в классе которых есть другие корабли, спущенные на воду до 1941 года
select  [ship]
from    [dbo].[Outcomes]
where   [ship] in (select [class]
                 from   [dbo].[Ships]
                 where  [launched] < 1941)
union 
-- Головные корабли из Outcomes при условии, что хотя бы один из кораблей того же класса, участвовал в сражении до 1941 года
select  [ship]
from    [dbo].[Outcomes]
where   [ship] in (select [class]
                 from   [dbo].[Ships]
                        join [dbo].[Outcomes] on [Ships].[name] = [Outcomes].[ship]
                        join [dbo].[Battles] on [Battles].[name] = [Outcomes].[battle]
                 where  [date] < '19410101')
union
select  [name]
from    [dbo].[Ships]
where   [name] in (select [class]
                   from   [dbo].[Ships]
                   where  [launched] < 1941)
union
select  [name]
from    [dbo].[Ships]
where   [name] in (select [class]
                 from   [dbo].[Ships]
                        join [dbo].[Outcomes] on [Ships].[name] = [ship]
                        join [dbo].[Battles] on [Battles].[name] = [battle]
                 where  [date] < '19410101');


--with cte fs as (

--select cast('1941-01-01 00:00:00.000' as datetime)