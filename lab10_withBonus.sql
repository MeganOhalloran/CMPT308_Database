--Megan O'Halloran
--Lab 10: The Sadest Lab Ever Because It's The Last Lab, Lab
--With optional challenege 
--April 13, 2016

--#1 function PreReqsFor(courseNum): Returns the immediate prerequisites for the passed-in course number.
CREATE OR REPLACE FUNCTION PreReqsFor(IN inCourseNum int) 
RETURNS TABLE(Prerequisite_Course_Number int, Prerequisite_Course_Name text) AS 
$$
BEGIN
   RETURN QUERY 
	   SELECT num, name
	   FROM Courses
	   WHERE num IN (SELECT prereqNum
			  FROM Prerequisites
			  WHERE Prerequisites.courseNum = inCourseNum)
	   ORDER BY num ASC;
END;
$$ 
LANGUAGE plpgsql;

--#2 function IsPreReqFor(courseNum): Returns the courses for which the passed-in course number	is an immediate	pre-requisite.
CREATE OR REPLACE FUNCTION IsPreReqFor(IN inPrereqNum int) 
RETURNS TABLE(Course_Number int, Course_Name text) AS 
$$
BEGIN
   RETURN QUERY 
	   SELECT num, name
	   FROM Courses
	   WHERE num IN (SELECT courseNum
			  FROM Prerequisites
			  WHERE prereqNum = inPrereqNum)
	   ORDER BY num ASC;
END;
$$ 
LANGUAGE plpgsql;

--Optional Challenge: Demonstrate Jedi-level skills and	write a	third, recursive, function that	takes a	passed-in
--course number	and generates all of its prerequisites.	Uses the first two functions you wrote and recursion.
CREATE OR REPLACE FUNCTION allPreReqsFor(IN inCourseNum int)
RETURNS TABLE(course_Number int) AS 
$$
BEGIN
	RETURN QUERY
	   WITH RECURSIVE allPreReqFor(inCourseNum) AS(
		SELECT num
		FROM Courses
		WHERE num IN (SELECT prereqNum
			      FROM Prerequisites
			      WHERE Prerequisites.courseNum = inCourseNum)
		UNION
		SELECT c.num
		FROM allPreReqFor pr, courses c
		WHERE c.num IN (SELECT prereqNum
				FROM Prerequisites
				WHERE Prerequisites.courseNum = pr.inCourseNum)

	) SELECT allPreReqFor.inCourseNum FROM allPreReqFor;
END;
$$ 
LANGUAGE plpgsql;