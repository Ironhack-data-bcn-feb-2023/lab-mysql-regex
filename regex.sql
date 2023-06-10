use sakila;

#1. 
select count(distinct last_name) from actor;

#2.
select * from film, language
where film.language_id = language.language_id;

#The original language is always null
select * from film where original_language_id != null;

#3. 
select count(film_id) from film where rating = "PG-13";

#4. 
select title, length from film
where release_year = "2006"
order by length desc
limit 10;

#5.
select datediff(max(payment_date), min(payment_date)) from payment;

#6.
select *, month(return_date), weekday(return_date) from rental limit 20;

#7.
select *, month(return_date),  weekday(return_date), if(weekday(return_date) < 5, "workday", "weekend") as day_type from rental;

#8.
select count(*) from rental
where month(return_date) = (select month(max(return_date)) from rental) and
	  year(return_date) = (select year(max(return_date)) from rental);
      
#9.
select title, rating from film;

#10.
select title, release_year from film;

#11.
SELECT title
FROM film
WHERE (title) REGEXP 'ARMAGEDDON';

#12.
SELECT title
FROM film
WHERE (title) REGEXP 'APOLLO';

#13.
SELECT title
FROM film
WHERE (title) REGEXP 'APOLLO$';

#14.
SELECT title
FROM film
WHERE title like '% DATE' or title like 'DATE %';

#15
select title, length(title) from film
order by length(title) desc
limit 10;


#16.
select title, length from film
order by length desc
limit 10;

#17.
select count(title) from film
where special_features LIKE '%Behind the Scenes%';

#18.
select title, release_year
from film order by release_year, title asc;

#19.
alter table staff drop column picture;

#20.
select * from customer
where first_name = 'TAMMY';

select * from staff
where first_name = 'JON';

select staff_id from staff;

insert into staff values(3, 'TAMMY', 'SANDERS', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'tammy', NULL, NOW());
select * from staff;

#21.
select * from film where title LIKE 'ACADEMY DINOSAUR';

select * from inventory, film where store_id = 1 and title LIKE 'ACADEMY DINOSAUR';

select * from staff;

select * from customer where first_name = "CHARLOTTE";

select * from rental;

# for inventory_id, we supposed that the last inventory_id is telling that the film is available for renting
insert into rental values (16050, NOW(), 4577, 130, Now() + 6, 1, now());


#22.
select * from customer where active = '0';

CREATE TABLE deleted_users (
customer_id INT(22),
email VARCHAR(50),
date TIMESTAMP);

select customer_id, email from customer where active = '0';

INSERT INTO deleted_users (customer_id, email, date)
SELECT customer_id, email, NOW()
FROM customer 
WHERE active = '0';

select * from deleted_users;

delete from customer where active = '0';
