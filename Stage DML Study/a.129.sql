


-- Предполагая, что среди идентификаторов квадратов имеются пропуски, найти минимальный и максимальный "свободный" идентификатор 
-- в диапазоне между имеющимися максимальным и минимальным идентификаторами. 
-- Например, для последовательности идентификаторов квадратов 1,2,5,7 результат должен быть 3 и 6.
-- Если пропусков нет, вместо каждого искомого значения выводить NULL.


--select *
--from [dbo].[utQ]



with ctss as (select 1 n union all select 3  union all select 4  union all select 7  union all 
select 8  union all select 9  union all select 10  union all select 11  union all select 12)
select * from ctss;