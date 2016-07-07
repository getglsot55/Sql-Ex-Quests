

-- Отобрать из таблицы Laptop те строки, для которых выполняется следующее условие:
-- значения из столбцов speed, ram, price, screen возможно расположить таким образом,
-- что каждое последующее значение будет превосходить предыдущее в 2 раза или более.
-- Замечание: все известные характеристики ноутбуков больше нуля.
-- Вывод: code, speed, ram, price, screen.


-- cost 0.2543218433857 operations 12 
select [code], [speed], [ram], [price], [screen]
from Laptop 
where exists (
	select 1 x 
	from (
		select v, rank() over(order by v) rc
		from (select cast(speed as float) speed, cast(ram as float) [ram],
						cast(price as float) [price], cast(screen as float) [screen]) st
		unpivot (v for c in ([speed], [ram], [price], [screen])) as upvt) t1
		pivot (max(v) for rc in ([1], [2], [3], [4])) as pvt
	where [1] * 2 <= [2] and [2] * 2 <= [3] and [3] * 2 <= [4] )

-- cost 0.03661547973752 operations 25 
with t1 as (
 select [code], [model], [feature], [value]
 from (
		select [code], [model], 
			cast([speed] as float) [speed],
			cast([ram] as  float) [ram], 
			cast([price] as float) as [price] , 
			cast([screen] as float) as [screen] from Laptop
		) as tr
 unpivot ([value] for [feature] in (speed, ram, price, screen)) as unpvt
 ),
 tres as (
  select t2.code
 from t1 as t2, t1 as t3, t1 as t4, t1 as t5
 where t2.code = t3.code and t2.feature <> t3.feature and
			(t4.code = t2.code and t4.feature <> t3.feature and t4.feature <> t2.feature) and
			(t5.code = t2.code and t5.feature <> t4.feature and t5.feature <> t3.feature and t5.feature <> t2.feature)
			and
			( t2.value * 2 <= t3.value and t3.value * 2 <= t4.value and t4.value * 2 <= t5.value)
)
select dbo.Laptop.code,speed,ram,price,screen
from tres join laptop on tres.code = dbo.Laptop.code;