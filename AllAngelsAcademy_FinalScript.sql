--Megan O'Halloran
--CMPT308: Deatabase Design Project
--All Angels Academy: DB Script
--April 1, 2016

-- DROP TABLES --
DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS shift;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS children CASCADE;
DROP TABLE IF EXISTS animals CASCADE;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS admissions;
DROP TABLE IF EXISTS adoptions;
DROP TABLE IF EXISTS kennels CASCADE;
DROP TABLE IF EXISTS shelteredPets;
DROP TABLE IF EXISTS kennelPets;
DROP TABLE IF EXISTS medical;

-- CREATE TABLE STATEMENTS --
-- Create people Table --
CREATE TABLE people (
	pid char(4) NOT NULL,
	fName text NOT NULL,
	lName text NOT NULL,
	address text NOT NULL,
	city text NOT NULL,
	zipcode integer NOT NULL,
	phoneNo text NOT NULL,
	primary key(pid)
);

--Create jobs Table --
CREATE TABLE jobs (
	jobid char(4) NOT NULL,
	jobTitle text NOT NULL,
	salary money NOT NULL,
	jobDescrip text NOT NULL,
	primary key(jobid)
);

--Create shift Table --
CREATE TABLE shift (
	sid char(4) NOT NULL,
	dayOfWeek text NOT NULL,
	startTime time NOT NULL,
	endTime time NOT NULL,
	typeShift text NOT NULL,
	primary key(sid)
);

--Create staff Table --
CREATE TABLE staff (
	pid char(4) NOT NULL references people(pid),
	jobid text NOT NULL references jobs(jobid),
	dob date NOT NULL,
	dateHired date NOT NULL,
	dateReleased date,
	sid char(4) NOT NULL references shift(sid),
	primary key(pid),
	foreign key(sid) references shift(sid), 
	foreign key(jobid) references jobs(jobid)
);

--Create children Table
CREATE TABLE children (
	cid char(4) NOT NULL,
	cName text NOT NULL,
	cGender char(1) NOT NULL CHECK(cGender = 'M'
					OR cGender = 'F'),
	dob date NOT NULL,
	pid char(4) references people(pid),
	attendance text,
	primary key(cid),
	foreign key(pid) references people(pid)
);

--Create animals Table
CREATE TABLE animals (
	aid char(4) NOT NULL,
	aName text NOT NULL,
	typeAnimal text NOT NULL,
	dob date NOT NULL,
	pid char(4) references people(pid),
	animalOwned boolean NOT NULL,
	animalSheltered boolean NOT NULL,
	primary key(aid),
	foreign key(pid) references people(pid)
);

--Create clients Table
CREATE TABLE clients (
	pid char(4) NOT NULL references people(pid),
	primary key(pid)
);

--Create admissions Table
CREATE TABLE admissions (
	admid SERIAL,
	aid char(4) NOT NULL references animals(aid),
	admDate date NOT NULL,
	disDate date,
	primary key(admid),
	foreign key(aid) references animals(aid)
);

--Create adoptions Table
CREATE TABLE adoptions (
	aid char(4) NOT NULL references animals(aid),
	pid char(4) NOT NULL references people(pid),
	adoptDate date NOT NULL DEFAULT current_date,
	primary key(aid),
	foreign key(pid) references people(pid)
); 
--Create kennels Table
CREATE TABLE kennels(
	kid char(4),
	aid char(4),
	primary key(kid),
	foreign key(aid) references animals(aid)
);

--Create shelteredPets Table
CREATE TABLE shelteredPets (
	aid char(4) NOT NULL references animals(aid),
	kid char(4) NOT NULL references kennels(kid),
	primary key(aid),
	foreign key(kid) references kennels(kid)
);

--Create kennelPets Table
CREATE TABLE kennelPets (
	aid char(4) NOT NULL references animals(aid),
	kid char(4) NOT NULL references kennels(kid),
	pid char(4) NOT NULL references people(pid),
	primary key(aid),
	foreign key(kid) references kennels(kid),
	foreign key(pid) references people(pid)
);

--Create medical Table
CREATE TABLE medical (
	medid SERIAL,
	aid char(6) references animals(aid),
	cid char(4) references children(cid),
	reason text NOT NULL,
	dateOfMed date NOT NULL DEFAULT current_date,
	pid char(4) references people(pid),
	primary key(medid),
	foreign key(aid) references animals(aid),
	foreign key(cid) references children(cid),
	foreign key(pid) references people(pid)
);

