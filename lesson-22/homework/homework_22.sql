create database homework_22
use homework_22

CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')


----Compute Running Total Sales per Customer

SELECT 
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM 
    sales_data
ORDER BY 
    customer_id, order_date;

---Count the Number of Orders per Product Category

SELECT 
    product_category,
    COUNT(sale_id) AS number_of_orders
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    number_of_orders DESC;

----Find the Maximum Total Amount per Product Category
SELECT 
    product_category,
    MAX(total_amount) AS max_total_amount
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    max_total_amount DESC;

----Find the Minimum Price of Products per Product Category

SELECT 
    product_category,
    MIN(unit_price) AS min_unit_price
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    min_unit_price ASC;


----Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

SELECT 
    sale_id,
    customer_id,
    customer_name,
    product_category,
    product_name,
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_sales
FROM 
    sales_data
ORDER BY 
    order_date;

----Find the Total Sales per Region
SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM 
    sales_data
GROUP BY 
    region
ORDER BY 
    total_sales DESC;

----Compute the Rank of Customers Based on Their Total Purchase Amount

SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase_amount,
    RANK() OVER (
        ORDER BY SUM(total_amount) DESC
    ) AS customer_rank
FROM 
    sales_data
GROUP BY 
    customer_id, customer_name
ORDER BY 
    customer_rank;

---Calculate the Difference Between Current and Previous Sale Amount per Customer

SELECT 
    sale_id,
    customer_id,
    customer_name,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_sale_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS sale_amount_difference
FROM 
    sales_data
ORDER BY 
    customer_id, order_date;

---Find the Top 3 Most Expensive Products in Each Category

WITH RankedProducts AS (
    SELECT 
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY product_category
            ORDER BY unit_price DESC
        ) AS product_rank
    FROM 
        sales_data
)
SELECT 
    product_category,
    product_name,
    unit_price
FROM 
    RankedProducts
WHERE 
    product_rank <= 3
ORDER BY 
    product_category, product_rank;

----Compute the Cumulative Sum of Sales Per Region by Order Date

SELECT 
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM 
    sales_data
ORDER BY 
    region, order_date;

----Compute Cumulative Revenue per Product Category

SELECT 
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM 
    sales_data
ORDER BY 
    product_category, order_date;


---Here you need to find out the sum of previous values. Please go through the sample input and expected output.

Sample Input

| ID |
|----|
|  1 |
|  2 |
|  3 |
|  4 |
|  5 |
Expected Output

| ID | SumPreValues |
|----|--------------|
|  1 |            1 |
|  2 |            3 |
|  3 |            6 |
|  4 |           10 |
|  5 |           15 |

CREATE TABLE SampleData (
    ID INT);
INSERT INTO SampleData (ID)
VALUES (1), (2), (3), (4), (5);
SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID) AS SumPreValues
FROM 
    SampleData;

---Sum of Previous Values to Current Value

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);
Sample Input

| Value |
|-------|
|    10 |
|    20 |
|    30 |
|    40 |
|   100 |
Expected Output

| Value | Sum of Previous |
|-------|-----------------|
|    10 |              10 |
|    20 |              30 |
|    30 |              50 |
|    40 |              70 |
|   100 |             140 |

SELECT 
    Value,
    SUM(Value) OVER (ORDER BY (SELECT NULL)) AS [Sum of Previous]
FROM 
    OneColumn;

-----Find customers who have purchased items from more than one product_category

SELECT 
    customer_name
FROM 
    sales_data
GROUP BY 
    customer_name
HAVING 
    COUNT(DISTINCT product_category) > 1;

----Find Customers with Above-Average Spending in Their Region

SELECT 
    customer_id,
    region,
    quantity_sold
FROM 
    sales_data s
WHERE 
    quantity_sold > (
        SELECT AVG(quantity_sold)
        FROM sales_data
        WHERE region = s.region
    );

----Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.

SELECT 
    customer_id,
    region,
    total_spending,
    RANK() OVER (PARTITION BY region ORDER BY total_spending DESC) AS rank_in_region
FROM (
    SELECT 
        customer_id,
        region,
        SUM(total_amount) AS total_spending
    FROM 
        sales_data s 
    GROUP BY 
        customer_id, region
) AS customer_totals;


----Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

