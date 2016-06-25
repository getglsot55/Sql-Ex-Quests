

 select coalesce(c.name, 'TOTAL'), A_mean, G_mean, Q_mean, H_mean 
 from (
select  ID_Comp,
	convert(numeric(18,2), avg(atime)) A_mean,
   convert(numeric(18,2), Exp(avg(Log(atime)))) G_mean, 
   convert(numeric(18,2), sqrt(avg(atime*atime))) Q_mean, 
   convert(numeric(18,2), count(*)/sum(1/atime)) H_mean 
from
(	select ID_Comp,  trip_no, iif(atime < 0 , 1440 + atime, atime) as atime
	from(
		select company.ID_Comp, trip_no, DATEDIFF(minute, time_out, time_in) * 1.00 as atime
		from company inner join trip on company.ID_comp = trip.ID_comp) as t1
) as t2
inner join
(	select trip_no 
	from Pass_in_trip 
	group by trip_no, [date]) pt on t2.trip_no = pt.trip_no
group by ID_Comp with cube
) as a left join Company c on a.ID_comp = c.ID_comp

With t as 
 (Select ID_comp, convert(numeric(18,2), 
	Case when time_in > = time_out 
	Then datediff(minute, time_out, time_in) 
    Else datediff(minute, time_out, dateadd(day, 1, time_in)) 
    End) as trmin 
 From (Select trip_no 
  From Pass_in_trip 
  Group by trip_no, [date]) pt join Trip t on pt.trip_no = t.trip_no 
 ) 

 Select Coalesce(c.name, 'TOTAL'), A_mean, G_mean, Q_mean, H_mean 
 From ( 
  Select Id_comp , 
   convert(numeric(18,2), avg(trmin)) A_mean, 
   convert(numeric(18,2), Exp(avg(Log(trmin)))) G_mean, 
   convert(numeric(18,2), sqrt(avg(trmin*trmin))) Q_mean, 
   convert(numeric(18,2), count(*)/sum(1/trmin)) H_mean 
  From t 
  Group by ID_comp 
  with cube) as a left join Company c on a.ID_comp = c.ID_comp