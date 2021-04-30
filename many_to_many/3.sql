-- Write a query to retrieve the customer data for every 
-- customer who does not currently subscribe to any services.

SELECT customers.* FROM customers
WHERE id NOT IN (SELECT customer_id FROM customers_services);

--second approach
SELECT customers.* FROM customers
LEFT JOIN customers_services 
ON customers_services.customer_id = customers.id
WHERE customers_services.service_id IS NULL;

-- Can you write a query that displays all customers with no 
-- services and all services that currently don't have any 
-- customers? The output should look like this:

--  id |     name      | payment_token | id |     description     | price
-- ----+---------------+---------------+----+---------------------+--------
--   2 | Nancy Monreal | JKWQPJKL      |    |                     |
--     |               |               |  8 | One-to-one Training | 999.00
-- (2 rows)

SELECT customers.*, services.* FROM customers
FULL JOIN customers_services 
ON customers_services.customer_id = customers.id
FULL JOIN services
ON services.id = customers_services.service_id
WHERE customers_services.id IS NULL;