--INITIAL INSERT STATEMENTS --
-- People --
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p001', 'Megan', 'Ohalloran', '20 Give Me An A Dr', 'Poughkeepsie', '12603', '(845)112-2334');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p002', 'Daniel', 'Pafumi', '15 Harley Davison Ln', 'Hopewell Junction', '12602', '223-3445');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p003', 'Chrissy', 'Turner', '2 Many Dogs Circle', 'Poughquag', '12603', '556-6778');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p004', 'Liz', 'Jones', '13 Elizabeth Ln', 'Wappengers Falls', '12601', '(845)889-1010');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p005', 'Joyce', 'Smith', '50 Felines Ct', 'Poughkeepsie', '12603', '101-0111');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p006', 'Rob', 'Bevilacqua', '23 Fish Dr', 'Beacon', '12602', '111-1122');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p007', 'Alan', 'Labouseur', '007 Sean Connery Ln', 'Poughquag', '12603', '(845)266-3007'); --2663 is 'BOND'
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p008', 'Bob', 'Monaco', '16 Chevy Ct', 'Hopewell Junction', '12602', '121-2133');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p009', 'Corey', 'Doe', '93 Jurrassic Circle', 'Wappengers Falls', '12601', '131-3144');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p010', 'Kat', 'Smelly', '89 Smelly Cat Dr', 'Poughkeepsie', '12603', '141-4155');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p011', 'Kevin', 'Scharr', '78 Nerdy Ln', 'Wappengers Falls', '12601', '(845)151-5166');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p012', 'Sarah', 'Grunbok', '32 Bunny Hill', 'Wappengers Falls', '12601', '(845)161-16177');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p013', 'Jackie', 'Morris', '52 Morris Ln', 'Beacon', '12602', '171-7188');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p014', 'Alex', 'Frato', '10 Wassabi Circle', 'Poughkeepsie', '12603', '181-8199');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p015', 'Liz', 'Schlusser', '21 Crew Dr', 'LaGrange', '12603', '(845)191-9202');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p016', 'Ramona', 'Rodriguez', '50 Rasberry Dr', 'Wappengers Falls', '12601', '(845)202-0212');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p017', 'Jess', 'Saygeh', '20 Vann Rd', 'Fishkill', '12602', '(845)212-1222');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p018', 'Dillan', 'Smith', '30 LaGrange Ave', 'LaGrangeville', '12603', '222-2232');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p019', 'Jake', 'Water', '44 Lake Ln', 'Pleasant Valley', '12569', '(845)232-32422');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p020', 'Elizabeth', 'Sager', '57 Brown Rd', 'Wappengers Falls', '12601', '(845)242-42522');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p021', 'Neil', 'Rosenfeild', '88 Uphill Hill', 'Pleasant Valley', '12569', '(845)252-2526');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p022', 'Ryan', 'Cripps', '101 Downhill Hill', 'LaGrange', '12603', '262-6272');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p023', 'James', 'Dean', '99 Dreamy Circle', 'Beacon', '12602', '(845)272-7282');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p024', 'Johnny', 'Depp', '42 Handsome Ln', 'Fishkill', '12602', '282-8292');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p025', 'Ryan', 'Reynolds', '70 Oreo Ct', 'Wappengers Falls', '12601', '(845)292-9303');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p026', 'Chris', 'McClain', '83 Cortland Ct', 'Beacon', '12602', '(845)303-0313');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p027', 'Blake', 'Shelton', '69 Country Hill', 'Poughkeepsie', '12603', '(845)313-1323');
INSERT INTO people(pid, fName, lName, address, city, zipcode, phoneNo )
	VALUES('p028', 'Maria', 'McCue', '91 Flowers Rd', 'Fishkill', '12602', '323-2333');
INSERT INTO people(pid, fname, lname, address, city, zipcode, phoneno)
	VALUES('p029', 'Frank', 'Geroge', '11 Test Ct', 'Poughkeepsie', 11111, '000-0000');

