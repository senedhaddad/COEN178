/* Part 2 */

/* Excercise 7 */
SELECT deptid as deptno, count(*) as empcount FROM L_EMP GROUP BY deptid ORDER BY (deptid) ASC;

/* Excercise 8 */
Select deptno,deptname,empcount from (SELECT deptid as deptno, count(*) as empcount FROM L_EMP GROUP BY deptid),L_DEPT where deptno = L_DEPT.deptid ORDER BY (empcount) ASC;

/* Excercise 9 */
/* Approach 1 did not work */

/* Approach 2 
It was not comparing correctly, but after making changes, Dept 1 has the maximum number of employees. */
Select deptid from L_EMP Group by deptid Having count(*) >= ALL(Select count(*) from L_EMP Group by deptid);

/* Excercise 10 */
/*a*/
Select * from L_EMP NATURAL JOIN L_DEPT;
/*b*/
Select * from L_EMP, L_DEPT WHERE L_EMP.deptid = L_DEPT.deptid;
