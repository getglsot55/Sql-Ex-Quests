


-- Выбрать три наименьших и три наибольших номера рейса.
-- Вывести их в шести столбцах одной строки, расположив в порядке от наименьшего к наибольшему. 
-- Замечание: считать, что таблица Trip содержит не менее шести строк. 


-- cost 0.031961712986231 operations 65  sqs - 50 ms
with cte as (
select rank() over(order by trip_no) rn, trip_no
from trip)
select
(select trip_no from cte where rn = 1) [1],
(select trip_no from cte where rn = 2) [2],
(select trip_no from cte where rn = 3) [3],
(select trip_no from cte where rn = (select max(rn) from cte) - 2) [4],
(select trip_no from cte where rn = (select max(rn) from cte) - 1) [5],
(select trip_no from cte where rn = (select max(rn) from cte)) [6]


--
select * from
(select row_number() over(order by trip_no) rn, trip_no
from (
select trip_no, row_number() over(order by trip_no) rn
from trip) ps
where rn <= 3 or rn > (select count(*) from trip) - 3) ts
pivot(max(trip_no) for rn in([1], [2], [3], [4], [5], [6])) pvt