USE sakila;

-- How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name)
	FROM actor;

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(language_id)
	FROM film;

-- How many movies were released with "PG-13" rating?
SELECT COUNT(rating)
	FROM film
		WHERE rating = 'PG-13';

-- Get the 10 longest movies from 2006.
SELECT title, length, release_year
	FROM film
		WHERE release_year = '2006'
	ORDER BY length DESC
    LIMIT 10;

-- How many days has been the company operating (check DATEDIFF() function)?


-- Show rental info with additional columns month and weekday. Get 20.
SELECT *, EXTRACT(MONTH FROM rental_date) AS 'month', WEEKDAY(rental_date) as 'weekday' FROM rental
	LIMIT 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.


-- How many rentals were in the last month of activity?
SELECT * FROM rental
	ORDER BY rental_date DESC;
    
SELECT rental_id, rental_date
	FROM rental
		WHERE rental_date REGEXP '2006-02';
    
SELECT COUNT(rental_id)
	FROM rental
		WHERE rental_date REGEXP '2006-02';

-- Get film ratings.
SELECT film_id, title, rating FROM film
	ORDER BY rating DESC;

-- Get release years.
SELECT film_id, title, release_year FROM film;