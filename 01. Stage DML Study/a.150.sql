Задание: 150 (Serge I: 2019-07-05)
Для каждого пункта в таблице income определить минимальную (min_date) и максимальную (max_date) даты поступления средств.
В упорядоченной по времени последовательности всех записей в таблице income для каждого интервала [min_date, max_date]
определить по одной строке непосредственно выше (date1 < min_date) и непосредственно ниже (date2 > max_date).
Другими словами, требуется расширить каждый интервал на одну строку сверху и снизу. Если искомой строки/строк нет, считать значение date1/date2 неопределенным (NULL).
Вывод: point, date1, min_date, max_date, date2.

---

with A as (
select distinct point
,min(date) over(partition by point) as mi
,max(date) over(partition by point) as ma
 from income 
)

select 
point
, (select top(1) date from income where date < A.mi order by date desc) 
, mi
, ma
, (select top(1) date from income where date > A.ma order by date asc)
 from A 
