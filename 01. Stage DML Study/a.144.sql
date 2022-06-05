Задание: 144 (Serge I: 2019-01-04)
Найти производителей, которые производят PC как с самой низкой ценой, так и с самой высокой.
Вывод: maker

---

select distinct maker from (
select maker, price, min(price) over() p1 from Product join PC
on Product.model = PC.model
) as C
where price = p1
  intersect
select distinct maker from (
select maker, price, max(price) over() p1 from Product join PC
on Product.model = PC.model
) as A
where price = p1
