Задание: 146 (Serge I: 2008-08-30)
Для ПК с максимальным кодом из таблицы PC вывести все его характеристики (кроме кода) в два столбца:
- название характеристики (имя соответствующего столбца в таблице PC);
- значение характеристики

---

with A as (
select 
  cast(model as varchar(max) ) model
, cast(speed as varchar(max) ) speed
, cast(ram as varchar(max) ) ram
, cast(hd as varchar(max) ) hd
, cast(cd as varchar(max) ) cd
, cast(coalesce(price, '0.00') as varchar(max) ) price 
 from PC where code = (select max(code) from PC)
)

select chr, NULLIF(value, '0.00') value from  A
UNPIVOT(
value
FOR chr IN( cd, model, hd, ram, speed, price ) 
) unpvt
