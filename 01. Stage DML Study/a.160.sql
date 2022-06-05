Задание: 160 (Kursist: 2021-10-15)
Выведите имена пассажиров, которые побывали в наибольшем количестве разных городов, включая города отправления.

---

with A as (
select Passenger.name, Passenger.ID_psg, Trip.town_from as town
from Passenger join Pass_in_trip
on Passenger.ID_psg = Pass_in_trip.ID_psg
join Trip
on Pass_in_trip.trip_no = Trip.trip_no
   union  
select Passenger.name, Passenger.ID_psg, Trip.town_to as town
from Passenger join Pass_in_trip
on Passenger.ID_psg = Pass_in_trip.ID_psg
join Trip
on Pass_in_trip.trip_no = Trip.trip_no
),

B as (
select name, ID_psg, count(*) as cnt from A group by name, ID_psg
)

select Passenger.name from Passenger join B
on Passenger.ID_psg = B.ID_psg
where cnt = (select max(cnt) from B)
