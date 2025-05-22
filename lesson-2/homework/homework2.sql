--1
create database homework2
create table employees (EmpID int,Name varchar(50),salary decimal(10,2))
select * from employees
--2
 insert into employees (empid,name,salary)values
 (1,'Akmal',6000)
 ,(2 ,'Rano',5200)
 ,(3,'Jamshid',3600)
 ,(4,'Bexruz', 12000)
 ,(5,'Odil',9800)
,(6,'Guli',2800)

 --3
 update employees set salary=7000 where empid=1
 --4
 delete from employees where empid=2
 
 --5
 
  delete jadvaldagi ma''lumotlarni tanlab yoki to''liq o''chiriladi.
  Misol: delete from jadval_name where shart; agar where bo''lmasa, barcha qatorlar o''chadi
  
  truncate jadvaldagi barcha ma''lumotlarni o''chiradi,lekin jadval tuzilmasi o''zgarishsiz qoladi
  Misol: truncate table employees

  drop jadval va baza o''zini o''chiradi
  Misol:drop table jadval_nomi

  select * from employees
 
 --6
  alter table employees alter column name varchar(100)
  --7
  alter table employees add department varchar(50)
  --8
  alter table employees alter column salary float
  --9
  create table department (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50),salary int, department varchar(30))
   select * from department
   drop table department
   --10
   truncate table employees

   --11 
   insert into department (departmentid, departmentname,salary,department) values
   (1, 'IT',4000,'null')
   ,(2,'Sales',8700,'null')
   ,(3,'HR',7560,'null')
   ,(4,'Administration',3410,'null')
   ,(5,'Public relations',7900,'null')

   --12
   update department set department='management' where salary>5000

   --13
    truncate table department

	--14
	 alter table employees drop column department

	 --15 
	 exec sp_rename 'employees', 'StaffMembers'
	 
	 --16
	 drop table department
	 --17
	 create table products (ProductID int Primary Key, ProductName VARCHAR(50), Category VARCHAR (50), Price DECIMAL)
	 select * from products
	 --18
	  alter table products add constraint chk_price_positive check (price>0)

	  --19
	  alter table products add stock_quantity int default 50
	  --20 
	  exec sp_rename 'products.category' ,'productcategory'
	  --21
	  insert into products(productid, productname, price,stock_quantity) values
	  (1,'banan',15000, 100) 
	  ,(2,'mango',25000,80)
	  ,(3,'kivi', 18000,90)
	  ,(4,'olma', 5000,60)
	  ,(5,'gilos',9000,70)
	  --22
	  select * into products_backup from products
	  --23
	  exec sp_rename 'products' , 'inventory'
	  select * from inventory
	  --24
	select name from sys.check_constraints where parent_object_id=object_id('inventory')
	 alter table inventory drop constraint chk_price_positive
	 alter table inventory alter column price float
	 --25
	 select identity (int,100,5) as product_code, * into inventory_new from inventory 
	 drop table inventory
	 exec sp_rename 'inventory_new','inventory'
	 select *from inventory