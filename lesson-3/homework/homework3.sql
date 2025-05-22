create database homework3
go
use homework3
---1
 bulk insert in SQL server is a transact-SQL command that allows you to import data from a file into a
 database table in SQL server
 example: bulk insert employee from 'c\data\file.csv' with
 (fieldterminator=',',
 rowterminator='\n',
 firstrow=2)

 --2
 CSV(Comma-Separated Values). widely usedfor data exchange, easily imported using bulk insert, bcp, or SSIS
 example:data.csv
 TXT(Plain Text File). custom-delimited text files (e.g., tab-delimited), used with bulk insert by specifying delimiters,
 example:data.txt
 XLS/XLSX(Microsoft Excel Files). imported using SQL Server Intergration Services(SSIS) or OPENROWSET function,
 requires the ACE OLEDB provider 
 example:data.xlsx
 XML(EXTENSIBLE	Markup Language). imported using the OPENXML, xml data type, or SSIS.
 Useful for structured hierarchical data
 example:data.xml

 --3
 create table products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))
  select * from products 
  --4
   insert into products ( productID,ProductName,Price) values
   (1,'apple',2)
   ,(2,'watermelon',5)
   ,(3,'strawberry',3)
   ,(4,'papaya', 6)
   ,(5,'lemon',1)

   --5
   meaning of null : the column can be left empty.represents: an unknown,missing, or undefined value
	Example: create table employees(id int, name varchar(50) null)
	 
   meaning of not null: the column must have a value; it cannot be empty. used for : requred fields like IDS, NAMES, OR AMOUNTS
   Example:create table Employees(id int not null, firstname varchar (50) not null.

   --6
   alter table products add constraint UQ_productname unique (productname)
   --7
   types of SQL comments:
   -- for singl-line comment;
   /*....*/ for multi-line comments
   --8
   alter table products add  categoryID int
   --9
   create table categories( categoryID int primary key, categoryname varchar(50) unique)

   --10 
   purpose of identity is used to define an auto-incrementing numeric column

   --11
    bulk insert employee from 'c\data\file.csv' with
 (fieldterminator=',',
 rowterminator='\n',
 firstrow=2)
 --12
 alter table products add constraint fk_products_categories foreign key (categoryID) references categories(categoryID)
 --13
 PRIMARY KEY is used to uniquely identify each row in a table. it must contain a value( no nulls).
 it must be  unique - no duplicate values. each table can have only one primary key.
 example: create table teachers( teachersID int primary key, name varchar(50))
 UNIQUE  key can accept null values, and a table can have multiole uniquekeys
 example: create table teachers(teachersID int primary key, email varchar(100) unique )
 --14
 alter table products add check (price>0)
 --15
 alter table products add stock int not null default 0
 --16
 select productID, productName,ISNULL(price,0) as price from products
 update products set price=0 where price is null
 --17
 a foreign key constraint is used to establish a relationship between two tables.it ensures referential integrity,
 a meaning that the value in one table must match a value in another table,or be null
 example: create table categories( categoryID int primary key, categoryname varchar(50))
 create table products (productID int primary key, productname varchar(50),categoryID int, foreign key(categoryID)
 references categories(categoryID))
 alter table products add constraint fk_products_categories foreign key (categoryID) references categories(categoryID)
 --18
 create table customer (customerID int primary key, fullname varchar(100) not null, age int not null,
 constraint chk_customers_age check(age>=18))
 --19
 create table orders (ordersID int identity(100,10) primary key,CustomerName  VARCHAR(100)  NOT NULL
,OrderNumber  CHAR(8))
select * from order
 --20
  create table orderdetails (orderID int not null,productID int not null,quantity int not null,
  constraint pk_orderdetails primary key(orderID,productID))
  --21
  BOTH COALESCE AND ISNULL ARE USED TO REPLACE NULL VALUES WITH Q DEFAULT VAKUE, BUT THEY HAVE DIFFERECRS IN 
  FLEXIBILITY AND BEHAVIOR
  ISNULL:replaces a null value with a specified replacement.
  example: select isnull(price,0) as finalprice from products
  COALESCE:returns the first non-null value from a list of expressions.
  example:select coalesce(phone,email,;'no contact info')as contactInfo from customers
  ISNULL for simple 2-value replacement
  COALESCE when you need check multiple values or want better portability across database
  --22
  create table employee (empID int primary key, email varchar (100) unique)
   
   --23
   alter table products add constraint fk_products_category foreign key (categoryID) references categories(categoryID)
   on delete cascade 
   alter table products add constraint fk_products_category foreign key (categoryID) references categories(categoryID)
   on update cascade