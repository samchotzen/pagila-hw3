/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

--SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
--FROM actor
--JOIN film_actor USING (actor_id)
--JOIN film USING (film_id)
--WHERE first_name || ' ' ||  last_name != 'RUSSELL BACALL' AND title IN (
--    SELECT title
--    FROM film
--    JOIN film_actor USING (film_id)
--    JOIN actor USING (actor_id)
--    WHERE first_name || ' ' ||  last_name = 'RUSSELL BACALL'
--)
--ORDER BY "Actor Name" ASC;

SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
FROM (
    SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM (
            SELECT film_id, actor_id FROM actor JOIN film_actor USING (actor_id) WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
        ) RB0movies
    )
    AND actor_id NOT IN (SELECT actor_id FROM (
            SELECT film_id, actor_id FROM actor JOIN film_actor USING (actor_id) WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
        ) RB0movies
    )
) RB1names
JOIN actor USING (actor_id)
ORDER BY "Actor Name";
