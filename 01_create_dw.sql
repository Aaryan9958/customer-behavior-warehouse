-- Data Warehouse creation scripts

CREATE OR REPLACE VIEW customer_payment_summary_LATEST_VERSION AS
SELECT 
    r.customer_id,
    COUNT(r.rental_id) AS total_rentals,
    COALESCE(SUM(p.amount), 0) AS total_spent,
    COALESCE(MAX(p.amount), 0) AS max_spend_per_rental,
    COALESCE(MIN(CASE WHEN p.amount > 0 THEN p.amount ELSE NULL END), 0) AS min_spend_per_rental,
    ROUND(COALESCE(SUM(p.amount), 0) / NULLIF(COUNT(r.rental_id), 0), 2) AS avg_spent_per_rental,
    ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 2) AS average_rental_duration
FROM rental r
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY r.customer_id;

CREATE TABLE customer_warehouse_LATEST_VERSION AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.store_id,
    ci.city,
    co.country,
    COALESCE(cps.total_rentals, 0) AS total_rentals,
    COALESCE(cps.total_spent, 0) AS total_spent,
    COALESCE(cps.max_spend_per_rental, 0) AS max_spend_per_rental,
    COALESCE(cps.min_spend_per_rental, 0) AS min_spend_per_rental,
    COALESCE(cps.avg_spent_per_rental, 0) AS avg_spent_per_rental,
    COALESCE(cps.average_rental_duration, 0) AS average_rental_duration,
    (
        SELECT cat.name
        FROM rental r2
        JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
        JOIN film_category fc ON i2.film_id = fc.film_id
        JOIN category cat ON fc.category_id = cat.category_id
        WHERE r2.customer_id = c.customer_id
        GROUP BY cat.name
        ORDER BY COUNT(r2.rental_id) DESC
        LIMIT 1
    ) AS favorite_category,
    (
        SELECT f.title
        FROM rental r3
        JOIN inventory i3 ON r3.inventory_id = i3.inventory_id
        JOIN film f ON i3.film_id = f.film_id
        WHERE r3.customer_id = c.customer_id
        GROUP BY f.title
        ORDER BY COUNT(r3.rental_id) DESC
        LIMIT 1
    ) AS most_rented_movie,
    MAX(r.rental_date) AS last_rental_date,
    c.active AS customer_active,
    (
        SELECT COUNT(r4.rental_id)
        FROM rental r4
        JOIN inventory i4 ON r4.inventory_id = i4.inventory_id
        WHERE r4.customer_id = c.customer_id AND i4.store_id = c.store_id
    ) AS rentals_in_home_store
FROM customer c
LEFT JOIN address a ON c.address_id = a.address_id
LEFT JOIN city ci ON a.city_id = ci.city_id
LEFT JOIN country co ON ci.country_id = co.country_id
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN customer_payment_summary_LATEST_VERSION cps ON c.customer_id = cps.customer_id  
GROUP BY c.customer_id;

-- Preview
SELECT * FROM customer_warehouse_LATEST_VERSION
LIMIT 25;
