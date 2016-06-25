
---
select cl.class, ships.name, cl.country
from ships join classes as cl on ships.class=cl.class
where cl.numGuns>=10
