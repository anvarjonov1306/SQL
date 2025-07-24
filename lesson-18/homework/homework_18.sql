create database homework_18
use homework_18


----Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.


CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18, 2)
);

INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
WHERE 
    MONTH(s.SaleDate) = MONTH(GETDATE()) AND
    YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY 
    s.ProductID;

SELECT * FROM #MonthlySales;

-----Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.

CREATE VIEW vw_ProductSalesSummary as SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    COALESCE(SUM(s.Quantity), 0) as TotalQuantitySold  
FROM 
    Products p
LEFT JOIN 
    Sales s on p.ProductID = s.ProductID
GROUP BY 
    p.ProductID, p.ProductName, p.Category;

SELECT * FROM vw_ProductSalesSummary;


---Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)

CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18, 2);
    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;
    IF @TotalRevenue IS NULL
    BEGIN
        SET @TotalRevenue = 0;
    END
    RETURN @TotalRevenue;
END;


----Create an function fn_GetSalesByCategory(@Category VARCHAR(50))

CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM 
        Products p
    JOIN 
        Sales s ON p.ProductID = s.ProductID
    WHERE 
        p.Category = @Category
    GROUP BY 
        p.ProductName
);



----You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3) 
AS
BEGIN
    DECLARE @Result VARCHAR(3);
    DECLARE @i INT;
    IF @Number <= 1
    BEGIN
        SET @Result = 'No';
    END
    ELSE
    BEGIN
        SET @Result = 'Yes';
        SET @i = 2;
        WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
    BEGIN
        SET @Result = 'No';
    BREAK;
END
        SET @i = @i + 1;
    END
END
    RETURN @Result;
END;


---Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:

CREATE FUNCTION dbo.fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS TABLE
AS
RETURN
(WITH NumberSequence AS
      (SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM NumberSequence
        WHERE Number + 1 <= @End )
    SELECT Number
    FROM NumberSequence);

---- Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
DECLARE @N INT = 2;

WITH RankedSalaries AS (
    SELECT DISTINCT salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS Rank
    FROM Employee
)
SELECT 
    CASE 
        WHEN EXISTS (SELECT 1 FROM RankedSalaries WHERE Rank = @N) 
        THEN (SELECT salary FROM RankedSalaries WHERE Rank = @N)
        ELSE NULL
    END AS HighestNSalary;


-----Write a SQL query to find the person who has the most friends.

WITH FriendCounts AS (
    SELECT requester_id AS user_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id
    FROM RequestAccepted
)
SELECT TOP 1 user_id AS id, COUNT(*) AS num
FROM FriendCounts
GROUP BY user_id
ORDER BY num DESC;



----9. Create a View for Customer Order Summary.


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);

CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name;


----Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)


SELECT 
    RowNumber, 
    MAX(Workflow) OVER (PARTITION BY grp ORDER BY RowNumber) AS Workflow
FROM (
    SELECT 
        RowNumber, 
        TestCase AS Workflow,
        SUM(CASE WHEN TestCase IS NOT NULL THEN 1 ELSE 0 END) 
            OVER (ORDER BY RowNumber) AS grp
    FROM Gaps
) AS SubQuery
ORDER BY RowNumber;
