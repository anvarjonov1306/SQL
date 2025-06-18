create database homework_1
use homework_1
---1.Define the following terms: data, database, relational database, and table.
 1. Data is a collection of facts, numbers, words, observations or other useful information. 
 Through data processing and data analysis,
 organizations transform raw data points into valuable insights that improve decision-making and drive better business outcomes.

 Database -any collection of data, or information, that is specially organized for rapid search and retrieval by a computer.
 Databases are structured to facilitate the storage, retrieval, modification, and deletion of data in conjunction with various data-processing operations. 
 A database management system (DBMS) extracts information from the database in response to queries.

 A relational database is a type of database that organizes data into rows and columns, which collectively form a table where the data points are related to each other.
 Relational databases are also typically associated with transactional databases, which execute commands, or transactions, collectively.
 A popular example that is used to illustrate this is a bank transfer.
 A defined amount is withdrawn from one account, and then it is deposited within another. The total amount of money is withdrawn and deposited, and this transaction cannot occur in any kind of partial sense. 
 
 A table in SQL is a fundamental structure used to organize and store data within a relational database. 
 It consists of rows and columns, forming a grid-like structure. 
 Each column represents a specific attribute or field, while each row represents a single record or entry.

 ---2 List five key features of SQL Server.
1. DDL - Data Definition Language
DDL or Data Definition Language actually consists of the SQL commands that can be used for defining, altering, and deleting database structures such as tables, indexes, and schemas. It simply deals with descriptions of the database schema and is used to create and modify the structure of database objects in the database

Common DDL Commands
Command	Description	Syntax
CREATE	Create database or its objects (table, index, function, views, store procedure, and triggers)	CREATE TABLE table_name (column1 data_type, column2 data_type, ...);
DROP	Delete objects from the database	DROP TABLE table_name;
ALTER	Alter the structure of the database	ALTER TABLE table_name ADD COLUMN column_name data_type;
TRUNCATE	Remove all records from a table, including all spaces allocated for the records are removed	TRUNCATE TABLE table_name;
COMMENT	Add comments to the data dictionary	COMMENT 'comment_text' ON TABLE table_name;
RENAME	Rename an object existing in the database	RENAME TABLE old_table_name TO new_table_name;
Example:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);
In this example, a new table called employees is created with columns for employee ID, first name, last name, and hire date.

2. DQL - Data Query Language
DQL statements are used for performing queries on the data within schema objects. The purpose of the DQL Command is to get some schema relation based on the query passed to it. This command allows getting the data out of the database to perform operations with it. When a SELECT is fired against a table or tables the result is compiled into a further temporary table, which is displayed or perhaps received by the program.

DQL Command
Command	Description	Syntax
SELECT

It is used to retrieve data from the database

SELECT column1, column2, ...FROM table_name WHERE condition;

Example:
SELECT first_name, last_name, hire_date
FROM employees
WHERE department = 'Sales'
ORDER BY hire_date DESC;
This query retrieves employees first and last names, along with their hire dates, from the employees table, specifically for those in the 'Sales' department, sorted by hire date.

3. DML - Data Manipulation Language
The SQL commands that deal with the manipulation of data present in the database belong to DML or Data Manipulation Language and this includes most of the SQL statements.
It is the component of the SQL statement that controls access to data and to the database. Basically, DCL statements are grouped with DML statements.
Common DML Commands
Command	Description	Syntax
INSERT	Insert data into a table	INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
UPDATE	Update existing data within a table	UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
DELETE	Delete records from a database table	DELETE FROM table_name WHERE condition;
LOCK	Table control concurrency	LOCK TABLE table_name IN lock_mode;
CALL	Call a PL/SQL or JAVA subprogram	CALL procedure_name(arguments);
EXPLAIN PLAN	Describe the access path to data	EXPLAIN PLAN FOR SELECT * FROM table_name;
Example:
INSERT INTO employees (first_name, last_name, department) 
VALUES ('Jane', 'Smith', 'HR');
This query inserts a new record into the employees table with the first name 'Jane', last name 'Smith', and department 'HR'.

4. DCL - Data Control Language
DCL (Data Control Language) includes commands such as GRANT and REVOKE which mainly deal with the rights, permissions, and other controls of the database system. These commands are used to control access to data in the database by granting or revoking permissions.

