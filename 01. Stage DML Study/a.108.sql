

-- Реставрация экспонатов секции "Треугольники" музея ПФАН проводилась согласно техническому заданию. 
-- Для каждой записи таблицы utb малярами подкрашивалась сторона любой фигуры, если длина этой стороны равнялась b_vol.
-- Найти окрашенные со всех сторон треугольники, кроме равносторонних, равнобедренных и тупоугольных. 
-- Для каждого треугольника (но без повторений) вывести три значения X, Y, Z, где X - меньшая, Y - средняя, а Z - большая сторона. 

-- a = b = c   a = b 
-- с2 > a2 + b2 

with cta as (select distinct b_vol from utb),
 cte as (
select distinct cast(a.[B_VOL] as  int) [a], cast(b.[B_VOL] as int) [b], cast(c.[B_VOL] as int) [c]
from cta a, cta b, cta c
where a.[B_VOL] < b.[B_VOL] and b.[B_VOL] < c.[B_VOL] )
select * from cte
where a < (b + c) and b < (a + c) and c < (a +  b)
and sqrt(c) < (sqrt(a) + sqrt(b))
order by a

select * from utb

---
При всем уважении, немного не дотянул. Вот верный вариант:

with cta as (select distinct b_vol from utb),
 
cte as (
 select distinct cast(a.[B_VOL] as  int) [a]
 , cast(b.[B_VOL] as int) [b]
 , cast(c.[B_VOL] as int) [c]
 from cta a, cta b, cta c
 where a.[B_VOL] < b.[B_VOL] and b.[B_VOL] < c.[B_VOL] 
)

select * from cte
where a < (b + c) and b < (a + c) and c < (a +  b)
and power(c,2) <= (power(a,2) + power(b,2))
