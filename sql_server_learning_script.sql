SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
where table_name = 'Employees'

select * from Employees; 

-- null vs 0 vs '' are different with each other 

--insert into Employees values (11, 'Jay', '', 'IT', 67000, '2022-04-04')

--insert into Employees values (12, 'Jayam', 'Ravi', '0', '90000', '2022-04-07')

-- null operator 
--to find the row where the dept is null 

select * from Employees where Department is null;


select * from Employees where Department is not null;

select * from Employees where Department is not null and department != '0'

-- update statement : make sure use the where clause to select the right row while update 

select * into #1 from Employees ;

select * from #1;

update #1 
set Department = 'IT' WHERE DEPARTMENT IS NULL;

update #1 
set Salary  = '98000' , HireDate = '2023-05-10' WHERE employeeid = 9;

-- what if dont use the where clause while update the table, obviously it set the given values to the Department for all the rows.

select * into #2 from Employees;

select * from #2;

update #2 
set Department = 'Finance'


-- Delete, Drop, Truncate

-- Delete ->used to delete certain rows from the table with where clause, if not where clause we use in the delete statement, it will delete all the rows in the table.
-- While delete without where clause, it wipe out all the rows but the column/table structire remains intact 

select * into #3 from Employees; 
select * from #3;

delete from #3 where Department is null or Department = '0' or LastName = ''

select * into #4 from Employees; 

delete from #4; 

select * from #4;

-- Truncate : to clear all the rows  from the table
select * from #3;
truncate table #3;
select * from #3;


-- Drop statement to remove the table data and table structure 

drop table #3; 

select * from #3; -- error comes, because it does not exist 


-- SQL Comment 

select * from employees;
/* 
SQL 
Multi line
comment 
*/ 

select top 2 * from Employees;

select top 3 LastName, Department,Salary,HireDate from Employees;

-- Group By 

use Sales;

CREATE TABLE dbo.Sales (
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    CustomerID INT,
    StoreID INT,
    SalespersonID INT,
    PaymentMethod VARCHAR(50)  -- New varchar column for payment method
);

-- Inserting more sample data (10 records), including NULL values
INSERT INTO dbo.Sales (ProductID, SaleDate, Quantity, TotalAmount, CustomerID, StoreID, SalespersonID, PaymentMethod)
VALUES 
(1, '2023-08-01', 10, 200.00, 101, 1, 201, 'Credit Card'),
(2, '2023-08-01', 5, 150.00, 102, 1, 202, 'Cash'),
(1, '2023-08-02', 8, 160.00, 103, 2, 203, 'Credit Card'),
(2, '2023-08-02', 7, 210.00, 104, 2, 204, 'Cash'),
(1, '2023-08-03', 6, 120.00, 105, 1, 201, NULL),              -- NULL value in PaymentMethod
(3, '2023-08-04', 12, 300.00, 106, 3, 205, 'Credit Card'),
(1, '2023-08-04', 5, 100.00, 107, 3, 206, 'Debit Card'),
(2, '2023-08-05', 9, 270.00, 108, 1, 202, NULL),              -- NULL value in PaymentMethod
(3, '2023-08-05', 15, 375.00, 109, 3, 207, 'Cash'),
(1, '2023-08-06', 7, 140.00, 110, 2, 203, 'Credit Card');


select * from Sales; 

select max(Quantity) as Maximum_Quanity from Sales;
select max(TotalAmount) as Max_Amnt from Sales;
select max(PaymentMethod) from Sales;

-- Maximum quantity sold for each id 
select Productid , max(Quantity) as max_quantity from Sales group by Productid;

-- Maximum Total Amount for each distinct date

select SaleDate, max(TotalAmount) as max_value from Sales group by SaleDate


-- Minimum min()

select * from Sales; 

select min(Quantity) as min_quantity from Sales;

select min(PaymentMethod) as min_payment_method from Sales;

select min(SaleDate) as min_date from Sales;

select storeid , min(TotalAmount) as min_amount from Sales group by storeid;

--sum() , avg() , count()

select * from sales;

select sum(TotalAmount) as total from Sales;

select sum(TotalAmount) as total , sum(Quantity) as total_quantity from Sales;

select avg(Quantity) as avg_quantity from Sales;

select avg(Quantity) as avg_quantity , avg(TotalAmount) as avg_amount from Sales;