-- Jobs --
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j001','Vet',81460, '1 position, 1st shift, no wkend, on call');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j002','Nurse', 62500, '2 positions, 1st and 2nd shift, no wkend, on call');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j003','Receptionist', 25200, '1 position, 1st shift, no wkend');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j004','Child Care', 40000, '2 positions, 1st shift, no wkend');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j005','Animal Care', 40000, '6 positions, 3 shifts, wkend');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j006','Office', 35700, '1 position, 1st shift, no wkend');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j007','Maintenance', 40000, '1 position, 1st shift, no wkend, on call');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j008','Camp Counselor', 18080, '3 positions, 1st shift, no wkend');
INSERT INTO jobs(jobid,jobTitle, salary, jobDescrip)
	VALUES('j009','Volunteer', 0, 'Unlimited positions, all shifts, wkend');

-- Shifts --
INSERT INTO shift(sid, dayOfWeek, startTime, endTime, typeShift)
	VALUES('s001', 'Monday - Friday', '8:30 AM', '4:30 PM', 'Week First Shift');
INSERT INTO shift(sid, dayOfWeek, startTime, endTime, typeShift)
	VALUES('s002', 'Monday - Friday', '4:30 PM', '12:30 AM', 'Week Second Shift');
INSERT INTO shift(sid, dayOfWeek, startTime, endTime, typeShift)
	VALUES('s003', 'Monday - Friday', '12:30 AM', '8:30 AM', 'Week Third Shift');
INSERT INTO shift(sid, dayOfWeek, startTime, endTime, typeShift)
	VALUES('s004', 'Saturday - Sunday', '8:30 AM', '4:30 PM', 'Weekend First Shift');
INSERT INTO shift(sid, dayOfWeek, startTime, endTime, typeShift)
	VALUES('s005', 'Saturday - Sunday', '4:30 PM', '12:30 AM', 'Weekend Second Shift');
INSERT INTO shift(sid, dayOfWeek, startTime, endTime, typeShift)
	VALUES('s006', 'Saturday - Sunday', '12:30 AM', '8:30 AM', 'Weekend Third Shift');

-- Staff --
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p001', 'j001', '1-3-2013', '7-9-1985', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p003', 'j003', '2-6-2015', '8-1-1995', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p005', 'j004', '4-20-2014', '10-21-1986', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p006', 'j007', '8-15-2012', '6-14-1986', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p010', 'j008', '9-1-2013', '2-26-1993', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p012', 'j002', '2-22-2013', '3-13-1982', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p013', 'j002', '2-20-2013', '9-9-1981', 's002');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p015', 'j004', '3-18-2014', '10-29-1986', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p016', 'j005', '1-3-2013', '7-7-1989', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p017', 'j005', '1-2-2013', '1-2-1990', 's002');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p018', 'j005', '3-3-2012', '2-23-1986', 's003');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p019', 'j005', '12-3-2012', '3-1-1979', 's004');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p020', 'j006', '9-3-2012', '8-9-1992', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p021', 'j008', '9-3-2015', '7-9-1995', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p022', 'j008', '7-8-2014', '12-1-1994', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p023', 'j009', '1-3-2013', '8-30-1991', 's001');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p024', 'j009', '8-9-2012', '7-6-1997', 's002');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p025', 'j009', '1-29-2014', '8-9-1998', 's004');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p026', 'j009', '5-3-2016', '1-12-1990', 's004');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p027', 'j005', '12-3-2012', '6-12-1985', 's005');
INSERT INTO staff(pid, jobid, dateHired, dob, sid)
	VALUES('p028', 'j005', '10-20-2016', '10-29-1993', 's006');

-- Children --
INSERT INTO children(cid, cName, cGender, dob, pid, attendance)
	VALUES('c001', 'Sarah', 'F', '6-1-2005', 'p002', 'attending');
INSERT INTO children(cid, cName, cGender, dob, pid, attendance)
	VALUES('c002', 'Taylor', 'F', '8-14-2010', 'p002', 'attending');
INSERT INTO children(cid, cName, cGender, dob, pid)
	VALUES('c003', 'Peyton', 'F', '3-24-2012', 'p008');
INSERT INTO children(cid, cName, cGender, dob, pid, attendance)
	VALUES('c004', 'Joey', 'M', '7-15-2013', 'p009', 'attending');
