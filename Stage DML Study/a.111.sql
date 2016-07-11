


-- Найти НЕ белые и НЕ черные квадраты, которые окрашены разными цветами в пропорции 1:1:1. Вывод: имя квадрата, количество краски одного цвета 

--cost 0.064796164631844 operations 9 
select pvt.Q_NAME, [R] as qty
from (
select Q_ID, Q_NAME, B_VOL, V_COLOR
from dbo.utQ  join dbo.utB on utB.B_Q_ID = utQ.Q_ID join dbo.utV on utV.V_ID = utB.B_V_ID) t1
pivot(sum(B_VOL) for V_COLOR in ([R], [G], [B])) pvt 
where [R] = [G] and [R] = [B] and [R] > 0 and [R] < 255