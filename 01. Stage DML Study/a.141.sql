Задание: 141 (Serge I: 2017-11-03)
Для каждого из летавших пассажиров определить количество дней в апреле 2003 года, попавших в интервал между датами первого и последнего вылета пассажира включительно.
Вывести имя пассажира и количество дней.

--

with A as ( 
select ID_psg, min(date) mi , max(date) ma,
datediff(dd, min(date), '2003-04-01') min1,
datediff(dd, min(date), '2003-04-30') min30,
datediff(dd, max(date), '2003-04-01') max1,
datediff(dd, max(date), '2003-04-30') max30
from Pass_in_trip
group by ID_psg
),

B as (
select *, 
IIF(
   min30 < 0 or max1 > 0, 0, 
      (
         IIF(min1 <= 0 and max30 >= 0, min30-max30+1, 
            IIF(min1 > 0, min30-min1-IIF(max30>=0, max30, 0), min30
            )+1
       ))
    ) as gg1 from A
)

select Passenger.name, gg1 from B join Passenger
on Passenger.ID_psg = B.ID_psg
