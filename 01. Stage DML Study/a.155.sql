Задание: 155 (pаparome: 2005-12-02)
Предполагая, что не существует номера рейса большего 65535,
вывести номер рейса и его представление в двоичной системе счисления (без ведущих нулей)

---

select distinct trip_no
, cast(
trim(cast(cast(trip_no & 16384 as bit) as char)) +
trim(cast(cast(trip_no & 8192 as bit) as char)) +
trim(cast(cast(trip_no & 4096 as bit) as char)) +
trim(cast(cast(trip_no & 2048 as bit) as char)) +
trim(cast(cast(trip_no & 1024 as bit) as char)) +
trim(cast(cast(trip_no & 512 as bit) as char)) +
trim(cast(cast(trip_no & 256 as bit) as char)) +
trim(cast(cast(trip_no & 128 as bit) as char)) +
trim(cast(cast(trip_no & 64 as bit) as char)) +
trim(cast(cast(trip_no & 32 as bit) as char)) +
trim(cast(cast(trip_no & 16 as bit) as char)) +
trim(cast(cast(trip_no & 8 as bit) as char)) +
trim(cast(cast(trip_no & 4 as bit) as char)) +
trim(cast(cast(trip_no & 2 as bit) as char)) +
trim(cast(cast(trip_no & 1 as bit) as char)) as bigint)
from Trip
