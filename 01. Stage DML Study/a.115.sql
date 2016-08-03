


-- Рассмотрим равнобочные трапеции, в каждую из которых можно вписать касающуюся всех сторон окружность.
-- Кроме того, каждая сторона имеет целочисленную длину из множества значений b_vol. 
-- Вывести результат в 4 колонки: Up, Down, Side, Rad. Здесь Up - меньшее основание, Down - большее основание, 
-- Side - длины боковых сторон, Rad – радиус вписанной окружности (с 2-мя знаками после запятой). 

-- 2a = b + c
-- cost 0.077202133834362 operations 13 
with cte as (select distinct cast(b_vol as int) bvol from [dbo].[utB])
select b1.bvol [b], b2.[BVOL] [c], 
			(b1.bvol + b2.[BVOL]) / 2 [a],
			cast(sqrt( b1.[BVOL] * b2.[BvOL])/ 2 as decimal(14, 2)) r
from cte b1 join cte b2 on b1.[BVOL] < b2.[BVOL]
where ([b1].[bvol] + [b2].[bvol]) % 2 = 0 and ((b1.[BVOL] + b2.[BVOL]) / 2) in (select [bvol] from cte);
