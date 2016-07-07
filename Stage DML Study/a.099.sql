


-- Рассматриваются только таблицы Income_o и Outcome_o. Известно, что прихода/расхода денег в воскресенье не бывает.
-- Для каждой даты прихода денег на каждом из пунктов определить дату инкассации по следующим правилам:
-- 1. Дата инкассации совпадает с датой прихода, если в таблице Outcome_o нет записи о выдаче денег в эту дату на этом пункте.
-- 2. В противном случае - первая возможная дата после даты прихода денег, которая не является воскресеньем 
--    и в Outcome_o не отмечена выдача денег сдатчикам вторсырья в эту дату на этом пункте.
-- Вывод: пункт, дата прихода денег, дата инкассации.

-- cost 0.01641283556819 operations 17 
with d1 as (
select inco.point, inco.[date], inco.[date] dw
from dbo.Income_o inco
union all
select d2.point, d2.[date], dateadd(day, 1, d2.[dw])
from d1 d2
where d2.[dw] in (select ou.[date] from dbo.Outcome_o ou where ou.[point] = d2.[point]) or 
		(1 + (datepart(dw, d2.[dw])+@@datefirst + 5) % 7) = 7)
select [point], [date] as [DP], max([dw]) as [DI]
from d1
group by d1.point, d1.[date]
order by d1.point, DP;

-- cost 0.02682138979435 operations 19 
with d1 as (
select inco.point, inco.[date], 
				dateadd(day, 1, inco.[date]) dw,
				case when inco.[date] not in (select ou.[date] from dbo.Outcome_o ou where ou.[point] = inco.[point]) and 
							(1 + (datepart(dw, inco.[date])+@@datefirst + 5) % 7) <> 7 then inco.[date]
				else null end as di
from dbo.Income_o inco
union all
select d2.point, d2.[date], dateadd(day, 1, d2.[dw]),
				case when d2.[dw] not in (select ou1.[date] from dbo.Outcome_o ou1 where ou1.[point] = d2.[point]) and 
						(1 + (datepart(dw, d2.[dw])+@@datefirst + 5) % 7) <> 7 then d2.[dw]
				else null end as di
from d1 d2
where d2.di is null
)
select [point], [date] as [DP], [di] as [DI]
from d1
where d1.di is not null
order by point, [date];







declare @dtf int = 1;
while (@dtf <= 7)
begin
set datefirst @dtf;
declare @testDate datetime;

set @testDate = getdate(); -- cast('2001-03-27 00:00:00.000' as datetime);

select  getdate() [getdate],
				@@DATEFIRST [datefirst],
				datepart(dw, @testDate) [datepart clean],
        1 + (8 - @@DATEFIRST) % 7 [dw 1],
        datepart(dw, @testDate) + (8 - @@DATEFIRST) % 7 [dw 2],
        1 + (((datepart(dw, @testDate) + @@DATEFIRST) % 7) + 5) % 7 [dw 3],
        1 + (datepart(dw, @testDate) + @@datefirst + 5) % 7 [dw 4];
set @dtf = @dtf + 1;
end



------- Oracle -------

select point, 
        [date] income_date, 
        [date] + nvl( 
                   min(case when diff > cnt then cnt else null end), 
                   max(cnt)+1 
                 ) incass_date 
 from (select i.point, 
              i.[date], 
              (trunc(o.[date]) - trunc(i.[date])) diff, -- разница дней 
             -- количество запрещенных для инкассации дней после прихода и до текущего запрещенного дня 
             count(1) over (partition by i.point, i.[date] order by o.[date] rows between unbounded preceding and current row)-1 cnt 
       from income_o i 
                join (select point, [date], 1 disabled from outcome_o 
                      union 
                      select point, trunc([date]+7,'DAY'), 1 disabled from income_o) o 
                  on i.point = o.point 
       where o.[date] > = i.[date]) t1
 group by point, [date]


