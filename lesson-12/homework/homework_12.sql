create database lesson_12

use lesson_12


/* 1 

| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |


| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |

| personId | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |
Address table:

| addressId | personId | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |
Output:


| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |*/

select * from person

select * from address

select firstname,lastname,city,state from person p
left join address a on p.personid=a.personID


/* 2

2. Employees Earning More Than Their Managers
Table: Employee

| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
Id is the primary key (column with unique values) for this table. Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.

Write a solution to find the employees who earn more than their managers.

The result format is in the following example.

Input: Employee table:

| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
Output:

| Employee |
+----------+
| Joe      |
Explanation: Joe is the only employee who earns more than his manager.*/

Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

select e.Id,e.name as employeename, e.salary as employeesalary, m.name as managername, m.salary as managersalary
from employee e join Employee m on e.managerId=m.Id where e.salary>m.salary

/* 3 

3. Duplicate Emails
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
Id is the primary key (column with unique values) for this table. Each row of this table contains an email. The emails will not contain uppercase letters.

Write a solution to report all the duplicate emails. Note that it''s guaranteed that the email field is not NULL.

The result format is in the following example.

Input: Person table:

| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
Output:

| Email   |
+---------+
| a@b.com |
Explanation: a@b.com is repeated two times.
Create table If Not Exists Person (id int, email varchar(255)) Truncate table Person insert into Person (id, email) values ('1', 'a@b.com') insert into Person (id, email) values ('2', 'c@d.com') insert into Person (id, email) values ('3', 'a@b.com')*/


select * from person

 create table person (id int, email varchar(255))
 insert into person (id , email) values
 ('1', 'a@b.com'),
 ('2', 'c@d.com'),
 ('3', 'a@b.com')
select email from person
group by email
having count(*)>1

/* 4. delete duplicate emails
Create table Person (Id int, Email varchar(255))
Truncate table Person
insert into Person (id, email) values ('1', 'john@example.com')
insert into Person (id, email) values ('2', 'bob@example.com')
insert into Person (id, email) values ('3', 'john@example.com')*/

select * from person

delete from person
where id not in  (select min(id) from person group by email)

/* 5
CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

Find those parents who has only girls.
return parent name only.*/

select * from boys
select * from girls 

select parentname from girls 
except
select parentname from boys


select g.parentname from girls g left join boys b
on g.parentname=b.parentname where b.parentname is null

/* 6 
*/

SELECT custid, SUM(unitprice*qty*(1-discount)), MIN(weight) FROM [TSQL2012].[Sales].[Orders] o
join [TSQL2012].[Sales].[OrderDetails] od
on o.orderid = od.orderid
where weight > 50
group by custid



/* 7 

DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

*/ 

Select isnull(c1.item, '') as [Item Cart 1], isnull(c2.item, '') as [Item Cart 2] from cart1 c1 full join cart2 c2 on c1.item = c2.item
order by c1.item desc


/* 8

Create table Customers (id int, name varchar(255))
Create table Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

write a solution to find all customers who never order anything
*/ 

select * from customers
select * from orders

Select name as Customers from customers c left join orders o 
on c.id = o.customerid  where o.id is null

/* 9
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar || Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |*/

Select s.student_id, s.student_name, sb.subject_name, count(e.student_id) attended_exams from Students s cross join Subjects sb left join Examinations e on s.student_id = e.student_id and sb.subject_name = e.subject_name
group by s.student_id, s.student_name, sb.subject_name
order by s.student_id, student_name