/* 1 */

CREATE or REPLACE TRIGGER display_customer_trig
   AFTER  INSERT on BankCust_6
   FOR EACH ROW	
BEGIN    
	DBMS_OUTPUT.PUT_LINE('From Trigger '||'Customer NO: '||:new.custno||' Customer Name: '||:new.custname);
END;
/
show errors;

insert into BANKCUST_6 values('c1','Smith','32 Lincoln st','SJ');
insert into BANKCUST_6 values('c2','Jones','44 Benton st','SJ');
insert into BANKCUST_6 values('c3','Peters','12 palm st','SFO');
insert into BANKCUST_6 values('c20','Chen','20 san felipo','LA');
insert into BANKCUST_6 values('c33','Williams',' 11 cherry Ave','SFO'); */


/* 2 */

Create Or Replace Trigger Acct_Cust_Trig
AFTER INSERT ON Accounts_6
FOR EACH ROW	
BEGIN	
	update totals_6
	set totalAmount = totalAmount + :new.amount
	where custno = :new.custno;	
insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno= :new.custno));							
END;
/
/*
insert into ACCOUNTS_6 values('a1523','checking',2000.00,'c1');
insert into ACCOUNTS_6 values('a2134','saving',5000.00,'c1');
insert into ACCOUNTS_6 values('a4378','checking',1000.00,'c2');
insert into ACCOUNTS_6 values('a5363','saving',8000.00,'c2');
insert into ACCOUNTS_6 values('a7236','checking',500.00,'c33');
insert into ACCOUNTS_6 values('a8577','checking',150.00,'c20');*/

/* 3 */

/* update Accounts_6
set amount = 1000
where accountno = 'a1523'; */

/* 4 */
Create Or Replace Trigger Acct_Cust_Trig
AFTER INSERT OR UPDATE ON Accounts_6
FOR EACH ROW	
BEGIN	
	If inserting then
		update totals_6
		set totalAmount = totalAmount + :new.amount
		where custno = :new.custno;	
		
		insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno= :new.custno));
	END IF;
	if updating then
	-- If we are updating we want to correctly set the totalAmount 
	--	to the new amount that may be >= or < old amount
	--	Complete the query */ 
		
		update totals_6
		set totalAmount = totalAmount + :new.amount - :old.amount
		where custno = :new.custno;
	end if; 
END;
/
Show Errors;

/* DELETE FROM Accounts_6;
DELETE FROM Totals_6;

/* 5 */
Create Or Replace Trigger NoUpdatePK_trig
After UPDATE ON BANKCUST_6
For each row
BEGIN
 if updating ('custno')  then
	raise_application_error (-20999,'Cannot update a Primary Key');	
	End if;
END;
/
show errors;

/* UPDATE BANKCUST_6
Set custno=’c99’
Where custno=’c1’;
*/