INSERT INTO children(cid, cName, cGender, dob, pid)
	VALUES('c005', 'James', 'M', '7-1-2006', 'p007');
INSERT INTO children(cid, cName, cGender, dob, pid, attendance)
	VALUES('c006', 'Bond', 'M', '3-2-2010', 'p007', 'attending');

-- Animals --
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a001', 'dog', '3-17-2000', 'Oreo', 'p008', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a002', 'dog', '4-15-2006', 'Tater', 'p004', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a003', 'cat', '8-23-2010', 'Megladon', 'p009', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a004', 'rabbit', '9-20-2014', 'Georgey', 'p004', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a005', 'cat', '10-11-2012', 'Charles', 'p001', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a006', 'dog', '12-1-2013', 'Nana', 'p011', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, animalOwned, animalSheltered)
	VALUES('a007', 'cat', '1-1-2014', 'Mozzel', false, true);
INSERT INTO animals(aid, typeAnimal, dob, aName, pid, animalOwned, animalSheltered)
	VALUES('a008', 'dog', '7-24-2008', 'Ebony', 'p014', true, false);
INSERT INTO animals(aid, typeAnimal, dob, aName, animalOwned, animalSheltered)
	VALUES('a009', 'cat', '4-17-2009', 'Tabatha', false, true);
INSERT INTO animals(aid, typeAnimal, dob, aName, animalOwned, animalSheltered)
	VALUES('a010', 'dog', '3-9-2014', 'Scruffy', false, true);

-- Clients --
INSERT INTO clients(pid)
	VALUES('p002');
INSERT INTO clients(pid)
	VALUES('p008');
INSERT INTO clients(pid)
	VALUES('p009');
INSERT INTO clients(pid)
	VALUES('p007');
INSERT INTO clients(pid)
	VALUES('p004');
INSERT INTO clients(pid)
	VALUES('p001');
INSERT INTO clients(pid)
	VALUES('p011');
INSERT INTO clients(pid)
	VALUES('p014');
INSERT INTO clients(pid)
	VALUES('p029');

-- Admissions --
INSERT INTO admissions(aid, admDate, disDate)
	VALUES('a003', '2-15-2013', '2-27-2013');
INSERT INTO admissions(aid, admDate)
	VALUES('a002', '3-4-2016');
INSERT INTO admissions(aid, admDate)
	VALUES('a004', '3-4-2016');
INSERT INTO admissions(aid, admDate, disDate)
	VALUES('a001', '10-5-2014', '10-25-2014');
INSERT INTO admissions(aid, admDate, disDate)
	VALUES('a005', '12-20-2015', '12-28-2015');
INSERT INTO admissions(aid, admDate, disDate)
	VALUES('a006', '1-14-2016', '3-1-2016');
INSERT INTO admissions(aid, admDate)
	VALUES('a007', '2-28-2016');
INSERT INTO admissions(aid, admDate)
	VALUES('a008', '2-13-2016');
INSERT INTO admissions(aid, admDate)
	VALUES('a009', '3-13-2016');
INSERT INTO admissions(aid, admDate)
	VALUES('a010', '3-3-2016');

-- Adoptions --
INSERT INTO adoptions(aid, pid,adoptDate)
	VALUES('a006','p011', '3-1-2016');

-- Kennels --
INSERT INTO kennels(kid, aid)
	VALUES('k001','a002');
INSERT INTO kennels(kid, aid)
	VALUES('k002','a004');
INSERT INTO kennels(kid, aid)
	VALUES('k003','a007');
INSERT INTO kennels(kid, aid)
	VALUES('k004','a009');
INSERT INTO kennels(kid, aid)
	VALUES('k005','a010');
INSERT INTO kennels(kid, aid)
	VALUES('k006','a008');
INSERT INTO kennels(kid)
	VALUES('k007');
INSERT INTO kennels(kid)
	VALUES('k008');
INSERT INTO kennels(kid)
	VALUES('k009');
INSERT INTO kennels(kid)
	VALUES('k010');
INSERT INTO kennels(kid)
	VALUES('k011');
INSERT INTO kennels(kid)
	VALUES('k012');
INSERT INTO kennels(kid)
	VALUES('k013');
INSERT INTO kennels(kid)
	VALUES('k014');
INSERT INTO kennels(kid)
	VALUES('k015');

