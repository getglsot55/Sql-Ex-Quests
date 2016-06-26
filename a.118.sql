
-- Выборы Директора музея ПФАН проводятся только в високосный год, в первый вторник апреля после первого понедельника апреля.
-- Для каждой даты из таблицы Battles определить дату ближайших (после этой даты) выборов Директора музея ПФАН.
-- Вывод: сражение, дата сражения, дата выборов. Даты выводить в формате "yyyy-mm-dd".

-- cost 0.059129204601049 operations 15 

with Pos(P) as(
 select P FROM
 (
 SELECT 1 P UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
 UNION ALL SELECT 8 UNION ALL SELECT 9
 ) Pos
 )
 select name,
 datename(year,battle_dt)+'-'+
 case
 when Month(battle_dt)>=10
 then cast(Month(battle_dt) as char(2))
 else '0'+cast(Month(battle_dt) as char(1))
 end+
 case
 when day(battle_dt)>=10
 then '-'+cast(day(battle_dt) as char(2))
 else '-0'+cast(day(battle_dt) as char(1))
 end
 as battle_dt,

datename(year,election_date)+'-'+
 case
 when Month(election_date)>=10
 then cast(Month(election_date) as char(2))
 else '0'+cast(Month(election_date) as char(1))
 end+
 case
 when day(election_date)>=10
 then '-'+cast(day(election_date) as char(2))
 else '-0'+cast(day(election_date) as char(1))
 end
 as election_date

from
(select name,date as battle_dt,
	(
	select MIN(DATEADD(dd,P,nY_date)) as min_P_date
	from(
		select distinct
		case
		when P-1=0 and Month(date)>4
		then DATEADD(year,1,(cast((datename(year,date)+'-04-01') as datetime)))
		when P-1=0 and Month(date)<4
		then (cast((datename(year,date)+'-04-01') as datetime))
		when P-1=0 and Month(date)=4
		then date
		else DATEADD(year,P-1,(cast((datename(year,date)+'-04-01') as datetime)))
		end as nY_date
	from
	(select distinct date from Battles where date=B.date)z, Pos
	)z2, Pos
	where
	((DATEPART(year,DATEADD(dd,P,nY_date))%4=0 and DATEPART(year,DATEADD(dd,P,nY_date))%100>0 ) OR
	(DATEPART(year,DATEADD(dd,P,nY_date))%100=0 and DATEPART(year,DATEADD(dd,P,nY_date))%400=0 ))
	and MONTH (DATEADD(dd,P,nY_date))=4 and DATEPART(dw,DATEADD(dd,P,nY_date)) =2+(8-@@DATEFIRST) % 7
	and MONTH (DATEADD(dd,P-1,nY_date))=4 and DAY(DATEADD(dd,P-1,nY_date))<=8
	) election_date
	from Battles B
	)z

