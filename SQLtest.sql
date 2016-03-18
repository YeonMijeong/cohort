#영화별 매출
SELECT
	film.film_id, film.title, rental.rental_id, COUNT(rental.rental_id) count, film.rental_rate, COUNT(rental.rental_id)*film.rental_rate total
FROM
	rental, film, inventory
WHERE film.film_id = inventory.film_id
	AND inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
;

#배우별 영화매출 탑 10
DROP Temporary TABLE IF EXISTS revenue_per_film;
CREATE TEMPORARY TABLE revenue_per_film
SELECT
	film.film_id, film.title, rental.rental_id, COUNT(rental.rental_id) count, film.rental_rate, COUNT(*)*film.rental_rate total
FROM
	rental, film, inventory
WHERE film.film_id = inventory.film_id
	AND inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
;

SELECT
	actor.actor_id, actor.first_name, actor.last_name, SUM(revenue_per_film.total) total_revenue_per_actor
FROM
	film_actor, actor, revenue_per_film
WHERE
	film_actor.actor_id = actor.actor_id
	AND film_actor.film_id = revenue_per_film.film_id
GROUP BY 1
ORDER BY total_revenue_per_actor DESC
LIMIT 10
;
	
