-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK (unit_price > 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1))

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
SELECT product_name INTO t_products FROM products WHERE discontinued = 1

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products; -- Удаление зависимости order_details и products
DELETE FROM products WHERE discontinued = 1; -- Удаление строк в таблице products в зависимости discontinued = 1
DELETE FROM order_details WHERE product_id NOT IN (SELECT product_id FROM products); -- Удаление строк product_id.order_details которых нет в product_id.products
DELETE FROM orders WHERE order_id NOT IN (SELECT order_id FROM order_details); -- Удаление строк order_id.orders которых нет в product_id.order_details
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_products FOREIGN KEY(product_id) REFERENCES products(product_id) -- Возвращение зависимости order_details и products

