create database homework_16
use homework_16

---Create a numbers table using a recursive query from 1 to 1000.

CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)


with numbers as (select 1 as num
union all
select  num +1 from numbers where num<1000)
select num  from  numbers


----Write a query to find the total sales per employee using a derived table.(Sales, Employees)

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

select e.employeeid,e.firstname,s.SalesAmount from Employees e join (select Employeeid , sum(salesamount)  as total_sales 
from sales group by EmployeeID) s on e.EmployeeID=s.EmployeeID


----Create a CTE to find the average salary of employees.(Employees)
with employeestats as (select avg(salary) as avg_salary from employees) select avg_salary from employeestats

----Write a query using a derived table to find the highest sales for each product.(Sales, Products)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);

select p.productid, p.ProductName, s.max_sales_amount from products p join  (select productid, max(SalesAmount)
as max_sales_amount from sales 
group by productid) s on p.productid=s.productid

----Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
WITH  DoubleSequence AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM DoubleSequence
    WHERE num * 2 < 1000000
)
SELECT num FROM DoubleSequence

---Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with salescount as ( select Employeeid, count(*) as total_sales from sales 
group by EmployeeID) select e.firstname from Employees e join salescount sc on e.EmployeeID=sc.employeeid
where sc.total_sales>5


----Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

with productsales as (select productid,sum(salesamount) as total_sales from sales 
group by ProductID) select p.productname  from products p join productsales ps
on p.ProductID=ps.ProductID
where ps.total_sales>500


-----Create a CTE to find employees with salaries above the average salary.(Employees)

with average_salary as (select avg(salary) as avg_salary from Employees) select Employeeid,firstname,salary 
from Employees 
where Salary>(select avg_salary from average_salary)

----Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select top 5 
e.employeeid,e.firstname, orderstats.order_count from Employees e join (select employeeid, count(*) as order_count from sales
group by EmployeeID) as orderstats on e.EmployeeID=orderstats.EmployeeID
order by orderstats.order_count desc

----Write a query using a derived table to find the sales per product category.(Sales, Products)

select p.categoryid, sum(s.salesamount) as total_sales from Products p join (select PRODUCTid ,salesamount from sales) 
as s on p.ProductID=s.ProductID
group by p.CategoryID

---Write a script to return the factorial of each value next to it.(Numbers1)

	WITH  FactorialCTE AS (
    SELECT number, 1 AS factorial
    FROM Numbers1
    WHERE number = 0
    UNION ALL
    SELECT n.number, f.factorial * (n.number) AS factorial
    FROM Numbers1 n
    JOIN FactorialCTE f ON n.number = f.number + 1
    WHERE n.number > 0)
SELECT number, factorial
FROM FactorialCTE
ORDER BY number


---This script uses recursion to split a string into rows of substrings for each character in the string.(Example)


CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL SELECT n + 1 FROM Numbers WHERE n < 30)
SELECT e.Id,e.String,n.n AS Position,
SUBSTRING(e.String, n, 1) AS Character
FROM Example e JOIN Numbers n ON n.n <= LEN(e.String)
ORDER BY e.Id, n.n
OPTION (MAXRECURSION 0)

----Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH SalesWithLag AS (SELECT
DATEPART(YEAR, SaleDate) AS Year,
DATEPART(MONTH, SaleDate) AS Month,
SUM(SalesAmount) AS TotalSales,
LAG(SUM(SalesAmount)) OVER (ORDER BY DATEPART(YEAR, SaleDate), DATEPART(MONTH, SaleDate)) AS PrevMonthSales
FROM Sales
GROUP BY
DATEPART(YEAR, SaleDate),
DATEPART(MONTH, SaleDate))
SELECT Year,Month,TotalSales AS CurrentMonthSales,ISNULL(PrevMonthSales, 0) AS PreviousMonthSales,
TotalSales - ISNULL(PrevMonthSales, 0) AS SalesDifference
FROM SalesWithLag
ORDER BY Year, Month

---Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT e.EmployeeID,e.firstname, q.Quarter, q.Year,q.TotalSales FROM Employees e
JOIN (SELECT s.EmployeeID,
DATEPART(YEAR, s.SaleDate) AS Year,
DATEPART(QUARTER, s.SaleDate) AS Quarter,
SUM(s.SalesAmount) AS TotalSales FROM Sales s
GROUP BY s.EmployeeID,
DATEPART(YEAR, s.SaleDate),
DATEPART(QUARTER, s.SaleDate)
HAVING SUM(s.SalesAmount) > 45000) q ON e.EmployeeID = q.EmployeeID
ORDER BY e.EmployeeID, q.Year, q.Quarter


----This script uses recursion to calculate Fibonacci numbers

WITH Fibonacci AS (
    SELECT 0 AS n, 0 AS FibNumber
    UNION ALL
    SELECT 1, 1
    UNION ALL
    SELECT n + 1, FibNumber + LAG(FibNumber) OVER (ORDER BY n)
    FROM Fibonacci
    WHERE n < 10)
SELECT n, FibNumber
FROM Fibonacci
OPTION (MAXRECURSION 0)


----Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')


SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL AND LEN(Vals) > 1 AND Vals NOT LIKE '%[^' + LEFT(Vals, 1) + ']%'
    
-----Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)

with NumberSequence as (select 1 as num, cast('1' as varchar(MAX)) as sequence
union all
select num + 1, sequence + cast(num + 1 as varchar) from NumberSequence
where num < 5)
select sequence
from NumberSequence
order by num

----Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

SELECT e.EmployeeID, e.FirstName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(month, -6, GETDATE())
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT SUM(SalesAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(month, -6, GETDATE())
        GROUP BY EmployeeID
    ) sub)

----Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)


CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )


WITH DigitCounts AS (SELECT PawanName,digit,COUNT(*) AS cnt FROM RemoveDuplicateIntsFromNames
CROSS APPLY (SELECT SUBSTRING(Pawan_slug_name, number, 1) AS digit FROM master..spt_values
WHERE type='P' AND number BETWEEN 1 AND LEN(Pawan_slug_name)
AND SUBSTRING(Pawan_slug_name, number, 1) LIKE '[0-9]') AS Digits
GROUP BY PawanName, digit),
DigitsToRemove AS (SELECT DISTINCT PawanName, digit FROM DigitCounts
WHERE cnt = 1)
SELECT r.PawanName,(SELECT STRING_AGG(d, '') WITHIN GROUP (ORDER BY pos)FROM (
SELECT SUBSTRING(Pawan_slug_name, number, 1) AS d,number AS pos
FROM master..spt_values WHERE type='P' AND number BETWEEN 1 AND LEN(Pawan_slug_name)) AS AllChars
WHERE NOT (d LIKE '[0-9]' AND EXISTS (SELECT 1 FROM DigitsToRemove d2
WHERE d2.PawanName = r.PawanName AND d2.digit = d))) AS CleanedString
FROM RemoveDuplicateIntsFromNames r