-- Sheltered Pets --
INSERT INTO shelteredPets(kid, aid)
	VALUES('k003','a007');
INSERT INTO shelteredPets(kid, aid)
	VALUES('k004','a009');
INSERT INTO shelteredPets(kid, aid)
	VALUES('k005','a010');

-- Kennel Pets --
INSERT INTO kennelPets(aid, kid, pid)
	VALUES('a002','k001', 'p004');
INSERT INTO kennelPets(aid, kid, pid)
	VALUES('a004','k002', 'p004');
INSERT INTO kennelPets(aid, kid, pid)
	VALUES('a008','k006', 'p014');

-- Medical --
INSERT INTO medical(aid, reason, dateOfMed, pid)
	VALUES('a003', 'sick', '2-18-2013', 'p009');
INSERT INTO medical(aid, reason, dateOfMed)
	VALUES('a006', 'check-up', '1-14-2016');
INSERT INTO medical(aid, reason, dateOfMed)
	VALUES('a007', 'check-up', '2-27-2016');
INSERT INTO medical(cid, reason, dateOfMed, pid)
	VALUES('c003', 'sick', '3-28-2012', 'p008');
INSERT INTO medical(cid, reason, dateOfMed, pid)
	VALUES('c006', 'cut', '3-10-2010', 'p007');
INSERT INTO medical(aid, reason, dateOfMed)
	VALUES('a009', 'check-up', '3-13-2016');
INSERT INTO medical(aid, reason, dateOfMed)
	VALUES('a010', 'check-up', '3-3-2016');

-- VIEWS --
--Schedule for week --
CREATE VIEW weeklySchedule AS
	SELECT dayofweek, starttime, endtime, jobtitle, fname, lname, phoneno
	FROM shift, jobs, people, staff
	WHERE shift.sid = staff.sid 
		AND jobs.jobid = staff.jobid 
		AND people.pid = staff.pid
	ORDER BY shift.sid, jobs.jobid;

-- Children present --
CREATE VIEW childrenPresent AS
	SELECT cname AS childsName,
		fname AS parentsFirtName, 
		lname as parentsLastName, 
		phoneno
	FROM children
	INNER JOIN people
		ON children.pid = people.pid
	WHERE attendance = 'attending'
	ORDER BY lname ASC;

-- Owned pets present --
CREATE VIEW ownedPetsPresent AS
	SELECT typeanimal, aname AS petName, 
			kid AS kennelNo, 
			fname AS ownerFirstName, 
			lname AS ownerLastName, 
			phoneno
	FROM animals
	INNER JOIN people
		ON people.pid = animals.pid
	INNER JOIN kennels
		ON animals.aid = kennels.aid
		WHERE animals.aid IN(SELECT aid
				FROM admissions
				WHERE disdate IS NULL)
	ORDER BY typeanimal ASC;

-- Orphaned pets presenet --
CREATE VIEW orphanedPetsPresent AS
	SELECT typeanimal, aname AS petName, kid AS kennelNo
	FROM animals, kennels, admissions
	WHERE animals.aid = kennels.aid
	  AND animals.aid = admissions.aid
	  AND animals.pid IS NULL
	  AND disdate IS NULL
	 ORDER BY typeanimal ASC;

-- REPORTS --
-- Monthly/Yearly Salaries --
SELECT jobtitle, fname AS employee_first_name, lname AS employee_last_name, 
	(salary/12) AS monthly_salary, salary AS yearly_salary
FROM jobs, people, staff
WHERE jobs.jobid = staff.jobid
  AND staff.pid = people.pid
GROUP BY jobtitle, people.fname, people.lname, jobs.salary
ORDER BY salary DESC;

-- Percent of Clients with animals --
SELECT TRUNC( 
	CAST(
		(SELECT COUNT(aid)
		  FROM animals
		 WHERE pid != '') AS DECIMAL(5,2))
		/
		(SELECT COUNT(pid)
		   FROM clients) 
	* 100) AS Percent_of_clients_with_animals;

-- Animals that have been in shelter for over a month --
SELECT aname AS animal_name, kid AS kennel, age(current_date, admDate) AS length_of_stay
FROM admissions
INNER JOIN animals 
	ON animals.aid = admissions.aid
INNER JOIN kennels
	ON kennels.aid = admissions.aid
