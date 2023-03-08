/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH RB0movies AS (
    SELECT film_id, actor_id
    FROM actor
    JOIN film_actor USING (actor_id)
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),

RB1actors AS (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (SELECT film_id FROM RB0movies) AND actor_id NOT IN (SELECT actor_id FROM RB0movies)
),

RB1movies AS (
    SELECT *
    FROM actor
    JOIN RB1actors USING (actor_id)
    WHERE actor_id IN (SELECT * FROM RB1actors)
),

RB2actors AS (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (SELECT film_id FROM RB1movies) AND actor_id NOT IN (SELECT * FROM RB1actors) AND actor_id NOT IN (SELECT actor_id FROM RB0movies)
)

SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
FROM RB2actors
JOIN actor USING (actor_id)
ORDER BY "Actor Name";
