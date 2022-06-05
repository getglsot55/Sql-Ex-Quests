Задание: 137 (Serge I: 2005-01-19)
Для каждой пятой модели (в порядке возрастания номеров
моделей) из таблицы Product
определить тип продукции и среднюю цену модели.

---

with A as (
   select Product.model, Product.type, price from Product left join
   PC on Product.model = PC.model
union all
   select Product.model, Product.type, price from Product left join
   Laptop on Product.model = Laptop.model
union all
   select Product.model, Product.type, price from Product left join
   Printer on Product.model = Printer.model
),

B as (
select *, dense_rank() over(order by model) cnt from A
)

select type, avg(price) from B
where cnt % 5 = 0
group by  model, type
