Задание: 153 (Serge I: 2003-04-08)
Определить имена разных пассажиров, летевших хотя бы два раза подряд на месте с одним и тем же номером.

---

with A as (
select ID_psg, place,
lead(place) over(partition by ID_psg order by ID_psg, date+time_out) as p2
from Pass_in_trip left join Trip
on Pass_in_trip.trip_no = Trip.trip_no
),

B as (
select distinct ID_psg from A where place = p2
)

select name from Passenger join B on B.ID_psg = Passenger.ID_psg
