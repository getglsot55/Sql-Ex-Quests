
-- В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра).
-- Вывод: номер модели, тип модели. 

select model, type
from product
where model not like '%[^0-9]%' or upper(model) NOT like '%[^A-Z]%' 




select iif('99999' not like '%[^0-9]%', 1, 0)