-- sum of quantity, sum of total, avg_quantity , avg_toatal for each distinct product 

select distinct productid from sales;

select productid , sum(Quantity) as sum_of_quantity , 
sum(TotalAmount) as sum_of_amount,
avg(Quantity) as avg_quantity,
avg(TotalAmount) as avg_amount from Sales group by Productid;


select storeid , productid ,sum(Quantity) as sum_of_quantity , 
sum(TotalAmount) as sum_of_amount,
avg(Quantity) as avg_quantity,
avg(TotalAmount) as avg_amount from Sales group by Productid , storeid order by storeid;


-- count(*)  count the null values rows , but if we use any specific column in the count() it just ignore the null values.

select count(*) as no_of_rows from sales;

select count(PaymentMethod) as no_of_records from sales;

select count(distinct productid) [Distinct Product id] from Sales;

select count(*) as no_of_rows from sales;

select count(PaymentMethod) as no_of_records from sales;
select count(distinct PaymentMethod) [Distinct Pay Mode] from Sales;

select PaymentMethod, count(paymentmethod) as no_of_pay_mode from sales group by PaymentMethod;
select PaymentMethod, count(*) as no_of_pay_mode from sales group by PaymentMethod;
select * from sales;

-- GROUP BY 

select * from sales;

--sales over every payment_method 

select paymentmethod , sum(TotalAmount) as sum_of_sales from Sales group by paymentmethod order by sum_of_sales desc;

-sales over every payment method and productid
select paymentmethod ,productid, sum(TotalAmount) as total_sales from Sales group by paymentmethod,productid order by productid;

-- HAVING Clause 
--total sales , avg sales , total quantity avg quantity for each distinct product 

select productid , sum(TotalAmount) as sum_of_sales ,
avg(totalamount) as avg_amount,
sum(quantity) as total_quantity,
avg(quantity) as avg_quantity
from sales group by productid having sum(TotalAmount) < 700;

-- where vs having
-- where is used in the non-grouped records 
-- having is used in the grouped/aggregated records  

select * from sales where totalamount > 250 ;

select productid , sum(TotalAmount) as sum_of_sales ,
avg(totalamount) as avg_amount,
sum(quantity) as total_quantity,
avg(quantity) as avg_quantity
from sales group by productid having sum(TotalAmount) < 700;


select productid , sum(totalamount) as total from sales where totalamount >=161 
group by productid having sum(totalamount) >=250 order by productid desc;
-- here we have grouping the filtered data and again filter the aggregated records 



----Creating Table1 & insertinting records in Table1
--create table table1 (C1 int, C2 nvarchar(max))
--insert into table1 values (1,'A'),
--(1,'B'),
--(2,'C'),
--(NULL,'D'),
--(3,'E'),
--(7,'DA')

----Creating Table2 & insertinting records in Table2
--create table table2 (C1 int, C3 nvarchar(max))
--insert into table2 values (1,'XA'),
--(2,'MB'),
--(2,'NX'),
--(NULL,'MO'),
--(4,'XY'),
--(5,'TF')

SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT * FROM TABLE1 INNER JOIN TABLE2 ON TABLE1.C1 = TABLE2.C1 

SELECT A.C1, A.C2,B.C3 FROM TABLE1 A INNER JOIN TABLE2 B ON A.C1 = B.C1 

-- JOIN <=> INNER JOIN 

-- LEFT JOIN OR LEFT OUTER JOIN 

SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT A.C1, A.C2,B.C1, B.C3 FROM TABLE1 A LEFT OUTER JOIN TABLE2 B ON A.C1 = B.C1 

-- RIGHT JOIN OR RIGHT OUTER JOIN 
SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT A.C1, A.C2,B.C1, B.C3 FROM TABLE1 A RIGHT OUTER JOIN TABLE2 B ON A.C1 = B.C1 

-- left anti join 

SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT * FROM TABLE1 LEFT JOIN TABLE2 ON TABLE1.C1 = TABLE2.C1 WHERE TABLE2.C3 IS NULL;

-- right anti join 

SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT * FROM TABLE1 RIGHT JOIN TABLE2 ON TABLE1.C1 = TABLE2.C1 WHERE TABLE1.C2 IS NULL;

-- full outer join -> union of inner join and left join and right join 
-- It include the output of inner join and also only include from the left table and only include from the right table 


SELECT * FROM TABLE1;
SELECT * FROM TABLE2;

