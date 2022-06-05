Задание: 140 (no_more: 2017-07-07)
Определить, сколько битв произошло в течение каждого десятилетия, начиная с даты первого сражения в базе данных и до даты последнего.
Вывод: десятилетие в формате "1940s", количество битв

---

with A as (
   select max(cast(SUBSTRING(ltrim(str(year(date))), 1, 3)+'0' as float)) as max from Battles),

B as (
   select (
      select 
      min(cast(SUBSTRING(ltrim(str(year(date))), 1, 3)+'0' as float)) as min
      from Battles) as num
         union all
      select num + 10 from B
      where num < (select max from A)
)

select  SUBSTRING(ltrim(str(B.num)), 1, 4)+'s',
count(cast(SUBSTRING(ltrim(str(year(Battles.date))), 1, 3)+'0' as float)) 
from B left join Battles 
on B.num = cast(SUBSTRING(ltrim(str(year(Battles.date))), 1, 3)+'0' as float)
group by num
