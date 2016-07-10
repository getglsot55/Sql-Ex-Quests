
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

