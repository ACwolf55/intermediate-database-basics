-- JOINS

--#1
SELECT * FROM invoice i
JOIN invoice_line inl ON inl.invoice_id = i.invoice_id
WHERE inl.unit_price > .99;

--#2
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

--#3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c JOIN employee e ON c.support_rep_id = e.employee_id;

--#4
SELECT al.title, ar.name 
FROM album al JOIN artist ar
ON al.artist_id = ar.artist_id;

--#5
SELECT p.name, pt.track_id
FROM playlist p JOIN playlist_track pt
ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

--#6
SELECT t.name,p.playlist_id
FROM track t JOIN playlist_track p
ON p.track_id = t.track_id
WHERE p.playlist_id = 5;

--#7
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

--#8
SELECT t.name,a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';


-- NESTED QUIERIES

--#1
SELECT * FROM invoice
WHERE invoice_id IN (
    SELECT invoice_id FROM invoice_line 
    WHERE unit_price > .99)

--#2
SELECT * FROM playlist_track
WHERE playlist_id IN (
  SELECT playlist_id FROM playlist WHERE name = 'Music');

--#3
SELECT name FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

--#4
SELECT*FROM track WHERE genre_id
IN (SELECT genre_id FROM genre WHERE name ='Comedy')

--#5
SELECT*FROM track 
WHERE album_id IN(SELECT album_id FROM album WHERE title = 'Fireball');

--#6
SELECT * FROM track
WHERE album_id
IN(SELECT album_id FROM album WHERE artist_id 
IN(SELECT artist_id FROM artist WHERE name = 'Queen'))

-- Updating Rows

--#1
UPDATE customer SET fax = null
WHERE fax IS NOT null;

--#2
UPDATE customer SET company = 'Self'
WHERE company IS null;

--#3
UPDATE customer SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

--#4
UPDATE customer SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

--#5
UPDATE track SET composer = 'The darkness around us'
WHERE genre_id =( SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;


-- GROUP BY

--#1
SELECT COUNT(*), g.name
FROM track t JOIN genre g
ON t.genre_id = g.genre_id
GROUP BY g.name;

--#2
SELECT COUNT (*), g.name
FROM track t JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name ='Pop' OR g.name = 'Rock'
GROUP BY g.name;

--#3 
SELECT ar.name, COUNT (*)
FROM album al JOIN artist ar 
ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- USE DISTINCT

--#1
SELECT DISTINCT composer 
FROM track;

--#2
SELECT DISTINCT billing_postal_code
FROM invoice;

--#3
SELECT DISTINCT company
FROM customer;

-- DELETE ROWS

--#1
DELETE FROM practice_delete
WHERE type = 'bronze';

--#2
DELETE FROM practice_delete
WHERE type = 'silver';

--#3
DELETE FROM practice_delete
WHERE value = 150;

-- eCommerce Simulation

-- CREATE TABLES
CREATE TABLE users(
  user_Id SERIAL PRIMARY KEY,
  name varchar(20),
  email VARCHAR(40)
);

CREATE TABLE products(
  product_Id SERIAL PRIMARY KEY,
  name varchar(20),
  price DECIMAL
);

CREATE TABLE orders(
  order_Id SERIAL PRIMARY KEY,
  product_id INT REFERENCES products(product_id),
  user_id INT REFERENCES users(user_id)
);

--FILL ROWS
INSERT INTO users
(name,email)
VALUES
('Mike', 'mike@mail.com'),('Nick', 'nick@mail.com'),('Lorie', 'lorie@mail.com');

INSERT INTO products
(name,price)
VALUES
('n64', 100),('mug', 5),('stereo', 70),('pears',.50);

INSERT INTO orders
(product_id,user_id)
VALUES
(1,1),(3,1),(3,1);

INSERT INTO orders
(product_id,user_id)
VALUES
(1,2),(4,2),(4,2);

INSERT INTO orders
(product_id,user_id)
VALUES
(2,3);


--QUERIES

-- Get all products for the first order:
SELECT * FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_id = 1;

-- Get all orders:
SELECT * FROM orders 

-- Get the total cost of an order ( gwtting sum of all user products)
SELECt SUM(p.price) FROM 
products p
JOIN orders o ON p.product_id= o.product_id
WHERE o.user_id = 1

-- GEt all orders for a user
SELECT * FROM 
orders o
JOIN products p ON p.product_id= o.product_id
WHERE o.user_id = 1   

--Get how many order each user has(for how my tables are set up Ill get the the amount of products user has)
SELECt COUNT(o.order_id) FROM 
products p
JOIN orders o ON p.product_id= o.product_id
WHERE o.user_id = 1











