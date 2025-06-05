-- USING THE EMPLOYEES TABLE 

--Write a SQL query to select all columns and rows from the Employees table.
SELECT * FROM EMPLOYEES;

--Write a SQL query to find the names and email addresses of all employees who work in the department with DepartmentID = 101.
SELECT E.FIRSTNAME,E.LASTNAME,E.EMAIL , D.DEPARTMENTID ,D.DEPARTMENTNAME FROM EMPLOYEES E JOIN DEPARTMENTS D ON D.DEPARTMENTID = E.DEPARTMENTID WHERE D.DEPARTMENTID = 101

--Write a SQL query to find the total number of employees in the Employees table.
SELECT COUNT(EMPLOYEEID) AS [NO_OF_EMPLOYEES] FROM EMPLOYEES ;

--Write a SQL query to find the details of employees who were hired in the year 2020.
SELECT * FROM EMPLOYEES WHERE YEAR(HIREDATE) = '2020';

--Write a SQL query to update the salary of 'Jane Doe' to 90,000.
WITH JANE_ID AS (
SELECT EMPLOYEEID FROM EMPLOYEES WHERE FIRSTNAME LIKE 'JANE'
)
UPDATE EMPLOYEES 
SET SALARY = 90000 WHERE EMPLOYEEID = (SELECT * FROM JANE_ID)
