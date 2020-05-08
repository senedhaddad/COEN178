-- Create table EmpStats (title VARCHAR(20) Primary KEY,empcount INTEGER, lastModified DATE); 
/* Complete the function and run it. */
CREATE OR REPLACE FUNCTION countByTitle (p_title IN AlphaCoEmp.title%TYPE)
RETURN NUMBER IS 
	l_cnt INTEGER; 
BEGIN
	SELECT COUNT(*) INTO l_cnt FROM AlphaCoEmp
		GROUP BY title
		HAVING LOWER(title) = LOWER(p_title);
	RETURN l_cnt;
END;
/
SHOW ERRORS;

/* c */
/* select countByTitle('director') from Dual; */
/* select countByTitle('advisor') from Dual; */
