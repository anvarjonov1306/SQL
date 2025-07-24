create database homework_20
use homework_20


----- Find customers who purchased at least one item in March 2024 using EXISTS


CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

SELECT DISTINCT CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales
    WHERE CustomerName = s.CustomerName
    AND SaleDate BETWEEN '2024-03-01' AND '2024-03-31'
);

----Find the product with the highest total sales revenue using a subquery.

SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;

--- Find the second highest sale amount using a subquery

SELECT MAX(SaleAmount) AS SecondHighestSaleAmount
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
    WHERE Quantity * Price < (
        SELECT MAX(Quantity * Price) FROM #Sales
    )
) AS Subquery;


-----Find the total quantity of products sold per month using a subquery

SELECT 
    YEAR(SaleDate) AS SaleYear,
    MONTH(SaleDate) AS SaleMonth,
    SUM(Quantity) AS TotalQuantitySold
FROM #Sales
GROUP BY YEAR(SaleDate), MONTH(SaleDate)
ORDER BY SaleYear, SaleMonth;


----Find customers who bought same products as another customer using EXISTS

SELECT DISTINCT S1.CustomerName
FROM #Sales S1
WHERE EXISTS (
    SELECT 1
    FROM #Sales S2
    WHERE S1.CustomerName != S2.CustomerName
    AND S1.Product = S2.Product
);

---- Return how many fruits does each person have in individual fruit level

create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')

SELECT 
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

----Return older people in the family with younger ones
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

SELECT f1.ParentId AS PID, f2.ChildID AS CHID
FROM Family f1
JOIN Family f2 ON f1.ParentId = f2.ParentId
WHERE f1.ChildID != f2.ChildID;


------. Write an SQL statement given the following requirements. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas
CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM #Orders o
WHERE o.CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM #Orders
    WHERE DeliveryState = 'CA'
)
AND o.DeliveryState = 'TX';


----Insert the names of residents if they are missing
create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')


UPDATE #residents
SET fullname = CASE
    WHEN fullname IS NULL OR fullname = '' THEN 
        SUBSTRING(address, CHARINDEX('name=', address) + 5, CHARINDEX(' ', address + ' ', CHARINDEX('name=', address) + 5) - CHARINDEX('name=', address) - 5)
    ELSE fullname 
    END
WHERE fullname IS NULL OR fullname = '';


-----Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

WITH RouteCTE AS (
    SELECT DepartureCity, ArrivalCity, Cost, 
           CAST(DepartureCity AS VARCHAR(MAX)) + ' - ' + CAST(ArrivalCity AS VARCHAR(MAX)) AS RoutePath
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT r.DepartureCity, r.ArrivalCity, r.Cost + cte.Cost, 
           cte.RoutePath + ' - ' + r.ArrivalCity
    FROM #Routes r
    INNER JOIN RouteCTE cte ON cte.ArrivalCity = r.DepartureCity
    WHERE r.ArrivalCity != 'Tashkent')
SELECT TOP 1 RoutePath, Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost asc
union ALL
SELECT TOP 1 RoutePath, Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC;


----Rank products based on their order of insertion.
CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

SELECT 
    ID,
    Vals,
    ROW_NUMBER() OVER (ORDER BY ID) AS Rank
FROM 
    #RankingPuzzle;


----Find employees whose sales were higher than the average sales in their department
CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);


SELECT 
    EmployeeID,
    EmployeeName,
    Department,
    SalesAmount
FROM 
    #EmployeeSales e
WHERE 
    SalesAmount > (
        SELECT AVG(SalesAmount)
        FROM #EmployeeSales
        WHERE Department = e.Department
    );


----Find employees who had the highest sales in any given month using EXISTS

SELECT e.employeeid, e.employeename
FROM  e
WHERE EXISTS (
    SELECT 1
    FROM sales s
    WHERE s.employeeid = e.employeeid
    AND MONTH(s.sale_date) = 5  
    AND s.amount >= (
        SELECT MAX(s2.amount)
        FROM sales s2
        WHERE MONTH(s2.saledate) = 5
    )
);

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

---Find employees who made sales in every month using NOT EXISTS
SELECT e.EmployeeID, e.EmployeeName
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT MONTH(s.SaleDate) AS Month
          FROM Sales s) AS AllMonths
    WHERE NOT EXISTS (
        SELECT 1
        FROM Sales s2
        WHERE s2.EmployeeID = e.EmployeeID
        AND MONTH(s2.SaleDate) = AllMonths.Month
    )
);


---Retrieve the names of products that are more expensive than the average price of all products.

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

---Find the products that have a stock count lower than the highest stock count.

SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);


---- Get the names of products that belong to the same category as 'Laptop'.


SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

---- Retrieve products whose price is greater than the lowest price in the Electronics category.
SELECT Name, Price
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics');

----Find the products that have a higher price than the average price of their respective category.

SELECT Name, Price, Category
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);


----Find the products that have been ordered at least once.

CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

SELECT DISTINCT p.Name
FROM Products p
JOIN Orders od ON p.ProductID = od.ProductID;


----Retrieve the names of products that have been ordered more than the average quantity ordered.

SELECT p.Name
FROM Products p
JOIN Orders od ON p.ProductID = od.ProductID
GROUP BY p.Name
HAVING SUM(od.Quantity) > (
    SELECT AVG(TotalQuantity) 
    FROM (
        SELECT SUM(Quantity) AS TotalQuantity
        FROM Orders od
        GROUP BY ProductID
    ) AS ProductTotals
);

----Find the products that have never been ordered.

SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


---- Retrieve the product with the highest total quantity ordered.


SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID
ORDER BY TotalQuantity DESC;


