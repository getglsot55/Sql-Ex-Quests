


-- По таблицам Income и Outcome для каждого пункта приема найти остатки денежных средств на конец каждого дня, 
-- в который выполнялись операции по приходу и/или расходу на данном пункте.
-- Учесть при этом, что деньги не изымаются, а остатки/задолженность переходят на следующий день.
-- Вывод: пункт приема, день в формате "dd/mm/yyyy", остатки/задолженность на конец этого дня.


-- cost 0.018504971638322 operations 14 
select point, convert(varchar, [date], 103) as [date],
	sum([inc]) over(partition by [point] order by [date] range unbounded preceding) +
	sum([out]) over(partition by [point] order by [date] range unbounded preceding) as [rem]
from (
	select [point], [date], sum([inc]) as [inc], sum([out]) as [out]
	from (
		select point, [date], [inc] as [inc], 0 as [out]
		from dbo.Income
		union all
		select point, [date], 0 as [inc], -[out]
		from [dbo].[Outcome] ) as t1
		group by [point], [date] ) as t2;



-- drafts
select [point], [date], [inc],
sum([inc]) over (partition by point order by date range unbounded preceding) 
from income
order by [point], [date];