WHERE date_part('month', age(current_date, admDate)) >= 1
  AND disDate IS NULL;

-- STORED PROCEDURES --
-- adopted_Pet() --
CREATE OR REPLACE FUNCTION adopted_pet() RETURNS trigger AS
$BODY$
BEGIN
	UPDATE admissions
	SET disdate = adoptdate
	FROM adoptions
	WHERE adoptions.aid = admissions.aid;

	UPDATE animals
	SET 
	   pid = adoptions.pid,
	   animalOwned = true,
	   animalSheltered = false
	FROM adoptions
	WHERE animals.aid = adoptions.aid;

	UPDATE kennels
	SET aid = NULL
	FROM adoptions
	WHERE kennels.aid = adoptions.aid;

	DELETE FROM shelteredPets using adoptions
	WHERE shelteredPets.aid = adoptions.aid;

	RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

--animals_Present()--
CREATE OR REPLACE FUNCTION animals_present(IN animaltype text)
RETURNS TABLE(kennel_id char(4), animal_name text, animal_type text, owner_fName text, owner_lName text, phoneNo text) AS
$BODY$
BEGIN
	RETURN QUERY SELECT kennels.kid, animals.aname, animals.typeanimal, people.fname, people.lname, people.phoneNo
			FROM kennels, animals LEFT OUTER JOIN people 
				ON animals.pid = people.pid
			WHERE animaltype = animals.typeanimal
			  AND kennels.aid = animals.aid
			ORDER BY kennels.kid ASC;
END;
$BODY$
LANGUAGE plpgsql;

--new_Animal()--
CREATE OR REPLACE FUNCTION new_animal() RETURNS trigger AS
$BODY$
DECLARE kidAssigned char(4) DEFAULT NULL;
BEGIN
	INSERT INTO admissions(aid, admdate)
		VALUES(new.aid, current_date);

	UPDATE kennels
	SET aid = new.aid
	FROM animals
	WHERE kid in (SELECT MIN(kid) 
		       FROM kennels 
		       WHERE aid IS NULL);
		       
	kidAssigned = (SELECT kid 
			FROM kennels 
			WHERE aid = new.aid);
			
	IF new.animalOwned = TRUE THEN
		INSERT INTO kennelPets(aid, kid, pid)
			VALUES(new.aid, kidAssigned, new.pid);
	END IF;

	IF new.animalSheltered = TRUE THEN
		INSERT INTO shelteredPets(kid, aid)
			VALUES(kidAssigned, new.aid);
		INSERT INTO medical(aid, reason, dateOfMed, pid)
			VALUES(new.aid, 'check-up', current_date, new.pid);
	END IF;

	RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

--discharge_Animal()--
CREATE OR REPLACE FUNCTION discharge_animal() RETURNS trigger AS
$BODY$
BEGIN
	DELETE FROM kennelPets
	WHERE kennelPets.aid = new.aid;

	UPDATE kennels
	SET aid = NULL
	WHERE kennels.aid = new.aid;	       

	RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

-- TRIGGERS --
--adopted_Pet Trigger--
CREATE TRIGGER adopted_pet
AFTER INSERT ON adoptions
FOR EACH ROW
EXECUTE PROCEDURE adopted_pet();

--new_Animal Trigger--
CREATE TRIGGER new_animal
AFTER INSERT ON animals
FOR EACH ROW
EXECUTE PROCEDURE new_animal();

--discharge_Animal Trigger--
CREATE TRIGGER discharge_animal
AFTER UPDATE ON admissions
FOR EACH ROW
EXECUTE PROCEDURE discharge_animal();

-- SECURITY --
-- DB Admin --
REVOKE ALL PRIVILEGES ON admissions FROM DB_admin;
REVOKE ALL PRIVILEGES ON animals FROM DB_admin;
REVOKE ALL PRIVILEGES ON children FROM DB_admin;
REVOKE ALL PRIVILEGES ON kennels FROM DB_admin;
REVOKE ALL PRIVILEGES ON people FROM DB_admin;
REVOKE ALL PRIVILEGES ON adoptions FROM DB_admin;
REVOKE ALL PRIVILEGES ON clients FROM DB_admin;
REVOKE ALL PRIVILEGES ON kennelPets FROM DB_admin;
REVOKE ALL PRIVILEGES ON shelteredPets FROM DB_admin;
REVOKE ALL PRIVILEGES ON jobs FROM DB_admin;
REVOKE ALL PRIVILEGES ON medical FROM DB_admin;
REVOKE ALL PRIVILEGES ON shift FROM DB_admin;
REVOKE ALL PRIVILEGES ON staff FROM DB_admin;

