--Megan O'Halloran
--Lab3 SQL Queries
--February 3, 2016

--#1 	the order number and total dollars for all orders.
SELECT ordnum, totalUSD
FROM orders;

--#2 name and city of all agents named Smith
SELECT name, city
FROM agents
WHERE name = 'Smith';

--#3 name, ID, priceUSD of products with quantity more than 208000
SELECT pid, name, priceUSD
FROM products
WHERE quantity > 208000;

--#4 names and cities of customers in Dallas
SELECT name, city
FROM customers
WHERE city = 'Dallas';

--#5 names of agents not in New York and not in Tokyo
SELECT name
FROM agents
WHERE NOT city = 'New York' 
  AND NOT city = 'Tokyo';

--#6 all data for products not in Duluth or Dallas that costs us$1 or more
SELECT *
FROM products
WHERE NOT city = 'Dallas'
   AND NOT city = 'Duluth'
   AND priceUSD >= 1.00;

--#7 all data for orders in January or March
SELECT *
FROM orders
WHERE mon = 'jan' 
   OR mon = 'mar';

--#8 all data for orders in February less than us$500
SELECT *
FROM orders
WHERE mon = 'feb'
  AND totalUSD < 500;

--#9 all orders from the customer whose CID is c005
SELECT *
FROM orders
WHERE cid = 'c005';