select * from table1 full outer join table2 on table1.c1 = table2.c1 ;

select a.c1, a.c2,b.c3 from table1 a full outer join table2 b on a.c1 = b.c1; 

-- SELF JOIN -> JOIN THE TABLE TO ITSELF 

SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT A.C1,A.C2,B.C2 FROM TABLE1 A INNER JOIN TABLE1 B ON A.C1 = B.C1 


SELECT * FROM TABLE1;
SELECT * FROM TABLE2;
SELECT A.C1,A.C2,B.C2 FROM TABLE1 A JOIN TABLE1 B ON A.C1 = B.C1 

-- UNION 
--create table append1 (C1 int,C2 nvarchar(255),C3 int)
--insert into append1 values (1,'A',7),
--(2,'B',8),
--(3,'C',9)



--create table append2 (C1 int,C2 nvarchar(255),C3 int)
--insert into append2 values (11,'AA',17),
--(2,'B',8),
--(33,'C1',91)

SELECT * FROM APPEND1;
SELECT * FROM APPEND2;

--UNION ALL-> It combine results with duplicates    
SELECT * FROM APPEND1 
UNION ALL
SELECT * FROM APPEND2; 

-- UNION  -> it combine results without duplicates 
SELECT * FROM APPEND1
UNION 
SELECT * FROM APPEND2 

-- while union or union all -> no of columns present in the select list have to be the same 
-- Data types of the column have to be the same 
-- Order in which columns are written has to be the same. 

-- SQL LIKE Operator 

-- Create Employees_us table
--CREATE TABLE Employees_US (
--    EmployeeID INT PRIMARY KEY,
--    FirstName VARCHAR(50),
--    LastName VARCHAR(50),
--    Department VARCHAR(50)
--);

---- Insert sample data into Employees table
--INSERT INTO Employees_us (EmployeeID, FirstName, LastName, Department) VALUES
--(1, 'Alice', 'Smith', 'Finance'),
--(2, 'Bob', 'Johnson', 'Engineering'),
--(3, 'Charlie', 'Williams', 'Marketing'),
--(4, 'Diana', 'Brown', 'Finance'),
--(5, 'Edward', 'Jones', 'Engineering'),
--(6, 'Fiona', 'Garcia', 'Marketing'),
--(7, 'George', 'Miller', 'Finance'),
--(8, 'Hannah', 'Wilson', 'Engineering');


select * from employees_us;

-- wildcard sign are % , _
-- % -> it represent 0,1, or mulitple character 
-- _ it represent only one character 


--1) Find Employees whose Last Name starts with 'S'.
select * from employees_us where LastName like 's%';

--2) Find Employees whose First Name ends with 'a'.
select * from employees_us where firstname like '%a';

--3) Find Employees whose Department contains 'Eng'.
select * from employees_us where department like '%eng%';

--4) Find Employees whose Last Name is exactly 5 characters long.
select * from employees_us where lastname like '_____';

--5) Find Employees whose First Name starts with 'C' or 'D'.
select * from employees_us where firstname like '[cd]%';

--6) Find Employees whose Last Name contains 'son'.
select * from employees_us where lastname like '%son%';

--7) Find Employees whose First Name contains the letter 'i' as the second character.
select * from employees_us where firstname like '_i%';

--8) Find Employees whose Last Name starts with any letter between 'A' and 'L'.
select * from employees_us where lastname like '[a-l]%'

--9) Find Employees whose First Name does not contain 'o'.
select * from employees_us where firstname not like '%o%'

--10) Find Employees whose Last Name ends with 'a' and is exactly 5 characters long.
select * from employees_us where lastname like '____a';

select * from employees_us

--11) Find Employees whose Department starts with 'Mar' and ends with 'ing'.
select * from employees_us where Department like 'Mar%ing';

--12) Find Employees whose First Name has an 'a' in the third position.
select * from employees_us where firstname like '__a%';

--13) Find Employees whose Last Name starts with 'Br' or 'Bl'.
select * from employees_us where lastname like 'Br%' or lastname like 'Bl%';

--14) Find Employees whose First Name starts with a vowel.
select * from employees_us where firstname like '[aeiou]%';

--15) Find Employees whose First Name does not start with a consonant.
select * from employees_us where firstname not like '[^aeiou]%'

--16) Find Employees whose First Name starts with a consonant.
select * from employees_us where firstname not like '[aeiou]%'

