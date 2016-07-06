

-- Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') и имевшие когда-либо классы крейсеров ('bc').

select country
from dbo.Classes
where [type] = 'bb'
intersect 
select country
from dbo.Classes
where [type] = 'bc'