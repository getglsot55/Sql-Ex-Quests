use [sql-ex];

---
with symsa as (
select town_to as town, s, c as c_count
from
(
select town_to, s, LEN(town_to) - LEN(REPLACE(town_to, s, '')) as c
from trip, (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u') as sym
) as t1
where c>0
group by town_to, s, c
having count(*) > 0
union
select town_from as town, s, c as c_count
from
(
select town_from, s, LEN(town_from) - LEN(REPLACE(town_from, s, '')) as c
from trip, (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u') as sym
) as t1
where c>0
group by town_from, s, c
having count(*) > 0
)
select town
from symsa
where c_count = all (select c_count from symsa t2 where t2.town = symsa.town)
group by town
having count(*)>1

---
select town_to
from
(
	select town_to, s, c as c_count
	from
	(
		select distinct town_to, s, len(town_to) - len(replace(town_to, s, '')) as c
		from trip, (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u') as sym
	) as t1
	where c>0
	group by town_to, s, c
	having count(*) > 0
) as t3
where c_count = all (select c_count from (
		select distinct town_to, s, len(town_to) - len(replace(town_to, s, '')) as c
		from trip, (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u') as sym
	) as t2 where t2.town_to = t3.town_to)
group by town_to
having count(*) > 1

select town_from, s, c as c_count
from
(
select distinct town_from, s, LEN(town_from) - LEN(REPLACE(town_from, s, '')) as c
from trip, (select 'a' s union all select 'e' union all select 'i' union all select 'o' union all select 'u') as sym
) as t1
where c>0
group by town_from, s, c
having count(*) > 0