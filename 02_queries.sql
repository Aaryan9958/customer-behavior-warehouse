-- Analytical queries on the data warehouse

-- 1) Top 5 Countries by Total Rentals and Average Spend Per Rental
SELECT country, COUNT(customer_id) AS total_customers, SUM(total_rentals) AS total_rentals,
       ROUND(AVG(avg_spent_per_rental), 2) AS avg_spend_per_rental
FROM customer_warehouse_LATEST_VERSION
GROUP BY country
ORDER BY total_rentals DESC
LIMIT 5;

-- 2) Top 10 Customers by Total Spending
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent
FROM customer_warehouse_LATEST_VERSION
ORDER BY total_spent DESC
LIMIT 10;

-- 3) Most Popular Categories by Store
SELECT  store_id, favorite_category, COUNT(*) AS category_count
FROM  customer_warehouse_LATEST_VERSION
GROUP BY store_id, favorite_category
ORDER BY store_id, category_count DESC;

-- 4) Average and Total Rental Spend per Country
SELECT 
    country,
    ROUND(AVG(avg_spent_per_rental), 2) AS avg_spent_per_rental,
    SUM(total_spent) AS total_spent,
    SUM(total_rentals) AS total_rentals
FROM customer_warehouse_LATEST_VERSION
GROUP BY country
ORDER BY total_spent DESC
LIMIT 25;

-- 5) City-Level Revenue Analysis
SELECT 
    country,
    city,
    SUM(total_rentals) AS total_rentals,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(SUM(total_spent) / NULLIF(SUM(total_rentals), 0), 2) AS average_spend_per_rental
FROM customer_warehouse_LATEST_VERSION
GROUP BY country, city
ORDER BY total_revenue DESC
LIMIT 25;

-- 6) Average Rental Duration per Country
SELECT 
    country,
    ROUND(AVG(average_rental_duration), 2) AS average_rental_duration
FROM customer_warehouse_LATEST_VERSION
GROUP BY country
ORDER BY average_rental_duration DESC
LIMIT 25;

-- 7) Home Store vs Non-Home Store Rentals (ratio)
SELECT 
    customer_id,
    first_name,
    last_name,
    total_rentals,
    rentals_in_home_store,
    ROUND(rentals_in_home_store / NULLIF(total_rentals, 0) * 100, 2) AS home_store_rental_ratio
FROM customer_warehouse_LATEST_VERSION
WHERE total_rentals > 0
ORDER BY home_store_rental_ratio DESC
LIMIT 25;

-- 8) Top 25 single-transaction purchases per customer
SELECT 
    customer_id,
    first_name,
    last_name,
    max_spend_per_rental
FROM customer_warehouse_LATEST_VERSION
ORDER BY max_spend_per_rental DESC
LIMIT 25;