-- CASE Statement 
-- Create the Products table
--CREATE TABLE Products (
--    ProductID INT PRIMARY KEY,
--    ProductName VARCHAR(50),
--    Category VARCHAR(20),
--    Price DECIMAL(10, 2),
--    StockQuantity INT,
--    Supplier VARCHAR(50),
--    Rating DECIMAL(3, 1)
--);

---- Insert data into the Products table
--INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity, Supplier, Rating) VALUES
--(1, 'Wireless Mouse', 'Electronics', 25.99, 150, 'Tech Supplies', 4.5),
--(2, 'Office Chair', 'Furniture', 120.00, 85, 'Comfort Co', 4.7),
--(3, 'Water Bottle', 'Accessories', 15.00, 250, 'AquaGear', 4.3),
--(4, 'Laptop Backpack', 'Accessories', 45.99, 200, 'GearUp', 4.6),
--(5, 'Gaming Laptop', 'Electronics', 999.99, 45, 'Tech Supplies', 4.8),
--(6, 'Desk Lamp', 'Furniture', 35.00, 120, 'LightHouse', 4.2),
--(7, 'Bluetooth Speaker', 'Electronics', 59.99, 95, 'SoundWave', 4.4),
--(8, 'Standing Desk', 'Furniture', 250.00, 50, 'Comfort Co', 4.9),
--(9, 'Fitness Tracker', 'Electronics', 129.99, 180, 'FitTech', 4.7),
--(10, 'Coffee Mug', 'Accessories', 9.99, 300, 'MugMasters', 4.1);

select * from Products;

-- CASE Statement 
-- eg 1 : add a column to categories each product into high, medium ,low based on the product price.

select *, case 
when Price > 500 then 'High'
when Price <= 500 and Price >=200 then 'Medium'
else 'Low'
end as [Price Category]
from Products;

-- EG: 2 Provide priority to each category & sort the data according to that priority 
SELECT * FROM PRODUCTS ORDER BY 
case 
	when Category in ('Electronics') then 1 
	when category in ('Furniture') then 2 
	else 3 
end

SELECT * FROM PRODUCTS ORDER BY 
case 
	when Category in ('Electronics') then 1 
	when category in ('Furniture') then 2 
	when Category in ('Accessories') then 3 
end


-- nested case statements 

--We need to group the data based on the column category and price into different categories i.e., affordable and premium 

select * ,
case 
	when Category = 'Electronics' then 
		case 
			when Price >= 300 then 'Premium Electronics.'
			else 'Affordable Electronics'
		end
	when Category = 'Furniture' then 
		Case 
			When Price >= 250 then 'Premium Furniture.'
			else 'Affordable Furniture.'
		end 
	when Category = 'Accessories' 
		Case 
			When Price >=25 then 'Ppremium Accessories'
			else 'Affordable Accessories'
		end
end as [Groups] 
from Products 


-- SQL DATATYPES ==========================
--Using the datatypes not only fit the data into the column but also it should take up less memory in the storage.
--so we must choose the right datatype.Thats more crucial when  we work with the large volume of data 

-- To store String Data -> we can choose char, varchar , nchar, nvarchar 
-- for gender : m or f means we can go for char(1)
-- for student name : variable length character -> varchar(255)
-- nchar(1) it support uncicode character 
-- nvarchar(256) , it support the unicode character 

-- To store the Number types ->  we can choose int, bignint, tinyint, decimal(p,s) ,smallint

-- for age : tinyint range from 0-255 so we can use tinyint. we can use int as well but takes up 4 bytes but the tinyint takes up only 1 byte 
-- for age of tree/building : smallint 
-- for cost: decimal(p,s) : p-> represent the no of digits , s represents no of decimal places 
-- 999.99 decimal(5,2) 

-- for date -> we can use the data 
--for time -> we can use the time datatype 
--for date and time , we can use the  datetime or timestamp datatype as well according to our need.

-- ============================= Data type ends ===========================

-- Creating the table 
CREATE DATABASE STUDENT
create table student_details (
	Student_Name nvarchar(256),
	Gender char(1),
	Age tinyint,
	Event_Date date,
	Distance decimal(5,2),
	Clock_Time time
)

SELECT * FROM student_details;

--insert into student_details (Student_Name, Gender,Age, Event_Date, Distance, Clock_Time)
--Values ('Natarajan', 'M', 32, '2025-01-05', '21.4','02:12:30')

