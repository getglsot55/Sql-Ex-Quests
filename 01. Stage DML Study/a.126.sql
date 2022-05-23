


-- Для последовательности пассажиров, упорядоченных по id_psg, определить того, 
-- кто совершил наибольшее число полетов, а также тех, кто находится в последовательности непосредственно перед и после него.
-- Для первого пассажира в последовательности предыдущим будет последний, а для последнего пассажира последующим будет первый.
-- Для каждого пассажира, отвечающего условию, вывести: имя, имя предыдущего пассажира, имя следующего пассажира. 

-- cost 0.048182006925344 operations 59 
with cte as (select [ID_psg], count(*) as ct, max(count(*)) over() as mct
from [dbo].[Pass_in_trip]
group by [ID_psg]),
ctf as (select cte.*, [dbo].[Passenger].[name] from cte join [dbo].[Passenger] on [Passenger].[ID_psg] = [cte].[ID_psg] where ct = mct),
ctg as (select row_number() over(order by [ID_psg]) as rn, count(*) over() as cr,  [ID_psg], [name] from [dbo].[Passenger])
select ctf.[name] as [psg],
	case when ctg.[rn] = 1 
		then (select name from ctg ga where ga.[rn] = ctg.[cr]) 
		else (select name from ctg ga where ga.[rn] = ctg.[rn] - 1)
	end as [prev],
	case when ctg.[rn] = ctg.[cr]
		then (select name from ctg ga where ga.[rn] = 1)
		else (select name from ctg ga where ga.[rn] = ctg.[rn] + 1)
	end as [next]
from ctf join ctg on [ctg].[ID_psg] = [ctf].[ID_psg];


Вот более интуитивно понятное:

with A as (
select ID_psg
,case when lag(ID_psg) over(order by ID_psg) is null then max(ID_psg) over()
else lag(ID_psg) over(order by ID_psg) end AS lag
,case when lead(ID_psg) over(order by ID_psg) is null then min(ID_psg) over()
else lead(ID_psg) over(order by ID_psg) end AS lead
,sum(cnt) as f1
,max(sum(cnt)) over() as f2 
	from 
 	(
select ID_psg, count(trip_no) as cnt from Pass_in_trip
group by ID_psg
union all
select ID_psg, 0 from Passenger
 	) as A
	group by ID_psg
)

select Passenger.name, P1.name, P2.name from A 
join Passenger
on A.ID_psg = Passenger.ID_psg
join Passenger as P1
on A.lag = P1.ID_psg
join Passenger as P2
on A.lead = P2.ID_psg
where A.f1 = A.f2