Common DCL Commands
Command	Description	Syntax
GRANT	Assigns new privileges to a user account, allowing access to specific database objects, actions, or functions.	GRANT privilege_type [(column_list)] ON [object_type] object_name TO user [WITH GRANT OPTION];
REVOKE	Removes previously granted privileges from a user account, taking away their access to certain database objects or actions.	REVOKE [GRANT OPTION FOR] privilege_type [(column_list)] ON [object_type] object_name FROM user [CASCADE];
Example of DCL
GRANT SELECT, UPDATE ON employees TO user_name;
This command grants the user user_name the permissions to select and update records in the employees table.

5. TCL - Transaction Control Language
Transactions group a set of tasks into a single execution unit. Each transaction begins with a specific task and ends when all the tasks in the group are successfully completed. If any of the tasks fail, the transaction fails. Therefore, a transaction has only two results: success or failure. We can explore more about transactions here.

Common TCL Commands
Command	Description	Syntax
BEGIN TRANSACTION	Starts a new transaction	BEGIN TRANSACTION [transaction_name];
COMMIT	Saves all changes made during the transaction	COMMIT;
ROLLBACK	Undoes all changes made during the transaction	ROLLBACK;
SAVEPOINT	Creates a savepoint within the current transaction	SAVEPOINT savepoint_name;
Example:
BEGIN TRANSACTION;
UPDATE employees SET department = 'Marketing' WHERE department = 'Sales';
SAVEPOINT before_update;
UPDATE employees SET department = 'IT' WHERE department = 'HR';
ROLLBACK TO SAVEPOINT before_update;
COMMIT
In this example, a transaction is started, changes are made, and a savepoint is set. If needed, the transaction can be rolled back to the savepoint before being committed.

--- What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
There are two possible modes: Windows Authentication mode and mixed mode. Windows Authentication mode enables Windows Authentication and disables SQL Server Authentication.
Mixed mode enables both Windows Authentication and SQL Server Authentication.

----Create a new database in SSMS named SchoolDB.
create database SchoolDB

---Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)).

create table students (StudentID INT PRIMARY KEY, Name VARCHAR(50))

---Describe the differences between SQL Server, SSMS, and SQL.
SQL Server and SQL Server Management Studio (SSMS) are two different things, although they are often confused with each other.
SQL Server is a relational database management system (RDBMS) developed by Microsoft. 
It is used to store, manage, and retrieve data. SQL Server uses SQL (Structured Query Language) to interact with the database.
SQL Server Management Studio (SSMS) is a graphical user interface (GUI) tool for managing Microsoft SQL Server. 
It allows you to create, manage, and administer SQL Server databases and objects. SSMS also includes a query editor that you can use to write and execute SQL queries.
The main difference between SQL Server and SSMS is that SQL Server is a database management system, while SSMS is a GUI tool for managing a database management system. 
SQL Server can be used with any GUI tool, but SSMS is specifically designed for Microsoft SQL Server.

---Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

 DDL - Data Definition Language
DDL or Data Definition Language actually consists of the SQL commands that can be used for defining, altering, and deleting database structures such as tables, indexes, and schemas. It simply deals with descriptions of the database schema and is used to create and modify the structure of database objects in the database

Common DDL Commands
Command	Description	Syntax
CREATE	Create database or its objects (table, index, function, views, store procedure, and triggers)	CREATE TABLE table_name (column1 data_type, column2 data_type, ...);
DROP	Delete objects from the database	DROP TABLE table_name;
ALTER	Alter the structure of the database	ALTER TABLE table_name ADD COLUMN column_name data_type;
TRUNCATE	Remove all records from a table, including all spaces allocated for the records are removed	TRUNCATE TABLE table_name;
COMMENT	Add comments to the data dictionary	COMMENT 'comment_text' ON TABLE table_name;
RENAME	Rename an object existing in the database	RENAME TABLE old_table_name TO new_table_name;
Example:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);
In this example, a new table called employees is created with columns for employee ID, first name, last name, and hire date.

2. DQL - Data Query Language
DQL statements are used for performing queries on the data within schema objects. The purpose of the DQL Command is to get some schema relation based on the query passed to it. This command allows getting the data out of the database to perform operations with it. When a SELECT is fired against a table or tables the result is compiled into a further temporary table, which is displayed or perhaps received by the program.

DQL Command
Command	Description	Syntax
SELECT

It is used to retrieve data from the database

SELECT column1, column2, ...FROM table_name WHERE condition;

