-- Using RIGHT OUTER JOIN, write a query to display a list of all 
-- services that are not currently in use. Your output should look 
-- like this:

--  description
-- -------------
--  One-to-one Training
-- (1 row)

SELECT description FROM services
RIGHT JOIN customers_services
ON customers_services.service_id = services.id
WHERE customer_id NULL;

--second approach
SELECT description FROM services
WHERE id NOT IN (SELECT service_id FROM customers_services);
