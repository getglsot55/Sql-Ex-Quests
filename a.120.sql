
-- ƒл€ авиакомпаний, самолеты которой выполнили хот€ бы один рейс, вычислить с точностью до двух дес€тичных знаков 
-- средние величины времени нахождени€ самолетов в воздухе (в минутах). “акже рассчитать указанные характеристики 
-- по всем летавшим самолетам (использовать слово 'TOTAL').
-- ¬ывод: компани€, среднее арифметическое, среднее геометрическое, среднее квадратичное, среднее гармоническое.
-- ƒл€ справки:
-- среднее арифметическое = (x1 + x2 + ... + xN)/N 
-- среднее геометрическое = (x1 * x2 * ... * xN)^(1/N) 
-- среднее квадратичное = sqrt((x1^2 + x2^2 + ... + xN^2)/N) 
-- среднее гармоническое = N/(1/x1 + 1/x2 + ... + 1/xN)


--cost 0.061612639576197 operations 14 
select coalesce(c.name, 'TOTAL'), A_mean, G_mean, Q_mean, H_mean 
from (
	select  ID_Comp,
		convert(numeric(18,2), avg(atime)) A_mean,
		convert(numeric(18,2), Exp(avg(Log(atime)))) G_mean, 
		convert(numeric(18,2), sqrt(avg(atime*atime))) Q_mean,
		convert(numeric(18,2), count(*)/sum(1/atime)) H_mean
	from (
		select ID_Comp,  trip_no, iif(atime < 0 , 1440 + atime, atime) as atime
		from (
			select company.ID_Comp, trip_no, DATEDIFF(minute, time_out, time_in) * 1.00 as atime
			from company inner join trip on company.ID_comp = trip.ID_comp) as t1
		) as t2
	inner join (
		select trip_no 
			from Pass_in_trip 
			group by trip_no, [date]) pt on t2.trip_no = pt.trip_no
			group by ID_Comp with cube
		) as a
	left join Company c on a.ID_comp = c.ID_comp

-- cost 0.041791219264269 operations 12 
with t as (
	select ID_comp,
		convert(numeric(18,2), 
		case
			when time_in > = time_out 
			then datediff(minute, time_out, time_in) 
			else datediff(minute, time_out, dateadd(day, 1, time_in)) 
		end) as trmin
	from (
		select trip_no
		from Pass_in_trip 
		group by trip_no, [date]
	) pt
	join Trip t on pt.trip_no = t.trip_no
) 
select coalesce(c.name, 'TOTAL'), A_mean, G_mean, Q_mean, H_mean
from (
	select Id_comp,
		convert(numeric(18,2), avg(trmin)) A_mean,
		convert(numeric(18,2), Exp(avg(Log(trmin)))) G_mean,
		convert(numeric(18,2), sqrt(avg(trmin*trmin))) Q_mean,
		convert(numeric(18,2), count(*)/sum(1/trmin)) H_mean
	from t
	group by ID_comp with cube
) as a
left join Company c on a.ID_comp = c.ID_comp