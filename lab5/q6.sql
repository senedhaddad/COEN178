CREATE OR REPLACE TRIGGER countchange_trig
AFTER INSERT OR DELETE ON AlphaCoEmp
FOR EACH ROW 
BEGIN 
	IF DELETING THEN 
		UPDATE EmpStats
		SET empcount = empcount-1, lastmodified = SYSDATE
		WHERE title = :old.title;
	ELSIF INSERTING THEN
		UPDATE empstats
		SET empcount = empcount + 1, lastmodified = SYSDATE
		WHERE title = :new.title;
	END IF;
END; 
/ 
SHOW ERRORS;
