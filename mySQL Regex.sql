SELECT DISTINCT last_name
FROM actor;

SELECT COUNT(DISTINCT last_name) AS num_uniquelastnames 
FROM actor;
-- 121

SELECT COUNT(DISTINCT language_id) AS num_uniquelanguages
FROM film;
-- 1

SELECT count(rating)
FROM film
WHERE rating LIKE "PG-13";
-- 223

SELECT length, release_year
FROM film
WHERE release_year = "2006"
ORDER BY length desc
LIMIT 10;
-- ------- query 6
ALTER TABLE rental
ADD months date;

ALTER TABLE rental
ADD weekday date;

SELECT *
from rental
LIMIT 20;
-- query 7
ALTER TABLE rental ADD COLUMN day_type VARCHAR(10);
UPDATE rentals SET day_type = 
CASE 
    WHEN DAYOFWEEK(rental_day) = 1 OR DAYOFWEEK(rental_day) = 7 THEN 'weekend' 
    ELSE 'workday' 
END;
-- query 8
SELECT count(rental_id)
from rental;
-- query 9
SELECT rating
FROM film;
-- query 10
SELECT release_year
FROM film;
-- query 11
SELECT title
FROM film
WHERE title like "%ARMAGEDDON%";

-- query 12
SELECT title
FROM film
WHERE title like "%APOLLO%";

-- query 13
SELECT title
FROM film
WHERE title like "%APOLLO";

-- query 14
SELECT title
FROM film
WHERE title like "%DATE%";

-- query 15
SELECT * 
FROM film 
ORDER BY LENGTH(title)DESC 
LIMIT 10;
-- query 16
SELECT title, length
FROM film 
ORDER BY length DESC 
LIMIT 10;

-- query 17
SELECT *
FROM film
WHERE special_features like "%Behind the Scenes%";

-- query 18
SELECT title, release_year
FROM film
ORDER BY release_year, title asc;

-- query 19
ALTER TABLE staff
DROP COLUMN picture;

-- query 20
SELECT *
FROM customer;	

INSERT INTO customer (customer_id, store_id, first_name, last_name, email, address_id, customer.active, create_date, last_update)
VALUES (600, 2, 'TAMMY', 'SANDERS', 'TAMMY.SAND', '700', '1', '2006-02-14 22:04:38','2006-02-14 22:04:40');

SELECT *
FROM  customer;

-- query 21 (no me sale)
SELECT * 
FROM rental;

INSERT INTO rental (rental_date, 
inventory_id, customer_id, 
staff_id)
VALUES (NOW(), 6, 130, 1);

USE sakila;
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW(), 6, 130, 1);

-- Error Code: 1136. Column count doesn't match value count at row 1
-- Error Code: 1136. Column count doesn't match value count at row 1


-- query 22

USE sakila;
CREATE TABLE IF NOT EXISTS deleted_users
	(customer_id INT (22) NOT NULL,
    email VARCHAR(50) NOT NULL,
    deleted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = 0;

SELECT *
FROM sakila.deleted_users;











