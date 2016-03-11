--Megan OHalloran
--CMPT308: Lab4 SubQueries
--February 12,2016

--#1 Cities of agents booking an order for a customer whose cid is c002
SELECT city
FROM agents
WHERE aid IN (SELECT aid
		FROM orders
	       WHERE cid IN (SELECT cid
			       FROM customers
			       WHERE cid = 'c002')
	     );

--#2 IDs of products ordered through any agent who takes at least one order from
--a customer in Dallas, sorted by PID from highest to lowest.
SELECT pid
FROM orders
WHERE aid IN(SELECT aid
	     FROM orders
	     WHERE cid IN (SELECT cid
			     FROM customers
			    WHERE city = 'Dallas')
	     )
ORDER BY pid DESC;

--#3 IDs and names of customers who did not place an order through an agent a01
--wrong
/*SELECT name, cid
FROM customers
WHERE cid IN (SELECT cid
		FROM orders
               WHERE NOT aid = 'a01');*/
SELECT cid, name
FROM customers
WHERE NOT cid IN (SELECT cid
			FROM customers
			WHERE cid IN (SELECT cid
					FROM orders old
				       WHERE aid = 'a01'));

--#4 Ids of customers who ordered both product p01 and p07
--wrong
/*SELECT cid
FROM orders
WHERE pid = 'p01' AND cid IN(SELECT cid
			       FROM orders
			      WHERE pid = 'p07');*/
SELECT DISTINCT cid
FROM orders
WHERE pid = 'p01' AND cid IN(SELECT cid
			       FROM orders
			      WHERE pid = 'p07');

--#5 IDs of products not ordered by any customers who placed any order through
--agent a07 in PID order from highest to lowest
SELECT pid
FROM orders
WHERE cid IN (SELECT cid
	      FROM orders
	      WHERE NOT aid = 'a07')
ORDER BY pid DESC;

--#6 name, discounts, and city for all customers who place orders through
--agents in London or New York
SELECT name, discount, city
FROM customers
WHERE cid IN (SELECT cid
		FROM orders
		WHERE aid IN (SELECT aid
				FROM agents
				WHERE city = 'New York' OR city = 'London')
		);

--#7 All customers who have the same discount as that of any customer in Dallas or London
SELECT *
FROM customers New
WHERE New.city != 'Dallas' AND New.city != 'London' 
AND New.discount = ANY (SELECT Old.discount
			FROM customers Old
			WHERE Old.city = 'Dallas' OR Old.city = 'London');


--#8.  A check constraint is also known as an integrity constraint in SQL. It is specified in the 
--database and it is a requirement that must be met by each row of the table. A check constraint 
--limits the values that can be accepted by a single, or multiple, columns. Check constraints are 
--good to use to prevent mistakes that can be inputted by the user.  An advantage to check constraints 
--is that it minimizes errors and provides consistency. It is kind of like a guideline for users to follow 
--when putting information into the data tables. A good example of when to use a check constraint would be a 
--database for a college, and inputting a date of birth or a student ID number. By having check constraints on this, 
--we are able to avoid errors when inputting a student ID by restricting the number of digits. We can also 
--ensure consistency with birth dates by having them all formatted in the same way. A bad example of when 
--to use check constraints would be if you are over using them, especially if not necessary. Another example 
--of a bad use of check constraints would be if there was some type of open ended question, and putting a check 
--constraint of how many characters could be submitted. The differences in my two examples is by having a constraint 
--of the amount of characters for a student ID or a birth date, allows there to be organization and fewer mistakes.
-- Whereas having a constraint on an open-ended response could prevent someone from answering the question or not 
--allowing someone to answer the question fully.
