-- Lab mySQL Regex
USE sakila;
-- 1. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(actor.last_name)) AS `THE COUNT` FROM actor;

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(DISTINCT(film.language_id)) AS `THE COUNT` FROM film;

-- 3. How many movies were released with "PG-13" rating?
SELECT COUNT(film.film_id) AS `THE COUNT` FROM film
WHERE film.rating = "PG-13";

-- 4. Get 10 the longest movies from 2006.
SELECT film.title AS `TITLE`, film.length AS `LENGTH` FROM film
WHERE film.release_year = 2006
ORDER BY film.length DESC LIMIT 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
-- DATEDIFF(NOW(), fecha_de_inicio) pero no tengo ni idea de la fecha de inicio, no veo una tabla que de esa info

-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update, MONTHNAME(rental_date) AS `month`, DAYNAME(rental_date) AS `weekday` FROM rental
LIMIT 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update,
       CASE 
         WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
         ELSE 'workday'
       END AS day_type
FROM rental
LIMIT 20;

-- 8. How many rentals were in the last month of activity?
SELECT COUNT(*) as `Number of Rentals` FROM rental
WHERE MONTH(rental_date) = MONTH(NOW()) AND YEAR(rental_date) = YEAR(NOW());

-- 9. Get film ratings.
SELECT title, rating FROM film;

-- 10. Get release years.
SELECT title, release_year FROM film;

-- 11. Get all films with ARMAGEDDON in the title.
SELECT title FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- 12. Get all films with APOLLO in the title
SELECT title FROM film
WHERE title LIKE '%APOLLO%';

-- 13. Get all films which title ends with APOLLO.
SELECT title FROM film
WHERE title LIKE '%APOLLO';

-- 14. Get all films with word DATE in the title.
SELECT title FROM film
WHERE title LIKE '%DATE%';

-- 15. Get 10 films with the longest title.
SELECT title FROM film
ORDER BY LENGTH(title) DESC LIMIT 10;

-- 16. Get 10 the longest films.
SELECT title FROM film
ORDER BY length DESC LIMIT 10;

-- 17. How many films include Behind the Scenes content?
SELECT COUNT(*) AS `Behind the Scenes Count` FROM film 
WHERE special_features LIKE '%Behind the Scenes%';

-- 18. List films ordered by release year and title in alphabetical order.
SELECT title, release_year FROM film
ORDER BY release_year, title;

-- 19. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, last_update)
VALUES (3, 'Tammy', 'Sanders', 5, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', NOW());

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
-- You can use current date for the rental_date column in the rental table.
-- Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
-- To get that you can use the following query:
-- (130)
SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE'
AND last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.
-- inventory_id: (1 - 4)
-- film_id: (1)
-- store_id: (1 - 4: 1)
-- staff_id: (1)
SELECT film.title, inventory.inventory_id, inventory.film_id, inventory.store_id FROM inventory, film
WHERE inventory.film_id = film.film_id
AND film.title = 'Academy Dinosaur';
SELECT * FROM staff; -- para saber que el staff_id de Mike Hillyer es '1'
-- rental_id: (16050)
SELECT * FROM rental ORDER BY rental_id DESC LIMIT 1; -- para saber el último rental_id existente

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, staff_id)
VALUES (16050, NOW(), 1, 130, 1);

-- 22. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email,
-- and the date for the users that would be deleted. Follow these steps:
	-- Check if there are any non-active users
	-- Create a table backup table as suggested
    -- Insert the non active users in the table backup table
    -- Delete the non active users from the table customer

-- Check de usuarios no activos
SELECT customer_id, first_name, last_name, active FROM customer
WHERE active = 0;

-- Creación de tabla backup
CREATE TABLE IF NOT EXISTS deleted_users (
	`customer_id` smallint UNIQUE PRIMARY KEY,
    `email` varchar(50),
    `create_date` datetime
);

-- Insertar a los usuarios inactivos de customer
INSERT INTO deleted_users (customer_id, email, create_date)
SELECT customer_id, email, create_date FROM customer
WHERE active = 0;

-- Borrar a los usuarios inactivos de customer
DELETE FROM payment -- FK asociada
WHERE customer_id IN (
	SELECT customer_id FROM customer
    WHERE active = 0
);

DELETE FROM rental -- FK asociada
WHERE customer_id IN (
	SELECT customer_id FROM customer
    WHERE active = 0
);

DELETE FROM customer
WHERE active = 0;