--insert into student_details 
--values('Jayant', 'M', 28,'2025-04-02','19.5','03:01:58'),('Mahesh','F',31,'2025-05-01','20.5','3:05:01')

select * from information_schema.columns where table_name = 'student_details'


-- Copying data from the existing table to new table 
-- case 1 : The new table doesn't exist 
-- case 2 : the table structure exists 

select * from student_details;

select * from sales;

-- we can create new table which is the replica of the sales table. 
select * into new_sales_table from sales;

select * from new_sales_table;

-- what if we want the certain columns to be copied from the existing table to new table.

-- Certain columns to be copied 

--drop table new_sales_table 

select productid, quantity into new_sales from dbo.sales ;

select * from new_sales;


--Case 2 :  how do we have to copy the table structure but not the data 
select top 0 * into new_sales_table from sales; 

select * from new_sales_table; 

-- how do export the records from the table to new table which is existing now. 
insert into new_sales_table select * from sales;

select * from new_sales_table; -- here the data get loaded. 

-- copying certain column in the existing tab;e 

select * into sales_table_2 from sales where 1 = 0 ;

select * from sales_table_2;

-- lets export specific column data fro the table to the sales_table_2. 
insert into sales_table_2 (Productid, Quantity) select Productid, Quantity from sales;


-- SUB-QUERIES: 
--CREATE TABLE Customers (
--    customer_id INT PRIMARY KEY,
--    customer_name VARCHAR(100),
--    email VARCHAR(100)
--);



--CREATE TABLE Orders (
--    order_id INT PRIMARY KEY,
--    customer_id INT,
--    order_date DATE,
--    amount DECIMAL(10, 2),
--    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
--);



---- Insert data into Customers table
--INSERT INTO Customers (customer_id, customer_name, email)
--VALUES 
--(1, 'Alice Smith', 'alice@example.com'),
--(2, 'Bob Johnson', 'bob@example.com'),
--(3, 'Charlie Brown', 'charlie@example.com');

---- Insert data into Orders table
--INSERT INTO Orders (order_id, customer_id, order_date, amount)
--VALUES 
--(101, 1, '2024-07-15', 250.00),
--(102, 1, '2024-08-05', 300.00),
--(103, 2, '2024-08-10', 150.00),
--(104, 3, '2024-06-25', 100.00);


-- SUB-QUERIES -> QUERY INSIDE A QUERY -> THIS WAY WE CAN SOLVE THE BIGGER PROBLEM STEP BY STEP 

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;

-- CUSTOMERS WHO ORDER IN THE MONTH OF 8 

SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE ORDER_DATE BETWEEN '2024-08-01' AND '2024-08-31')


-- CUSTOMERS WHO NOT ORDER IN THE MONTH OF 8 
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT ORDER_DATE  BETWEEN '2024-08-01' AND '2024-08-31')


-- EMPLOYEES WHO ARE PAID ABOVE THE AVERAGE 
SELECT * FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--CONSTRAINTS 
-- IS A CONDITION THAT CAN BE APPLIED ON THE TABLE COLUMN AND THESE CONDITIONS ARE FOLLOWED WHILE INSERTING THE RECORDS INTO THE TABLE. 
-- THERE ARE VARIOUS KINDS OF CONSTRAINTS WE CAN APPLY.  

-- 1. NOT NULL - Constraints 

--create database constraints 

use constraints ;

-- case 1: creation of table 

create table test_not_null (
EID int not null,
age tinyint,
firstname nvarchar(255)
)

select * from test_not_null;

select * from information_schema.columns where table_name = 'test_not_null';

insert into test_not_null values(1,20,'Natraj')
insert into test_not_null values(null, 25,'Karikalan') -- error comes says eid column does not nullable as per the column constraint

truncate table test_not_null;

select * from test_not_null;


-- case 2 : table already exist 

alter table test_not_null 
alter column firstname varchar(256) not null

insert into test_not_null values(2, 25,null) -- throws error like firstname column is not nullable 
insert into test_not_null values(3,30,'Natarajan Thanaraj')

select * from test_not_null;


-- UNIQUE Constraint 
--this constraint ensures that column values are unique. if the table column has any values already like our feed, then it gives error and doesn't allow;

--Case 1: it ensures that no duplicates in the column which has unique constraint enabled. 
select * from test_unique;

