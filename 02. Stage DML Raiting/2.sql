


-- Для таблицы Outcomes преобразовать названия кораблей, содержащих более одного пробела, следующим образом.
-- Заменить все символы между первым и последним пробелами (исключая сами эти пробелы) на символы звездочки (*)
-- в количестве, равном числу замененных символов.
-- Вывод: название корабля, преобразованное название корабля
-- Для этой задачи запрещено использовать: CTE


-- cost 0.0033684601075947 operations 3 
select [ship],
stuff(
	[ship],
	charindex(' ', [ship]) + 1,
	datalength([ship]) - charindex(' ',reverse([ship])) - charindex(' ', [ship]),
	replicate('*', datalength([ship]) - charindex(' ',reverse([ship])) - charindex(' ', [ship]))) as [rt]
from [dbo].[Outcomes] [o]
where (datalength(ship) - datalength(replace(ship, ' ', '')) ) > 1;



select *,
datalength(ship) - datalength(replace(ship, ' ', '')) as sc,
reverse(substring(reverse([ship]), 0, charindex(' ',reverse([ship])))),
datalength([ship]) - charindex(' ',reverse([ship])),
charindex(' ', [ship]) as [start],
datalength([ship]) - charindex(' ',reverse([ship])) - charindex(' ', [ship]) as [lenght],
stuff(
	[ship],
	charindex(' ', [ship]) + 1,
	datalength([ship]) - charindex(' ',reverse([ship])) - charindex(' ', [ship]),
	replicate('*', datalength([ship]) - charindex(' ',reverse([ship])) - charindex(' ', [ship]))) as [rt]
from [dbo].[Outcomes] [o]
where (datalength(ship) - datalength(replace(ship, ' ', '')) ) > 1;