CREATE ROLE DB_admin;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC
TO DB_admin;

-- Medical Staff: Vets and Nurses --
REVOKE ALL PRIVILEGES ON animals FROM Medical_staff;
REVOKE ALL PRIVILEGES ON children FROM Medical_staff;
REVOKE ALL PRIVILEGES ON medical FROM Medical_staff;
REVOKE ALL PRIVILEGES ON people FROM Medical_staff;
REVOKE ALL PRIVILEGES ON kennels FROM Medical_staff;
REVOKE ALL PRIVILEGES ON admissions FROM Medical_staff;
REVOKE ALL PRIVILEGES ON kennelPets FROM Medical_staff;
REVOKE ALL PRIVILEGES ON shelteredPets FROM Medical_staff;

CREATE ROLE Medical_staff;
GRANT SELECT ON animals, children, medical,
		people, kennels, admissions,
		kennelPets, shelteredPets
TO Medical_staff;

GRANT UPDATE ON medical
TO Medical_staff;

GRANT INSERT ON medical
TO Medical_staff;

-- Office Staff: receptionist and office staff --
REVOKE ALL PRIVILEGES ON admissions FROM Office_staff;
REVOKE ALL PRIVILEGES ON animals FROM Office_staff;
REVOKE ALL PRIVILEGES ON children FROM Office_staff;
REVOKE ALL PRIVILEGES ON kennels FROM Office_staff;
REVOKE ALL PRIVILEGES ON people FROM Office_staff;
REVOKE ALL PRIVILEGES ON adoptions FROM Office_staff;
REVOKE ALL PRIVILEGES ON clients FROM Office_staff;
REVOKE ALL PRIVILEGES ON kennelPets FROM Office_staff;
REVOKE ALL PRIVILEGES ON shelteredPets FROM Office_staff;
REVOKE ALL PRIVILEGES ON jobs FROM Office_staff;
REVOKE ALL PRIVILEGES ON medical FROM Office_staff;
REVOKE ALL PRIVILEGES ON shift FROM Office_staff;
REVOKE ALL PRIVILEGES ON staff FROM Office_staff;

CREATE ROLE Office_staff;
GRANT SELECT ON ALL TABLES
IN SCHEMA PUBLIC
TO Office_staff;

GRANT UPDATE ON admissions, animals, children,
		kennels, people
TO Office_staff;

GRANT INSERT ON admissions, adoptions, animals,
		children, clients, kennelPets,
		shelteredPets, people
TO Office_staff;

GRANT DELETE ON shelteredPets, kennelPets
TO Office_staff;

-- Child Care: child care and camp counselors --
REVOKE ALL PRIVILEGES ON children FROM Child_care;
REVOKE ALL PRIVILEGES ON people FROM Child_care;
REVOKE ALL PRIVILEGES ON medical FROM Child_care;
REVOKE ALL PRIVILEGES ON clients FROM Child_care;

CREATE ROLE Child_care;
GRANT SELECT ON children, people,
		medical, clients
TO Child_care;

-- Animal Care: animcal care and maintenance crew --
REVOKE ALL PRIVILEGES ON admissions FROM Animal_care;
REVOKE ALL PRIVILEGES ON animals FROM Animal_care;
REVOKE ALL PRIVILEGES ON clients FROM Animal_care;
REVOKE ALL PRIVILEGES ON kennelPets FROM Animal_care;
REVOKE ALL PRIVILEGES ON shelteredPets FROM Animal_care;
REVOKE ALL PRIVILEGES ON kennels FROM Animal_care;
REVOKE ALL PRIVILEGES ON medical FROM Animal_care;
REVOKE ALL PRIVILEGES ON people FROM Animal_care;

CREATE ROLE Animal_care;
GRANT SELECT ON admissions, animals, clients,
		kennelPets, shelteredPets,
		kennels, medical, people
TO Animal_care;