


-- ѕо таблице Classes дл€ каждой страны найти максимальное значение среди трех выражений: 
-- numguns*5000, bore*3000, displacement.
-- ¬ывод в три столбца: 
-- - страна; 
-- - максимальное значение; 
-- - слово `numguns` - если максимум достигаетс€ дл€ numguns*5000, слово `bore` - если максимум достигаетс€ дл€ bore*3000,
-- слово `displacement` - если максимум достигаетс€ дл€ displacement.
-- «амечание. ≈сли максимум достигаетс€ дл€ нескольких выражений, выводить каждое из них отдельной строкой.


-- cost 0.017845541238785 operations 16 
with cta as (
	select [upv].[country], c, v, max(v) over(partition by [country]) m
	from (
		select class, type, country, cast(numGuns * 5000 as int) numguns,
		cast(bore * 3000 as int) bore, displacement from classes) tr
	unpivot(v for c in ([numGuns],[bore],[displacement])) upv)
select distinct [country], cast(v as decimal(18,1)) as [max_val], c as [name]
from cta
where v = m;