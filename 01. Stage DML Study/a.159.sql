Задание: 159 (Baser: 2021-02-26)
Для каждой окраски (t,q,v,vol) = (B_DATETIME,B_Q_ID,B_V_ID,B_VOL) определить предшествующую по времени окраску того же квадрата тем же баллончиком и вывести в таблицу (t,q,v,vol,tp,volp).
Если такой окраски не было, то установить для предыдущей tp = volp = NULL.

---

select *
, lag(B_DATETIME) over(partition by B_Q_ID, B_V_ID order by B_DATETIME) 
, lag(B_VOL) over(partition by B_Q_ID, B_V_ID order by B_DATETIME) 
from utB
