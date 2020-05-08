CREATE or REPLACE procedure saveCountByTitle 
AS 
	l_advisor_cnt integer := 0;
	CURSOR emp_cur IS SELECT DISTINCT title FROM AlphaCoEmp;
	l_title AlphaCoEmp.title%TYPE;
BEGIN 
	l_advisor_cnt := countByTitle('advisor');

	delete from EmpStats; -- Any previously loaded data is deleted 
	-- /* inserting count of employees with title, ‘advisor’. */
	FOR l_emp IN emp_cur
	LOOP
		l_title := l_emp.title;
		DBMS_OUTPUT.PUT_LINE(l_title);
		l_advisor_cnt := countByTitle(l_title);
		insert into EmpStats values ('advisor',l_advisor_cnt,SYSDATE); 
	END LOOP;
END; 
/ 
Show errors;

/* Select statement */
/* SELECT * FROM EMPSTATS; */
