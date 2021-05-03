-- Assuming that everybody in our database has a bill coming due, 
-- nd that all of them will pay on time, write a query to compute 
-- the total gross income we expect to receive.

-- Answer:

--   gross
--  --------
--  678.50
-- (1 row)

SELECT SUM(price) AS gross FROM services
JOIN customers_services 
ON customers_services.service_id = services.id;