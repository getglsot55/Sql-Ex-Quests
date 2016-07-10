


-- Определить имена разных пассажиров, когда-либо летевших рейсом, который вылетел в субботу, а приземлился в воскресенье. 


select [dbo].[Passenger].[name]	
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no join [dbo].[Passenger] on [Passenger].[ID_psg] = [Pass_in_trip].[ID_psg]
where datename(dw, [date]) = 'Saturday'	and [time_in] < [time_out]




select *
from dbo.Pass_in_trip join dbo.Trip on Trip.trip_no = Pass_in_trip.trip_no
			join [dbo].[Passenger] on [Passenger].[ID_psg] = [Pass_in_trip].[ID_psg]
where  datename(dw, [date]) = 'Saturday' and [time_in] < [time_out]