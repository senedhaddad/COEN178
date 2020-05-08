-- 1

Create table ItemOrder (orderNo VARCHAR(5) Primary key, qty Integer);

CREATE OR REPLACE TRIGGER ItemOrder_after_insert_trig
AFTER INSERT
   ON ItemOrder
   FOR EACH ROW

DECLARE
   v_quantity Integer;

BEGIN
   SELECT qty
   INTO v_quantity
   FROM ItemOrder
   WHERE orderNo = 'o1';

END;
/
Show Errors;

Insert into ItemOrder values ('o1',100);

-- 2

CREATE TABLE Course
(
    courseNo   INTEGER PRIMARY KEY,
    courseName VARCHAR(20)
);

CREATE TABLE Course_Prereq
(
    courseNo   INTEGER ,
    prereqNo Integer,
	Foreign Key(prereqNo) references Course (courseNo)
);

insert into Course values (10,'C++');
insert into Course values (11,'Java');
insert into Course values (12,'Python');
insert into Course values (121,'Web');
insert into Course values (133,'Software Eng');


CREATE OR REPLACE TRIGGER LimitTest
    BEFORE INSERT OR UPDATE ON Course_Prereq
    FOR EACH ROW  -- A row level trigger
DECLARE
     v_MAX_PREREQS CONSTANT INTEGER := 2;
     v_CurNum INTEGER;	
BEGIN
	BEGIN
		SELECT COUNT(*) INTO v_CurNum FROM Course_Prereq 
		WHERE courseNo = :new.CourseNo Group by courseNo;
		EXCEPTION
-- Before you enter the first row, no data is found
			WHEN no_data_found THEN
                 DBMS_OUTPUT.put_line('not found');
				 v_CurNum := 0;
	END;	
	if v_curNum > 0 THEN
		IF v_CurNum + 1 > v_MAX_PREREQS THEN
			RAISE_APPLICATION_ERROR(-20000,'Only 2 prereqs for course');
		END IF;
	END IF;	
END;
/
SHOW ERRORS;

insert into Course_Prereq values (121,11);

insert into Course_Prereq values (121,10);

insert into Course_Prereq values (121,12);


-- 3

CREATE OR REPLACE TRIGGER LimitTest
FOR INSERT
ON Course_Prereq
COMPOUND TRIGGER

 --/* Declaration Section*/
v_MAX_PREREQS CONSTANT INTEGER := 2;
     v_CurNum INTEGER := 1;	
	 v_cno INTEGER;

 --ROW level
BEFORE EACH ROW IS
BEGIN
	v_cno := :NEW.COURSENO;
END BEFORE EACH ROW;

 --Statement level
AFTER STATEMENT IS
BEGIN
SELECT COUNT(*) INTO v_CurNum FROM Course_Prereq 
		WHERE courseNo = v_cno Group by courseNo;
		
		IF v_CurNum  > v_MAX_PREREQS THEN
			RAISE_APPLICATION_ERROR(-20000,'Only 2 prereqs for course');
		END IF;
END AFTER STATEMENT;

 END ;
/

SHOW ERRORS;


-- 4

-- @report.sql


-- 5

CREATE TABLE Expenses(expenseDate date PRIMARY KEY, groceries Number(10,2),entertainment Number(10,2),rent Number(10,2));

-- Changing the headings
COLUMN expenseDate HEADING 'Date';
COLUMN groceries HEADING 'Groceries';
COLUMN entertainment HEADING 'Entertainment';
COLUMN rent HEADING 'Rent';
SELECT * FROM Expenses;

-- Adding a title to the top in the center
TTITLE CENTER -
"ACME SALES DEPARTMENT PERSONNEL REPORT";

-- Setting underline to =
SET UNDERLINE =
/;

-- Adding $ to Rent
COLUMN Groceries FORMAT $99999990.00;
COLUMN Entertainment FORMAT $99,990.00;
COLUMN Rent FORMAT $99,990.00;

-- For every row in the output table add an extra space
BREAK ON Groceries SKIP 1 ON REPORT;

-- Average, Max, Total
COMPUTE AVG SUM MAX OF Groceries ON REPORT;
COMPUTE AVG SUM MAX OF Entertainment ON REPORT;
COMPUTE AVG SUM MAX OF Rent ON REPORT;
Select * FROM Expenses;
