--Megan O'Halloran
--Lab5: The Joins Three-quel
--February 17, 2016

--#1 cities of agents booking an order for a customer whose cid is 'c002'
SELECT city
FROM agents, orders
WHERE cid = 'c002' AND orders.aid = agents.aid;

--#2 The PID ordered through any agent who makes at least one order for a customer in
--Dallas, sorted by PID from highest to lowest.
SELECT New.pid
FROM customers JOIN orders Old ON customers.cid = Old.cid AND city = 'Dallas', orders New
WHERE Old.aid = New.aid
GROUP BY New.pid, New.aid
ORDER BY New.pid DESC;


--#3 The names of customers who have never placed an order. Use subquery
SELECT name
FROM customers
WHERE cid NOT IN (SELECT cid
		   FROM orders);

--#4 The names of customers who have never placed an order. Use Outer Join
SELECT name
FROM customers
FULL OUTER JOIN orders
ON customers.cid = orders.cid
GROUP BY name, customers.cid
HAVING COUNT(customers.cid != orders.cid) = 0;

--#5 The names of customers who plaved at least one order through an agent in their own city
--along with those agents' names
SELECT DISTINCT customers.name, agents.name
FROM customers, agents, orders
WHERE customers.city = agents.city AND customers.cid = orders.cid AND agents.aid = orders.aid;


--#6 The names of custoers and agents living in the same city, along with the name of the
--shared city, regardless of whether or not the customer has ever placed an order with that agent
SELECT customers.name, agents.name, agents.city
FROM customers, agents
WHERE customers.city = agents.city;

--#7 The name and city of cutomers who live in the city that makes the fewest different
--kinds if products
SELECT name, city
FROM customers
WHERE city IN (SELECT city
		FROM (SELECT city, COUNT(*) AS CityCount
			FROM products
			GROUP BY city
			ORDER BY CityCount ASC
			LIMIT 1) SubCityCount
		);