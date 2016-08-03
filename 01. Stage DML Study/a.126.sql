


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
