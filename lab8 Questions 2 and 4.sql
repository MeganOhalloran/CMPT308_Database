--Megan O'Halloran
--Lab 8 Question 2 and 4

--Question 2
CREATE TABLE people (
	pid char(4) NOT NULL,
	fullName text NOT NULL,
	address text NOT NULL,
	spouseName text,
	primary key (pid) );
	
CREATE TABLE directors (
	dirid char(4) NOT NULL,
	pid char(4) NOT NULL,
	DGA date NOT NULL,
	favLensMake text NOT NULL,
	primary key(dirid),
	foreign key(pid) references people);
	
CREATE TABLE movies (
	mid char(4) NOT NULL,
	dirid char(4) NOT NULL,
	mName text NOT NULL,
	yearReleased int NOT NULL,
	MPAA text NOT NULL,
	domBoxOffSales money NOT NULL,
	forBoxOffSales money NOT NULL,
	diskSales money NOT NULL,
	primary key(mid),
	foreign key(dirid) references directors );
	
CREATE TABLE actors (
	aid char(4) NOT NULL,
	pid char(4) NOT NULL,
	mid char(4) NOT NULL,
	dob date NOT NULL,
	hairColor text NOT NULL,
	eyeColor text NOT NULL,
	heightIn int NOT NULL,
	weight int NOT NULL,
	favColor text NOT NULL,
	SAGA date NOT NULL,
	primary key(aid),
	foreign key(pid) references people,
	foreign key(mid) references movies);


--Question 4
SELECT fullName
FROM people
WHERE pid IN(SELECT pid
	     FROM directors
	    WHERE dirid IN (SELECT dirid
			      FROM movies
			      WHERE mid IN (SELECT mid
					      FROM actors
					      WHERE pid IN (SELECT pid
							     FROM people
							    WHERE fullName =  'Sean Connery'))));