alter table test_unique
add unique (lastname)

-- case 2: We need a create table:
create table test_unique (
sid int unique,
age tinyint not null,
firstname varchar(255) not null unique,
lastname varchar(255)
)

select * from test_unique;

insert into test_unique values (1,21,'Natraj','Thanaraj')
insert into test_unique values (2,44,'Thnaraj','Thanaraj')

insert into test_unique values (null ,23, 'Kari','Kalan') -- throw error due to sid column is unique..but i entered the duplicate value 

insert into test_unique values (null, 22, 'abcd', 'Raj' ) 

truncate table test_unique;



-- check constraint: 
-- it check for certain conditions that can be applied on the table column, if these conditions are not folowed, 
-- then the records will not be inserted into the table.

-- Case 1: Table doesn't exist 

create table test_check (
eid int, 
first_name varchar(255) ,
age tinyint check(age>=18)
)

insert into test_check values (1, 'natarajan', 15) -- givees error due to age is 15 it violated the condition so insert statement not executed. 
insert into test_check values (1,'karikalan',26) -- it executed 

-- Case 2 : 
update test_check set eid = 11 where eid = 1 ;
alter table test_check 
add check (eid>5)

insert into test_check values (3,'Nithin',25)
insert into test_check values (7,'Nithin',25)


-- default constraint 
-- this constraint is used to provide the default value for the specific colun when the records are inserted with no values in the specific column 
-- case : 1 

create table test_default (
eid int default 5, 
first_name varchar(255) default 'Rohit',
lastname varchar(255),
age tinyint
)

insert into test_default values (1,'Nithin', 'Jain',20)

insert into test_default (lastname, age )values ('nitro',34)

select * from test_default; 

insert into test_default (lastname) values ('leela')

-- case2: the table exist already .how to set up the default value to the age column 

alter table test_default 
add default 25 for age 

select * from test_default; 



--Primary key and Foreign key 
-- primary key is used to distinguish between any two records in a given table so not null and no duplicates 
-- Foreign key may have null or duplicates as well. The values in the foreign key is subset of primary key column values 

-- Primary Key Constraint  -> no null and no duplicates 

-- Case 1 : when new table created : 

create table test_pk_1 (
eid int primary key ,
gender char(1),
age tinyint,
firstname varchar(255)
)

insert into test_pk_1 values (1,'M',22,'Nitro')

insert into test_pk_1 values (1, 'F' , 22 , 'Rani') -- error for duplicate entry on the primary key column 

insert into test_pk_1 values (null, 'M' , 24 , 'Raniiii')  -- error due to primary key column doesnt allow nulls 

--Case 2 : Table already exist 
alter table test_pk_1 
add primary key (age)


create table test_pk_2 (
sid int not null,
age tinyint not null,
firstname varchar(255)
)

alter table test_pk_2 
add primary key (sid)


-- Foreign	Key Constraint 
--Case 1 : New table to be createed with the foreign key relationship 

create table test_primary_key (
ID int Primary key ,
name varchar(255)
)

insert into test_primary_key values (1, 'Nitro'),(2,'Kari'),(3, 'Leela')

select * from test_primary_key;

create table test_foreign_key (
id int foreign key references test_primary_key(id),
course varchar(255)
)

insert into test_foreign_key values (null, 'B')

select * from test_foreign_key 

insert into test_foreign_key values (5, 'B')

--Case 2 : 

create table test_foreign_key_2 (ID INT, COURSE VARCHAR(255))

ALTER TABLE test_foreign_key_2
ADD FOREIGN KEY (ID) REFERENCES test_primary_key(id)

select * from test_foreign_key_2;


-- SQL ORDER OF EXECUTION :

SELECT * FROM EmployeeRecords;

select distinct top 1 department, avg(salary) as avg_salary
from EmployeeRecords 
where Salary > 60000 
group by department 
having avg(salary) >70000
order by department 

-- Here order of execution is  matters : 

-- from and join 
-- where 
-- group by 
-- having 
-- select 
-- distinct 
-- order by 
-- top 


select distinct top 1 department, avg(salary) as avg_salary
from EmployeeRecords 
where Salary > 60000 
group by department 
having avg_salary >70000
order by department 

-- Invalid column name 'avg_salary'.. Due to having clause execution before the select, this error occurs. 
-- So the execution matters in the SQL QUERYING 


