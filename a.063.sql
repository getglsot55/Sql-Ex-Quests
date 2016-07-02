

-- Определить имена разных пассажиров, когда-либо летевших на одном и том же месте более одного раза.

--cost 0.020073795691133 operations 8 
with pp as (
select distinct dbo.Pass_in_trip.ID_psg
from pass_in_trip
group by dbo.Pass_in_trip.ID_psg, dbo.Pass_in_trip.place
having count(*) > 1)
select name
from Passenger join pp on dbo.Passenger.ID_psg = pp.ID_psg

-- cost 0.020073795691133 operations 8 
select  name
from    Passenger
where   ID_psg in (select ID_psg
                   from   Pass_in_trip
                   group by place, ID_psg
                   having count(*) > 1);