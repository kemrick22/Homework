/* 1A */
Select first_name, last_name
From actor;

/* 1B  */
SELECT CONCAT (first_name, " ",last_name)
From actor;

/* 2A */
SELECT actor_id, first_name, last_name
FROM actor
Where first_name = "Joe";

/* 2B */
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE "%GEN%";

/* 2C */
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

/* 2D */
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

/* 3A */
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` BLOB NOT NULL AFTER `last_update`;

/* 3B */
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;

/* 4A */
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name;

/* 4B */
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name
HAVING count(last_name)>=2;

/* 4C */
UPDATE actor
SET first_name='HARPO'
WHERE first_name='GROUCHO' and last_name='WILLIAMS';

/* 4D */
UPDATE actor
SET first_name='GROUCHO'
WHERE first_name='HARPO' and last_name='WILLIAMS';

/* 5A */
CREATE SCHEMA `address` ;

/* 6A */
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON
staff.address_id=address.address_id;

/* 6B */
SELECT staff.first_name, staff.last_name, sum(payment.amount)
FROM payment
JOIN staff on payment.staff_id = staff.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY first_name;

/* 6C */
SELECT film.title, count(film_actor.actor_id)
FROM film_actor
JOIN film ON
film.film_id=film_actor.film_id
GROUP BY film.title;

/* 6D */
SELECT film.title, count(inventory.film_id)
FROM film
JOIN inventory ON
film.film_id=inventory.film_id
GROUP BY film.title;

/* 6E */
SELECT customer.first_name, customer.last_name, sum(payment.amount)
FROM customer
JOIN payment ON
customer.customer_id=payment.customer_id
GROUP BY customer.last_name;

/* 7A */
SELECT title
FROM film
WHERE title IN
(
	SELECT title
	FROM film
	WHERE title LIKE 'Q%' OR title LIKE 'K%'
    HAVING language_id=1
    );

/* 7B */
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
	SELECT actor_id
    FROM film_actor
	WHERE film_id IN
	(
		SELECT film_id
        from film
        WHERE title = 'Alone Trip'
	)
);

/* 7C */
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address on customer.address_id = address.address_id
JOIN city on address.city_id = city.city_id
JOIN country on city.country_id = country.country_id
WHERE country = 'Canada';

/* 7D */
SELECT title
FROM film
WHERE film_id IN
(
	SELECT film_id
    FROM film_category
    WHERE category_id IN
    (
		SELECT category_id
		FROM category
		WHERE name = 'Family'
    )
);

/* 7E */
SELECT  film.title, count(rental.inventory_id)
FROM rental JOIN inventory ON
rental.inventory_id=inventory.inventory_id JOIN film ON
inventory.film_id=film.film_id
GROUP BY film.title
ORDER BY count(rental.inventory_id) DESC;

/* 7F */
SELECT store.store_id, sum(payment.amount)
FROM payment JOIN store ON
payment.staff_id=store.manager_staff_id
GROUP BY store.store_id;

/* 7G */
SELECT store.store_id, city.city, country.country
FROM store JOIN address ON
store.address_id=address.address_id JOIN city ON
address.city_id = city.city_id JOIN country ON
city.country_id = country.country_id
GROUP BY store_id;

/* 7H */
SELECT category.name, sum(payment.amount)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY name
ORDER BY amount DESC;

/* 8A */
CREATE VIEW top_genre AS
SELECT category.name, sum(payment.amount)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY name
ORDER BY amount DESC
LIMIT 5;

/* 8B */
SELECT * FROM top_genre;

/* 8C */
DROP VIEW top_genre;
