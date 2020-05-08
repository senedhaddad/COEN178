/* 2A */
SELECT CustID, First || Last as FullName, City FROM Customer;

/* 2B */
SELECT * FROM Customer ORDER BY Last ASC;

/* 2C */
SELECT * FROM Schedule ORDER BY CustID ASC, ServiceID DESC;

/* 2D */
/*SELECT ServiceID FROM DeliveryService WHERE */
SELECT ServiceID FROM DeliveryService
MINUS
SELECT ServiceID FROM Schedule;

/* 2E */
/* The given query will not work because there is no variable named 'Name' and it has no way to access data from multiple tables given its format. I changed the query to the follwing. The only result is John. */
SELECT First FROM Customer FULL OUTER JOIN Schedule ON Customer.CustID = Schedule.CustID WHERE Day = 'M';


/* 2F */
/* You can find the data in DeliveryService and Schedule tables, but the Schedule table has a reference to the Customer table to print out the last names. */
SELECT Last FROM Customer LEFT JOIN Schedule ON Customer.CustID = Schedule.CustID WHERE ServiceID IS NOT NULL;


/* 2G */
SELECT MAX(ServiceFee) AS Highest_ServiceFee FROM DeliveryService;

/* 2H */
SELECT COUNT(ServiceID), Day FROM Schedule GROUP BY Day;

/* 2I */
/* It wouldn't work by given the way it was */
SELECT DISTINCT A.custid,B.custid,A.city from Customer A INNER JOIN Customer B ON A.city = B.city;

/* 2J */
SELECT DISTINCT First, Last FROM Customer
INNER JOIN Schedule ON Customer.CustID = Schedule.CustID
INNER JOIN DeliveryService ON Schedule.ServiceID = DeliveryService.ServiceID
WHERE Customer.city = DeliveryService.location;

/* 2K */
SELECT MIN(Salary) AS MinimumSalary, MAX(Salary) AS MaximumSalary FROM Staff_2010;
