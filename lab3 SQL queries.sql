--Megan O'Halloran
--Lab3 SQL Queries
--February 3, 2016

SELECT ordnum, totalUSD
FROM orders;

SELECT name, city
FROM agents
WHERE name = 'Smith';

SELECT pid, name, priceUSD
FROM products
WHERE quantity > 208000;

SELECT name, city
FROM customers
WHERE city = 'Dallas';

SELECT name
FROM agents
WHERE NOT city = 'New York' 
  AND NOT city = 'Tokyo';

SELECT *
FROM products
WHERE NOT city = 'Dallas'
   AND NOT city = 'Duluth'
   AND priceUSD >= 1.00;

SELECT *
FROM orders
WHERE mon = 'jan' 
   OR mon = 'mar';

SELECT *
FROM orders
WHERE mon = 'feb'
  AND totalUSD < 500;

SELECT *
FROM orders
WHERE cid = 'c005';