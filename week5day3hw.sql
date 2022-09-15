--Week 5 - Wednesday Questions

-- 1. List all customers who live in Texas (use JOINs)
SELECT *
FROM customer
JOIN address
ON customer.customer_id = address.address_id
WHERE address.district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > 175
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT *
FROM customer
JOIN address
ON address.address_id = customer.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal'


-- 5. Which staff member had the most transactions?
SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id 
ORDER BY count DESC
LIMIT 1;


-- 6. How many movies of each rating are there?
SELECT rating, count(title) AS rating_movies
FROM film
GROUP BY rating
ORDER BY rating_movies DESC;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer, count(payment_id), payment.amount
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
GROUP BY customer, payment.amount
HAVING count(payment_id) = 1 AND  amount > 6.99

SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer.customer_id
	FROM customer
	JOIN payment
	ON payment.customer_id = customer.customer_id
	GROUP BY customer.customer_id, payment.amount 
	HAVING count(payment_id) = 1 AND amount > 6.99
);

-- 8. How many free rentals did our stores give away?
SELECT COUNT(amount) AS free_rentals
FROM payment 
WHERE payment.amount = 0