Example:
SELECT first_name, last_name, hire_date
FROM employees
WHERE department = 'Sales'
ORDER BY hire_date DESC;
This query retrieves employees first and last names, along with their hire dates, from the employees table, specifically for those in the 'Sales' department, sorted by hire date.

3. DML - Data Manipulation Language
The SQL commands that deal with the manipulation of data present in the database belong to DML or Data Manipulation Language and this includes most of the SQL statements.
It is the component of the SQL statement that controls access to data and to the database. Basically, DCL statements are grouped with DML statements.
Common DML Commands
Command	Description	Syntax
INSERT	Insert data into a table	INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
UPDATE	Update existing data within a table	UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
DELETE	Delete records from a database table	DELETE FROM table_name WHERE condition;
LOCK	Table control concurrency	LOCK TABLE table_name IN lock_mode;
CALL	Call a PL/SQL or JAVA subprogram	CALL procedure_name(arguments);
EXPLAIN PLAN	Describe the access path to data	EXPLAIN PLAN FOR SELECT * FROM table_name;
Example:
INSERT INTO employees (first_name, last_name, department) 
VALUES ('Jane', 'Smith', 'HR');
This query inserts a new record into the employees table with the first name 'Jane', last name 'Smith', and department 'HR'.

4. DCL - Data Control Language
DCL (Data Control Language) includes commands such as GRANT and REVOKE which mainly deal with the rights, permissions, and other controls of the database system. These commands are used to control access to data in the database by granting or revoking permissions.

Common DCL Commands
Command	Description	Syntax
GRANT	Assigns new privileges to a user account, allowing access to specific database objects, actions, or functions.	GRANT privilege_type [(column_list)] ON [object_type] object_name TO user [WITH GRANT OPTION];
REVOKE	Removes previously granted privileges from a user account, taking away their access to certain database objects or actions.	REVOKE [GRANT OPTION FOR] privilege_type [(column_list)] ON [object_type] object_name FROM user [CASCADE];
Example of DCL
GRANT SELECT, UPDATE ON employees TO user_name;
This command grants the user user_name the permissions to select and update records in the employees table.

5. TCL - Transaction Control Language
Transactions group a set of tasks into a single execution unit. Each transaction begins with a specific task and ends when all the tasks in the group are successfully completed. If any of the tasks fail, the transaction fails. Therefore, a transaction has only two results: success or failure. We can explore more about transactions here.

Common TCL Commands
Command	Description	Syntax
BEGIN TRANSACTION	Starts a new transaction	BEGIN TRANSACTION [transaction_name];
COMMIT	Saves all changes made during the transaction	COMMIT;
ROLLBACK	Undoes all changes made during the transaction	ROLLBACK;
SAVEPOINT	Creates a savepoint within the current transaction	SAVEPOINT savepoint_name;
Example:
BEGIN TRANSACTION;
UPDATE employees SET department = 'Marketing' WHERE department = 'Sales';
SAVEPOINT before_update;
UPDATE employees SET department = 'IT' WHERE department = 'HR';
ROLLBACK TO SAVEPOINT before_update;
COMMIT
In this example, a transaction is started, changes are made, and a savepoint is set. If needed, the transaction can be rolled back to the savepoint before being committed.

--Write a query to insert three records into the Students table.
create table students (studentid int, name varchar(100), age int )
INSERT INTO students (studentid, name, age)
VALUES 
    (1, 'Alice Johnson', 20 ),
    (2, 'Bob Smith', 22),
    (3, 'Charlie Brown', 19);


--Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link
1.Download the appropriate .bak file from one of links provided in the download backup files section.
2.Move the .bak file to your SQL Server backup location. This location varies depending on your installation location, instance name, and version of SQL Server. 
For example, the default location for a default instance of SQL Server 2022 (16.x) is:
C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup
3.Open SSMS and connect to your SQL Server instance.

4.Right-click Databases in Object Explorer > Restore Database... to launch the Restore Database wizard.
5.Select Device and then select the ellipses (...) to choose a device.
6.Select Add and then choose the .bak file you recently moved to the backup location. If you moved your file to this location but you're not able to see it in the wizard, SQL Server or the user signed into SQL Server doesn't have permission to this file in this folder.
7.Select OK to confirm your database backup selection and close the Select backup devices window.
8.Check the Files tab to confirm the Restore as location and file names match your intended location and file names in the Restore Database wizard.
9.Select OK to restore your database.