SELECT
    customer_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM
    Sales_data;

---Calculate the sales growth rate (growth_rate) for each month compared to the previous month.

WITH MonthlySales AS (
    SELECT 
        FORMAT(order_date, 'yyyy-MM') AS year_month,
        SUM(total_amount) AS monthly_sales
    FROM 
        Sales_data
    GROUP BY 
        FORMAT(order_date, 'yyyy-MM')
)
SELECT 
    year_month,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY year_month) AS previous_month_sales,
    CASE 
        WHEN LAG(monthly_sales) OVER (ORDER BY year_month) = 0 THEN NULL
        ELSE ROUND(
            (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year_month)) * 100.0 /
            LAG(monthly_sales) OVER (ORDER BY year_month), 2
        )
    END AS growth_rate
FROM 
    MonthlySales;

---Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)

WITH OrderedSales AS (
    SELECT
        customer_id,
        order_date,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_total_amount
    FROM
        sales_data
)
SELECT
    customer_id,
    order_date,
    total_amount,
    prev_total_amount
FROM
    OrderedSales
WHERE
    total_amount > prev_total_amount;

---Identify Products that prices are above the average product price
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 1000.00),
(2, 'Smartphone', 700.00),
(3, 'Tablet', 300.00),
(4, 'Monitor', 250.00),
(5, 'Keyboard', 50.00);

SELECT 
    product_id,
    product_name,
    price
FROM 
    Products
WHERE 
    price > (SELECT AVG(price) FROM Products);

---In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output.

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);
Sample Input

| Id  | Grp | Val1 | Val2 |  
|-----|-----|------|------|  
|  1  |  1  |   30 |   29 |  
|  2  |  1  |   19 |    0 |  
|  3  |  1  |   11 |   45 |  
|  4  |  2  |    0 |    0 |  
|  5  |  2  |  100 |   17 |
Expected Output

| Id | Grp | Val1 | Val2 | Tot  |
|----|-----|------|------|------|
| 1  | 1   | 30   | 29   | 134  |
| 2  | 1   | 19   | 0    | NULL |
| 3  | 1   | 11   | 45   | NULL |
| 4  | 2   | 0    | 0    | 117  |
| 5  | 2   | 100  | 17   | NULL |


SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM 
    MyData
ORDER BY
    Id;


----Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.
CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);
Sample Input

| Id   | Cost | Quantity |  
|------|------|----------|  
| 1234 |   12 |      164 |  
| 1234 |   13 |      164 |  
| 1235 |  100 |      130 |  
| 1235 |  100 |      135 |  
| 1236 |   12 |      136 | 
Expected Output

| Id   | Cost | Quantity |
|------|------|----------|
| 1234 | 25   | 164      |
| 1235 | 200  | 265      |
| 1236 | 12   | 136      |


SELECT
    Id,
    SUM(Cost) AS Cost,
    CASE 
        WHEN COUNT(DISTINCT Quantity) = 1 THEN MAX(Quantity)  
        ELSE SUM(Quantity)                                     
    END AS Quantity
FROM
    TheSumPuzzle
GROUP BY
    Id
ORDER BY
    Id;

---From following set of integers, write an SQL statement to determine the expected outputs
CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 
Output:

---------------------
|Gap Start	|Gap End|
---------------------
|     1     |	6	|
|     8     |	12	|
|     16    |	26	|
|     36    |	51	|

WITH NumberBounds AS (
    SELECT
        MIN(SeatNumber) AS MinSeat,
        MAX(SeatNumber) AS MaxSeat
    FROM Seats),
SeatWithNext AS (
    SELECT
        SeatNumber,
        LEAD(SeatNumber) OVER (ORDER BY SeatNumber) AS NextSeat
    FROM Seats),
Gaps AS (
    SELECT
        1 AS GapStart,
        MinSeat - 1 AS GapEnd
    FROM NumberBounds
    WHERE MinSeat > 1
    UNION ALL
    SELECT
        SeatNumber + 1 AS GapStart,
        NextSeat - 1 AS GapEnd
    FROM SeatWithNext
    WHERE NextSeat IS NOT NULL AND NextSeat - SeatNumber > 1)
SELECT
    GapStart,
    GapEnd
FROM Gaps
ORDER BY GapStart;
