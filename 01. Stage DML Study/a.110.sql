


-- Определить имена разных пассажиров, когда-либо летевших рейсом, который вылетел в субботу, а приземлился в воскресенье. 

-- cost 0.030859097838402 operations 7 
with cte as (select distinct [Pass_in_trip].[ID_psg]
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no 
where datename(dw, [date]) = 'Saturday'	and [time_in] < [time_out])
select [name]
from [cte] join [dbo].[Passenger] on [Passenger].[ID_psg] = [cte].[ID_psg]



--with cte as (select distinct [Pass_in_trip].[ID_psg]
--from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no 
-- where (1+ (datepart(dw, [date] )+@@datefirst + 5) % 7) = 6 AND time_in < time_out)
--select [name]
--from [cte] join [dbo].[Passenger] on [Passenger].[ID_psg] = [cte].[ID_psg]