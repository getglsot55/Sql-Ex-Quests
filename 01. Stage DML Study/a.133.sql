

-- Пусть имеется некоторое подмножество S множества целых чисел. Назовем "горкой с вершиной N" последовательность чисел из S,
-- в которой числа, меньшие N, выстроены (слева направо без разделителей) сначала возрастающей цепочкой,
-- а потом – убывающей цепочкой, и значением N между ними.
-- Например , для S = {1, 2, …, 10} горка с вершиной 5 представляется такой последовательностью: 123454321.
-- При S, состоящем из идентификаторов всех компаний, для каждой компании построить "горку", рассматривая ее идентификатор в качестве вершины.
-- Считать идентификаторы положительными числами и учесть, что в базе нет данных, при которых количество цифр в "горке" может превысить 70.
-- Вывод: id_comp, "горка"

-- cost 0.024486020207405 operations 19 
select [cmp].[ID_comp] [top_id],
coalesce((select '' + cast([ID_comp] as varchar(max)) 
	from [dbo].[Company] a where a.[ID_comp] < [cmp].[ID_comp]
	order by [a].[ID_comp] for xml path('')), '') + 
	cast([cmp].[ID_comp] as varchar(max)) + 
	coalesce((select '' + cast([ID_comp] as varchar(max)) 
	from [dbo].[Company] a 
	where a.[ID_comp] < [cmp].[ID_comp]
	order by [a].[ID_comp] desc
	for xml path('')), '') [hill]
from [dbo].[Company] cmp



-- all 11 different 5

select 1 [top_id], '1' [hill]
union
select 2, '121'
union
select 3, '12321'
union
select 4, '1234321'
union
select 5, '123454321'
union select [ID_comp], '' from [dbo].[Company] where 1 <> 1