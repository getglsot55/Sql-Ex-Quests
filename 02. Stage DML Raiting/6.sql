

-- Предполагая, что не существует номера рейса большего 65535,
-- вывести номер рейса и его представление в двоичной системе счисления (без ведущих нулей)

with cte as (
select [t].[trip_no], [t].[trip_no] as [num], cast('' as varchar(max)) as [bin] from [dbo].[Trip] [t]
union all
select [cte].[trip_no], [cte].[num] / 2, cast(([cte].[num] % 2) as varchar(max)) + [cte].[bin] from [cte] where [cte].[num] > 0)
select * from [cte]
where [cte].[num] = 0;