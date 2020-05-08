/* Part 1 */

/* Question 1 */

CREATE TABLE AlphaCoEmp(Name VARCHAR(25) Primary Key, Title VARCHAR(20) DEFAULT NULL, Salary Number(10,2) DEFAULT 0);

INSERT INTO AlphaCoEmp (name) SELECT DISTINCT last from Staff_2010;

/* Question 2 */

Create Table Emp_Work(name VARCHAR(25) Primary Key, Project VARCHAR(20) default NULL, Constraint FK_AlphaCo Foreign Key (name) REFERENCES AlphaCoEmp(name));

insert into Emp_Work(name) Select Name from AlphaCoEmp where REGEXP_LIKE(name,'(^[ags])','i');

Select Name from AlphaCoEmp where REGEXP_LIKE(name,'(^[ags])','i');

Delete from AlphaCoEmp Where name=’Smith’;

/* Question 3 */

Alter table Emp_Work drop constraint FK_AlphaCo;

Alter table Emp_Work add constraint FK_AlphaCo FOREIGN KEY (name) references AlphaCoEmp(name) on delete cascade;

Select Name from Emp_Work;

star/* Part 2 */

/* Question 4 */

Set SERVEROUTPUT ON

Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
	DBMS_OUTPUT.put_line('Hello '||message);

END;
/
Show Errors;

exec DisplayMessage('Sened');

/* Question 5 */

Select ROUND(DBMS_RANDOM.value (10,100)) from DUAL;

Create or Replace Procedure setSalaries(low in INTEGER, high in INTEGER)
As
Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	-- Local variables
	l_emprec Emp_cur%rowtype;
	
	l_salary AlphaCoEmp.salary%type;
BEGIN
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = l_emprec.name;
		 
   END LOOP;
   commit;
END;
/
show errors;

/* Question 6 */

Select name from AlphaCoEmp Where salary >= 80000 and salary <= 100000;

/* Question 7 */

Create or Replace Procedure setEmpSalary(p_name in VARCHAR, low in INTEGER, high in INTEGER)
As
Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	-- Local variables
	l_emprec Emp_cur%rowtype;
	
	l_salary AlphaCoEmp.salary%type;
BEGIN
	for l_emprec IN Emp_cur
	loop
		 l_salary := ROUND(dbms_random.value(low,high));
		
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = p_name;
		 
   END LOOP;
   commit;
END;
/
show errors;


/* Question 8 */

Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR) Return NUMBER IS l_salary NUMBER(10,2);
BEGIN
	Select salary into l_salary
	from AlphaCoEmp
	where name = p_name;
			 
   	return l_salary;
END;
/
show errors;

select getEmpSalary('Wilson') from Dual;
