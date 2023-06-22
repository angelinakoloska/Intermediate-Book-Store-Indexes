--Existing Structure
SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM books
LIMIT 10;

SELECT *
FROM pg_Indexes
WHERE tablename = 'customers';

SELECT *
FROM pg_Indexes
WHERE tablename = 'orders';

SELECT *
FROM pg_Indexes
WHERE tablename = 'books';

-- Partial Index
EXPLAIN ANALYZE SELECT customer_id, quantity
FROM orders
WHERE quantity > 18;

CREATE INDEX customer_id_quantity_idx ON orders (customer_id, quantity);

EXPLAIN ANALYZE SELECT customer_id, quantity
FROM orders
WHERE quantity > 18;

-- Primary Key
ALTER TABLE customers
  ADD CONSTRAINT customers_pkey
    PRIMARY KEY (customer_id);

EXPLAIN ANALYZE SELECT *
FROM customers
WHERE customer_id < 100;

CREATE INDEX customer_id_idx ON customers(customer_id)
WHERE customer_id < 100;

EXPLAIN ANALYZE SELECT * FROM customers 
WHERE customer_id < 100;

SELECT *
FROM pg_Indexes
WHERE tablename = 'customers';

CLUSTER customers using customers_pkey;

-- No secondary lookup
CREATE INDEX customer_id_book_id_idx 
ON orders(customer_id, book_id);

DROP INDEX IF EXISTS customer_id_book_id_idx;

CREATE INDEX customer_id_book_id_quantity_idx 
ON orders(customer_id, book_id, quantity);

-- Combining Indexes
CREATE INDEX author_title_idx ON books(author, title);

-- An Ounce of Prevention is worth a Pound of Cure
EXPLAIN ANALYZE SELECT *
FROM orders
WHERE (quantity * price_base) > 100;

CREATE INDEX quantity_price_base_idx ON orders((quantity * price_base));

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE (quantity * price_base) > 100;
