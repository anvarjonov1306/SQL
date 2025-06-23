create database homework_3
use homework_3

---Define and explain the purpose of BULK INSERT in SQL Server.
Bulk insert in SQL Server is a powerful feature used to efficiently import large amounts of data into a table from a data file.
bulk insert YourTableName
from 'C:\Data\YourDataFile.csv'
with (
    fieldterminator = ',',  -- Specify the delimiter (e.g., comma for CSV)
   rowterminator = '\n',   -- Specify the row terminator (e.g., newline)
    firstrow = 2            -- Skip the header row if present
);


---List four file formats that can be imported into SQL Server.

This module explains how to import data from a text file, CSV file, XML file, and JavaScript Object Notation (JSON) file. 
When you bulk import to a SQL Server table or bulk export from a table, a format file can store field format information for a data file relative to a table.

---Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).

create table products( ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))

---- Insert three records into the Products table using INSERT INTO.

insert into Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 999.99),
(2, 'Smartphone', 599.99),
(3, 'Headphones', 199.99);


---Explain the difference between NULL and NOT NULL.

In database management, NULL and NOT NULL are used to define the presence or absence of values in a field. 
NULL means that you do not have to provide a value for the field, while NOT NULL means that you must provide a value for the field. 
If you insert a blank into a field that allows NULL, you get a blank, not a NULL.
NULL represents the absence of a value

---Add a UNIQUE constraint to the ProductName column in the Products table.

alter table products
add constraint unique_product_name unique (productname)

----Write a comment in a SQL query explaining its purpose.

-- Select all products with a price greater than $500
SELECT * FROM Products
WHERE Price > 500;
The line starting with `--` is a comment that explains what the query does.
You can add comments like this to make your SQL code clearer and easier to understand.

---Add CategoryID column to the Products table.

alter table products 
add  categoryid int


---Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
 
 create table category (CategoryID int PRIMARY KEY , CategoryName varchar(400) UNIQUE)
 
---Explain the purpose of the IDENTITY column in SQL Server.

The IDENTITY column in SQL Server is used to automatically generate unique numeric values for a column in a table. 
It is commonly employed for primary key columns to ensure each row has a unique identifier without requiring manual input.

create table Employees (EmployeeID int identity(1,1) primary key,name varchar(50),
    Position varchar(50));


---Use BULK INSERT to import data from a text file into the Products table.

bulk insert Products 
from 'C:\Users\User\Documents'
with (fieldterminator = ',', rowterminator = '\n',   firstrow = 2)


---Create a FOREIGN KEY in the Products table that references the Categories table.

 alter table products add constraint fk_products_categories foreign key (categoryID) references categories(categoryID)


 ----Explain the differences between PRIMARY KEY and UNIQUE KEY.
  PRIMARY KEY is used to uniquely identify each row in a table. it must contain a value( no nulls).
 it must be  unique - no duplicate values. each table can have only one primary key.
 example: create table teachers( teachersID int primary key, name varchar(50))
 UNIQUE  key can accept null values, and a table can have multiole uniquekeys
 example: create table teachers(teachersID int primary key, email varchar(100) unique )

 ---- Add a CHECK constraint to the Products table ensuring Price > 0.
 alter table products
 add  constraint chk_price check (price>0)

 ---Modify the Products table to add a column Stock (INT, NOT NULL).

alter table products
add stock int not null default 0

----Use the ISNULL function to replace NULL values in Price column with a 0.

 select productID, productName,ISNULL(price,0) as price from products
 update products set price=0 where price is null

 ----Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.

 a foreign key constraint is used to establish a relationship between two tables.it ensures referential integrity,
 a meaning that the value in one table must match a value in another table,or be null
 example: create table categories( categoryID int primary key, categoryname varchar(50))
 create table products (productID int primary key, productname varchar(50),categoryID int, foreign key(categoryID)
 references categories(categoryID))
 alter table products add constraint fk_products_categories foreign key (categoryID) references categories(categoryID)

 ----Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.

  create table customer (customerID int primary key, fullname varchar(100) not null, age int not null,
 constraint chk_customers_age check(age>=18))

 ----Create a table with an IDENTITY column starting at 100 and incrementing by 10.

 create table orders (ordersID int identity(100,10) primary key,CustomerName  VARCHAR(100))

 ----Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (OrderID INT NOT NULL,ProductID INT NOT NULL,Quantity INT,Price DECIMAL(10, 2),
 PRIMARY KEY (OrderID, ProductID))


 ---Explain the use of COALESCE and ISNULL functions for handling NULL values..
 In SQL (SQL Server database), both COALESCE and ISNULL are used to handle NULL values in expressions and queries, providing a way to return a non-NULL alternative if the original value is NULL


 ---Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
 
 create table employees (empid int not null primary key , email  varchar (100) unique )

----Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
