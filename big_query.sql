CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	quantity INT NOT NULL
);

CREATE TABLE operations_log (
	id SERIAL PRIMARY KEY,
	product_id INT,
	operation VARCHAR(50) NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE OR REPLACE PROCEDURE update_stock(product_id INT, operation VARCHAR, used_quantity INT)
AS $$
BEGIN
	IF NOT EXISTS (SELECT id FROM products WHERE id = product_id) THEN
		RAISE EXCEPTION 'Товар с ID % не найден', product_id;
	END IF;

	IF operation = 'ADD' THEN
		UPDATE products
		SET quantity = quantity + used_quantity
		WHERE id = product_id;
	ELSEIF operation = 'REMOVE' THEN
		IF (SELECT quantity FROM products WHERE id = product_id) < used_quantity THEN
			RAISE EXCEPTION 'Слишком много надо удалить, столько не существует';
		END IF;

		UPDATE products p
		SET quantity = p.quantity - used_quantity
		WHERE id = product_id;
	ELSE 
		RAISE EXCEPTION 'Недопустимая операция: %', operation;
	END IF;

	INSERT INTO operations_log(product_id, operation, quantity)
	VALUES (product_id, operation, used_quantity);
END;
$$ LANGUAGE plpgsql;