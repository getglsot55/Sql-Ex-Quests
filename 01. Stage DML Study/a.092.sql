

-- Выбрать все белые квадраты, которые окрашивались только из баллончиков, 
-- пустых к настоящему времени. Вывести имя квадрата 

--
select Q_NAME
from utQ
where Q_ID in (
	select B_Q_ID
	from utB inner join utV on utB.B_V_ID = utV.V_ID
	where B_V_ID in (select B_V_ID from utB group by B_V_ID having sum(B_VOL) = 255)
	group by B_Q_ID
	having sum(B_VOL) = 765)

-- cost 0.13028737902641 operations 24 
;with wst as (
select q_id
from ( select q_id, v_color, b_vol from utQ join utB on utQ.Q_ID = utB.B_Q_ID join utV on utb.B_V_ID = utv.V_ID) as t1
pivot (sum(t1.B_VOL) for V_COLOR in ([R], [G], [B])) as t2
where R=255 and G=255 and B=255
)
select utq.Q_NAME
from utB left join (select utb.B_V_ID from utB group by utB.B_V_ID having sum(utb.B_VOL) >= 255) as t1 on utb.B_V_ID = t1.B_V_ID
	join utq on utb.B_Q_ID = utq.Q_ID
where B_Q_ID in (select q_id from wst)
group by utq.Q_NAME
having sum(iif(t1.B_V_ID is null,1,0)) = 0

