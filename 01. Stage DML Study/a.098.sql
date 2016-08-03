

-- Вывести список ПК, для каждого из которых результат побитовой операции ИЛИ,
-- примененной к двоичным представлениям скорости процессора и объема памяти,
-- содержит последовательность из не менее четырех идущих подряд единичных битов.
-- Вывод: код модели, скорость процессора, объем памяти.


-- cost 0.014872514642775 operations 14   SQS - 0,0010
with ctebins as
 (select code, model, speed, ram, num as num_orig, num as working_level, cast('' as varchar(max)) as binval
 from (	select code, model, speed, ram, cast((speed | ram) as int) as num from PC) tr
 union all 
 select c.code, c.model, speed, ram, c.num_orig, c.working_level / 2, cast(c.working_level % 2 as varchar(max)) + c.binval
 from ctebins c
 where c.working_level > 0
 ) 
 select distinct code, speed, ram
 from ctebins 
 where working_level = 0 and charindex('1111', ctebins.binval, 0) <> 0 ; 
