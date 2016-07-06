

-- ѕри условии, что баллончики с красной краской использовались более одного раза,
-- выбрать из них такие, которыми окрашены квадраты, имеющие голубую компоненту. 
-- ¬ывести название баллончика 


-- cost 0.07632627338171 operations 23 
select distinct t1.V_NAME from (
select *, min(v_color) over(partition by b_q_id) as mc, count(*) over(partition by b_v_id) as uc
from utb join utv on utV.V_ID = utB.B_V_ID ) t1
where mc = 'B' and uc > 1 and t1.V_COLOR = 'R'


-- cost 0.050295118242502 operations 14 
select distinct t1.V_NAME
from (
	select utv.V_ID, utv.V_NAME
	from utb join dbo.utV on utV.V_ID = utB.B_V_ID
	where V_COLOR = 'R'
	group by dbo.utV.V_ID, dbo.utV.V_NAME having count(*) > 1
	) as t1
	where t1.V_ID in (
		select B_V_ID
		from utb
		where dbo.utB.B_Q_ID in (
			select B_Q_ID
			from dbo.utB join dbo.utV on utV.V_ID = utB.B_V_ID
			where dbo.utV.V_COLOR = 'B')
		)

