--Megan O'Halloran
--Lab 6
--February 24, 2016

--#1 name and city of customers who live in any city that makes the most different kinds of products
SELECT name, city
FROM customers
WHERE city in (SELECT city
		FROM (SELECT city, COUNT(*) AS CityCount
			FROM products
			GROUP BY city
			ORDER BY CityCount DESC
			LIMIT 1) SubCityCount
		);

--#2 names of products whose priceUSD is strictly above	the average priceUSD, in reverse-alphabetical order
SELECT name
FROM products
WHERE priceUSD > (SELECT AVG(priceUSD)
		   FROM products)
ORDER BY name DESC;

--#3 the customer name, pid ordered, and total for all orders, sorted by total from high to low.
SELECT name, pid, SUM(totalUSD) AS total
FROM customers JOIN orders
	ON customers.cid = orders.cid
GROUP BY customers.name, pid, customers.cid
ORDER BY totaL DESC;

--#4 all customer names in alphabetical order and their total ordered and nothing more
SELECT name, SUM(totalUSD)
FROM orders RIGHT JOIN customers
	ON orders.cid = customers.cid
WHERE totalUSD IN(SELECT COALESCE(totalUSD, 0))
GROUP BY customers.name, customers.cid
ORDER BY name ASC;

--#5 names of all customers who bought products from agents based in tokyo along with the names of 
-- products they ordered, and the names of the agents who sold it to them.
SELECT customers.name, products.name, agents.name
FROM customers, products, agents, orders
WHERE orders.cid = customers.cid 
	AND orders.aid = agents.aid 
	AND orders.pid = products.pid 
	AND agents.city = 'Tokyo' 
GROUP BY products.name, agents.name, customers.cid;

--#6 checks the accuracy of the dollars column in orders table. Displays those that are incorrect
SELECT orders.*
FROM orders, products, customers
WHERE orders.cid = customers.cid
	AND orders.pid = products.pid
	AND ((orders.qty*products.priceUSD)-((orders.qty*products.priceUSD)*(customers.discount/100))) != orders.totalUSD;

--#7 	The LEFT OUTER JOIN command in SQL will return all of the rows from the “left table,” which would also be 
--known as one of two tables you want to combine. It matches the rows to the “right table,” which would also 
--be known as the second of your two tables you would like to combine. The match is made based on the condition in the
--ON clause. If there is no match in the right side, then a NULL will be returned. It will return all rows from the left
--table, even if there aren’t any matches in the right table. 
--The RIGHT OUTER JOIN command is very similar to the LEFT OUTER JOIN command however it will return all of the rows from the 
--right table, which is the second table you have selected, and matches it with rows from the left table, which is the 
--first table you have selected, using the condition inside of the ON clause. A NULL will be returned if there are no matches
--from the left side of the table. RIGHT OUTER JOIN will return all of the rows from the right table, even if there are no 
--matches from the left table. 
--An example query for a LEFT JOIN would be:
--SELECT name, pid, SUM(totalUSD) AS total
--FROM customers LEFT OUTER JOIN orders
--	ON customers.cid = orders.cid
--GROUP BY customers.name, orders.pid, customers.cid
--ORDER BY totaL DESC;
--The above example would return all of the rows from the left table, Customers, and matches it with all of the rows from the right 
--table, Orders. However, because there is a customer who did not make any orders, and therefore does not have a match 
--in the right table, a NULL will appear.
--An example query for a RIGHT JOIN would be:
--SELECT name, SUM(totalUSD)
--FROM customers RIGHT OUTER JOIN orders
--	ON orders.cid = customers.cid
--GROUP BY customers.name, customers.cid
--ORDER BY name ASC;
--This would return all of the rows from the right table, Customers, and match all of the rows to the left table Orders. 
--If there was not a match in the left table for the right table, a NULL would appear.
