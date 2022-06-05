Задание: 142 (Serge I: 2003-08-28)
Среди пассажиров, летавших на самолетах только одного типа, определить тех, кто прилетал в один и тот же город не менее 2-х раз.
Вывести имена пассажиров.

---

with A as (
select ID_psg from Pass_in_trip join Trip
on Pass_in_trip.trip_no = Trip.trip_no
group by ID_psg
having count(distinct plane) = 1
),

B as (
select distinct ID_psg from Pass_in_trip join Trip
on Pass_in_trip.trip_no = Trip.trip_no
where ID_psg in (select * from A)
group by ID_psg, town_to
having count(*) > 1
)

select Passenger.name from Passenger join B
on Passenger.ID_psg = B.ID_psg
