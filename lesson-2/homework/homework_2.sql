create database homework_2
use homework_2

--Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).

create table employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

---Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).

insert into employees ( empID, name, salary) values
 (2, 'Berna Alder', 45000), 
    (3, 'Khayri Ivo', 52000), 
    (4, 'Teppo Abel', 60000)

---Update the Salary of an employee to 7000 where EmpID = 1.

update employees
set salary = 7000
where EmpID=1

---Delete a record from the Employees table where EmpID = 2.

delete from employees
where EmpID=2

---Give a brief definition for difference between DELETE, TRUNCATE, and DROP.

delete - deletes specific rows in table 
truncate - clears table
drop - delete sqp objects 

---Modify the Name column in the Employees table to VARCHAR(100).

alter table employees
alter column name varchar (100)

----Add a new column Department (VARCHAR(50)) to the Employees table.
 alter table Employees 
 add  Department VARCHAR(50)

----Change the data type of the Salary column to FLOAT.

alter table employees 
alter column salary  float 

---Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).

create table Departments ( DepartmentID INT PRIMARY KEY , DepartmentName VARCHAR(50))

---Remove all records from the Employees table without deleting its structure.

truncate table  Employees 

---Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).

CREATE TABLE TempDepartments (
    DepartmentID INT,
    DepartmentName VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO TempDepartments (DepartmentID, DepartmentName, city) VALUES
(1, 'Human Resources', 'New York'),
(2, 'Finance', 'San Francisco'),
(3, 'Marketing', 'Chicago'),
(4, 'Sales', 'Los Angeles'),
(5, 'IT Support', 'Seattle');

select * from TempDepartments

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT DepartmentID, DepartmentName  FROM TempDepartments;

---Update the Department of all employees where Salary > 5000 to 'Management'.

update  employees
set Department= 'Management'
where Salary > 5000

---Write a query that removes all employees but keeps the table structure intact.

truncate table  Employees

---Drop the Department column from the Employees table.

alter table Employees
drop column Department

select * from employees
---Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers'

---Write a query to completely remove the Departments table from the database.
drop table  Departments 

---Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)

create table products  (ProductID int Primary Key, ProductName VARCHAR(100), Category VARCHAR(100), Price DECIMAL(10,2), quantity int)

----Add a CHECK constraint to ensure Price is always greater than 0.

alter table products  
add check (price>0)

----Modify the table to add a StockQuantity column with a DEFAULT value of 50.

alter table products  
add StockQuantity int default 50

---Rename Category to ProductCategory
EXEC sp_rename 'products.Category', 'ProductCategory'

---Insert 5 records into the Products table using standard INSERT INTO queries.

create table products  (ProductID int Primary Key, ProductName VARCHAR(100), Category VARCHAR(100), Price DECIMAL(10,2), quantity int)

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Quantity) 
VALUES 
(1, 'Sample Product 1', 'Category A', 19.99, 100),
(2, 'Sample Product 2', 'Category B', 29.99, 200),
(3, 'Sample Product 3', 'Category c', 39.99, 50),
(4, 'Sample Product 4', 'Category d', 59.99, 100),
(5, 'Sample Product 5', 'Category e', 9.99, 400)

select * from Products

----Use SELECT INTO to create a backup table called Products_Backup containing all Products data.

SELECT *INTO products_backup
FROM products;

---Rename the Products table to Inventory
exec sp_rename 'products','Inventory'

---Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

ALTER table Inventory
ALTER column Price float


---Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.

alter table inventory
add productcode int identity (1000,5)