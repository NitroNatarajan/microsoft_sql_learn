
-- Question set 1 :
-- SQL Basic Question 

--create database [SQL BASIC QUESTIONS]

USE [SQL BASIC QUESTIONS]


--CREATE TABLE Employees (
--    EmployeeID INT PRIMARY KEY,
--    FirstName VARCHAR(50),
--    LastName VARCHAR(50),
--    Department VARCHAR(50),
--    Salary DECIMAL(10, 2)
--);

--INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
--(1, 'John', 'Doe', 'HR', 55000.00),
--(2, 'Jane', 'Smith', 'IT', 75000.00),
--(3, 'Emily', 'Jones', 'Finance', 65000.00),
--(4, 'Michael', 'Brown', 'IT', 80000.00),
--(5, 'Sarah', 'Davis', 'HR', 60000.00),
--(6, 'David', 'Wilson', 'Finance', 70000.00),
--(7, 'Laura', 'Garcia', 'IT', 72000.00),
--(8, 'Robert', 'Miller', 'HR', 58000.00),
--(9, 'Sophia', 'Martinez', 'Finance', 67000.00),
--(10, 'James', 'Anderson', 'IT', 81000.00);



SELECT * FROM eMPLOYEES ;

--1) How do you select all columns from the Employees table?
SELECT * FROM Employees;

--2) How do you select only the FirstName and Last Name columns from the Employees table?
SELECT FIRSTNAME, LASTNAME FROM Employees;

--3) How do you find all employees who work in the 'IT' department?

SELECT * FROM Employees WHERE DEPARTMENT = 'IT'
SELECT * FROM Employees WHERE DEPARTMENT LIKE 'IT'


--4) How do you select employees with a salary greater than 70,000?

SELECT * FROM EMPLOYEES WHERE SALARY > 70000; 

--5) How do you sort the results by Last Name in ascending order?

SELECT *  FROM EMPLOYEES ORDER BY LASTNAME 

--6) How do you select distinct departments from the Employees table?

SELECT DISTINCT DEPARTMENT FROM EMPLOYEES;

--7) How do you count the number of employees in each department?

SELECT * FROM EMPLOYEES ;

SELECT DEPARTMENT, COUNT(*) AS NO_OF_EMPLOYEES FROM EMPLOYEES GROUP BY DEPARTMENT; 
SELECT DEPARTMENT, COUNT(EMPLOYEEID) AS NO_OF_EMPLOYEES FROM EMPLOYEES GROUP BY DEPARTMENT; 
--8) How do you find the maximum salary in the Employees table?

SELECT MAX(sALARY) AS MAX_SALARY FROM EMPLOYEES
--9) How do you find the average salary of employees in the 'Finance' department?
SELECT AVG(SALARY) as Finanace_Avg_Salary  FROM EMPLOYEES WHERE DEPARTMENT = 'finance'


--10) How do you select employees whose last name starts with 'M'?
select * from employees where lastname like 'm%'


--Question set 2 

--1. How do you select employees who work in the 'IT' department and have a salary greater than 75,000?

select * from employees where department = 'IT' AND salary > 75000;


--2. How do you find employees who work in the 'HR' department or have a salary less than 60,000?

select * from employees where department = 'HR' OR Salary < 60000;

--3. How do you select employees who do not work in the 'Finance' department?
select * from employees where department != 'finance'
select * from employees where not department = 'finance'
--4. How do you find employees whose salary is between 60,000 and 70,000 and who work in the 'Finance' department?

select * from employees where department = 'FINANCE' AND salary between 60000 and 70000;

--5. How do you find employees who work in the 'IT' department and do not have a salary greater than 80,000?
SELECT * FROM EMPLOYEES WHERE DEPARTMENT = 'IT' AND NOT SALARY  > 80000;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT = 'IT' AND  SALARY  <= 80000;
--6. How do you find employees who work in the 'HR' or 'Finance' departments and have a salary greater than 65,000?
SELECT * FROM EMPLOYEES WHERE DEPARTMENT IN ('HR','FINANCE') AND Salary > 65000;

--7. How do you select employees whose last name starts with 'D' and do not work in the 'HR' department?

select * from employees where LASTNAME like 'd%' and department != 'HR'

SELECT * FROM EMPLOYEES

--8. How do you find employees who do not work in the 'IT' department and have a salary greater than 70,000?

SELECT * FROM EMPLOYEES WHERE DEPARTMENT != 'IT' AND SALARY > 70000

--9. How do you select employees who work in the 'IT' department and either have a salary greater 
--than 75,000 or have the first name 'Laura'?

SELECT * FROM EMPLOYEES WHERE DEPARTMENT = 'it' and (Salary > 75000 or firstname like 'Laura')

--10. How do you find employees who do not work in the 'HR' or 'IT' departments?
select * from employees where  department not in ('it','hr') 


