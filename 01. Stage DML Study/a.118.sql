
-- Выборы Директора музея ПФАН проводятся только в високосный год, в первый вторник апреля после первого понедельника апреля.
-- Для каждой даты из таблицы Battles определить дату ближайших (после этой даты) выборов Директора музея ПФАН.
-- Вывод: сражение, дата сражения, дата выборов. Даты выводить в формате "yyyy-mm-dd".

-- cost 0.059129204601049 operations 15 

with  [Pos]([P])
        as (select  [Pos].[P]
            from    (select 1 [P]
                     union all
                     select 2
                     union all
                     select 3
                     union all
                     select 4
                     union all
                     select 5
                     union all
                     select 6
                     union all
                     select 7
                     union all
                     select 8
                     union all
                     select 9) [Pos])
  select  [z].[name],
          datename(year, [z].[battle_dt]) + '-' + case when month([z].[battle_dt]) >= 10
                                                 then cast(month([z].[battle_dt]) as char(2))
                                                 else '0' + cast(month([z].[battle_dt]) as char(1))
                                            end + case when day([z].[battle_dt]) >= 10
                                                       then '-' + cast(day([z].[battle_dt]) as char(2))
                                                       else '-0' + cast(day([z].[battle_dt]) as char(1))
                                                  end as [battle_dt],
          datename(year, [z].[election_date]) + '-' + case when month([z].[election_date]) >= 10
                                                     then cast(month([z].[election_date]) as char(2))
                                                     else '0' + cast(month([z].[election_date]) as char(1))
                                                end + case when day([z].[election_date]) >= 10
                                                           then '-' + cast(day([z].[election_date]) as char(2))
                                                           else '-0' + cast(day([z].[election_date]) as char(1))
                                                      end as [election_date]
  from    (select [B].[name], [B].[date] as [battle_dt],
                  (select min(dateadd(dd, [Pos].[P], [z2].[nY_date])) as [min_P_date]
                   from   (select distinct
                                  case when [Pos].[P] - 1 = 0 and month([z].[date]) > 4
                                       then dateadd(year, 1,
                                                    (cast((datename(year, [z].[date]) + '-04-01') as datetime)))
                                       when [Pos].[P] - 1 = 0 and month([z].[date]) < 4
                                       then (cast((datename(year, [z].[date]) + '-04-01') as datetime))
                                       when [Pos].[P] - 1 = 0 and month([z].[date]) = 4
                                       then [z].[date]
                                       else dateadd(year, [Pos].[P] - 1,
                                                    (cast((datename(year, [z].[date]) + '-04-01') as datetime)))
                                  end as [nY_date]
                           from   (select distinct
                                          [date]
                                   from   [dbo].[Battles]
                                   where  [date] = [B].[date]) [z],
                                  [Pos]) [z2],
                          [Pos]
                   where  ((datepart(year, dateadd(dd, [Pos].[P], [z2].[nY_date])) % 4 = 0 and datepart(year,
                                                              dateadd(dd, [Pos].[P],
                                                              [z2].[nY_date])) % 100 > 0
                           ) or (datepart(year, dateadd(dd, [Pos].[P], [z2].[nY_date])) % 100 = 0 and datepart(year,
                                                              dateadd(dd, [Pos].[P],
                                                              [z2].[nY_date])) % 400 = 0
                                )
                          ) and month(dateadd(dd, [Pos].[P], [z2].[nY_date])) = 4 and datepart(dw,
                                                              dateadd(dd, [Pos].[P],
                                                              [z2].[nY_date])) = 2 + (8 - @@DATEFIRST) % 7 and month(dateadd(dd,
                                                              [Pos].[P] - 1, [z2].[nY_date])) = 4 and day(dateadd(dd,
                                                              [Pos].[P] - 1, [z2].[nY_date])) <= 8) [election_date]
           from   [dbo].[Battles] [B]) [z];

---

Тоже громоздкий, но более понятный способ:

with A as (select min(year(coalesce(date, '2000-01-01'))) as mi from Battles),

B as (select max(year(coalesce(date, '2000-01-01'))) as ma from Battles),

C as (
select (select * from A) as year 
union all
select year+1 from C where year < (select * from B) + 4
),

D as (
select 1 as day
union all
select day+1 from D where day<30
),

F as (
select cast(trim(str(year)) + '-04-' + IIF(len(D.day) = 1, '0' + trim(str(D.day)), trim(str(D.day))) as date) as dat from C, D
),

E as (
select dat from F where datepart(weekday, dat) = 3
and YEAR(dat) & 3 = 0 AND (YEAR(dat) % 25 <> 0 OR YEAR(dat) & 15 = 0)
),

J as (
select *, row_number() over(partition by name order by date) as flag from Battles left join E on Battles.date < E.dat
)

select name, 
trim(str(year(date))) + '-' + 
IIF(len(month(date)) = 1, '0' + trim(str(month(date))), trim(str(month(date)))) + '-' + 
IIF(len(day(date)) = 1, '0' + trim(str(day(date))), trim(str(day(date)))) 
as dd, dat from J where flag = 1
OPTION (MAXRECURSION 1000)
