/* Part 1 */

/* Excercise 1 */
select first, last, salary from Staff_2010 where salary >= all(select salary from Staff_2010);

select first, last, salary from Staff_2010 where salary = (select max(salary) from Staff_2010);

/* Excercise 2 */
/*a) It did not work for “Young” because there are two people with the last name “Young,” but once I fixed the query to run, it outputs the last names that have the same salary as either of the Young's. */
Select last, salary from Staff_2010 where salary = (select salary from Staff_2010 where UPPER(last) LIKE UPPER('%Zichal%'));

/*b*/
Select last, salary from Staff_2010 where salary = ANY(select distinct salary from Staff_2010 where UPPER(last) LIKE UPPER('Young'));

/* Excercise 3 */
select count(salary) as Salaries_above_100K from Staff_2010 where salary > 100000;

/* Excercise 4 */
select salary, count(salary) as COUNT_OF_THIS_SALARY from Staff_2010 where salary > 100000 group by salary order by salary;

/* Excercise 5 */
select salary, count(salary) from Staff_2010 where salary > 100000 group by salary HAVING count(salary) >= 10;

/* Excercise 6 */
/* The ‘i’ is to perform a case insensitive command. */
SELECT last FROM Staff_2010 WHERE REGEXP_LIKE (last, '([aeiou])\1', 'i');


/* DO WHEN SPOOL ON */

/* Creating tables 
Create table L_EMP (empNo Integer Primary Key, empname CHAR(10),deptId CHAR(5));
Create table L_DEPT (deptId CHAR(5) Primary Key, deptname CHAR(10));

/* Inserting tuples *
insert into L_EMP values(1,'smith','d1');
insert into L_EMP values(2,'jones','d2');
insert into L_EMP values(3,'wayne','d1');
insert into L_EMP values(4,'moor','d3');
insert into L_EMP values(5,'king','d1');
insert into L_EMP values(6,'chen','d1');
insert into L_EMP values(7,'winger','d3');
insert into L_DEPT values('d1','Research');
insert into L_DEPT values('d2','Devt');
insert into L_DEPT values('d3','Testing');
insert into L_DEPT values('d4','Advert');*/

