use homework_17


----- You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
----Assume there is at least one sale for each region


CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

select * from #RegionSales
 with cte as (
 select distinct region from #RegionSales as r1) , cte2 as (
 select distinct Distributor from #RegionSales as r2) 
 select cte.region, cte2.Distributor, isnull(sales,0) as sales from cte cross join cte2 
 left join #RegionSales as r3 on cte.region=r3.Region and cte2.Distributor=r3.Distributor

 ----Find managers with at least five direct reports

 CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select e1.name from Employee e1 join Employee e2 on e1.id=e2.managerid
group by e1.id, e1.name 
having count(*)>=5


-----Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select products.product_name,sum(unit) from orders join products on orders.product_id=Products.product_id
where year(order_date)=2020 and month(order_date)=2
group by products.product_name
having sum(unit)>=100


----Write an SQL statement that returns the vendor from which each customer has placed the most orders

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

with
cte as (select customerid,vendor,sum(count) as total from orders
group by  customerid,vendor),
cte2 as (select customerid,vendor,sum(count) as total from orders
group by  customerid,vendor),
cte3 as (
select customerid,max(total) as total2 from cte group by customerid)
select* from cte2 join cte3 on cte2.CustomerID=cte3.CustomerID and cte3.total2=cte2.total

----- You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

DECLARE @Check_Prime INT = 91
DECLARE @Divisor INT = 2
DECLARE @IsPrime VARCHAR(20) = 'Yes'
IF @Check_Prime < 2
BEGIN
    SELECT 'This number is not prime' AS Result;
    RETURN;
END
WHILE @Divisor <= FLOOR(SQRT(@Check_Prime))
BEGIN
    IF @Check_Prime % @Divisor = 0
    BEGIN
        SET @IsPrime = 'No';
        BREAK;
    END
    SET @Divisor = @Divisor + 1;
END
IF @IsPrime = 'Yes'
    SELECT 'This number is prime' AS Result;
ELSE
    SELECT 'This number is not prime' AS Result

----Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');


WITH DeviceCounts AS (
    SELECT
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
MaxSignals AS (
    SELECT
        Device_id,
        MAX(SignalCount) AS MaxSignalCount
    FROM DeviceCounts
    GROUP BY Device_id
),
LocationsWithMaxSignals AS (
    SELECT
        dc.Device_id,
        dc.Locations,
        dc.SignalCount
    FROM DeviceCounts dc
    JOIN MaxSignals ms
        ON dc.Device_id = ms.Device_id AND dc.SignalCount = ms.MaxSignalCount
),
LocationCount AS (
    SELECT
        Device_id,
        COUNT(DISTINCT Locations) AS NumLocations
    FROM LocationsWithMaxSignals
    GROUP BY Device_id
)
SELECT
    lwms.Device_id,
    lc.NumLocations,
    SUM(dc.SignalCount) AS TotalSignals
FROM LocationsWithMaxSignals lwms
JOIN LocationCount lc ON lwms.Device_id = lc.Device_id
JOIN DeviceCounts dc ON lwms.Device_id = dc.Device_id AND lwms.Locations = dc.Locations
GROUP BY lwms.Device_id, lc.NumLocations;


----Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);


select empid,empname,salary from Employee e1 
where salary>( select avg(salary) from Employee e2
where e2.deptid=e1.deptid)


----You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
CREATE TABLE Numbers (
    Number INT
);
 Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);

CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);



with cte as ( select case when count(*)=3 then 100 else 10 end as prize
from tickets t join numbers n on t.number=n.number
group by ticketid)
select sum(prize) from cte

----The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
---Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.


CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

WITH UserPlatforms AS (SELECT User_id,Spend_date,
COUNT(DISTINCT Platform) AS PlatformCount
FROM Spending
GROUP BY User_id, Spend_date),UserAmounts AS (SELECT s.Spend_date, s.User_id,SUM(s.Amount) AS TotalAmount
FROM Spending s
GROUP BY s.Spend_date, s.User_id)
SELECT up.Spend_date,
    COUNT(CASE WHEN up.PlatformCount = 1 AND s.Platform = 'Mobile' THEN up.User_id END) AS Mobile_Only_Users,
    COUNT(CASE WHEN up.PlatformCount = 1 AND s.Platform = 'Desktop' THEN up.User_id END) AS Desktop_Only_Users,
    COUNT(CASE WHEN up.PlatformCount = 2 THEN up.User_id END) AS Both_Devices,
    SUM(CASE WHEN up.PlatformCount = 1 AND s.Platform = 'Mobile' THEN s.Amount END) AS Mobile_Only_Spend,
    SUM(CASE WHEN up.PlatformCount = 1 AND s.Platform = 'Desktop' THEN s.Amount END) AS Desktop_Only_Spend,
    SUM(CASE WHEN up.PlatformCount = 2 THEN s.Amount END) AS Both_Spend
FROM UserPlatforms up JOIN Spending s ON up.User_id = s.User_id AND up.Spend_date = s.Spend_date
GROUP BY up.Spend_date
ORDER BY up.Spend_date


---- Write an SQL Statement to de-group the following data.

CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);


WITH  Numbers AS (SELECT 1 AS n
UNION ALL
SELECT n + 1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped))
SELECT g.Product, n AS Quantity_Unit FROM Grouped g JOIN Numbers ON n <= g.Quantity
ORDER BY g.Product, n;
