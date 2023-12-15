create database sbq;
use sbq;
use hr;

#1. Write a query to find the name (first_name, last_name) and the salary of the employees 
#who have a higher salary than the employee whose last_name='Bull'. 

select concat(first_name,' ',last_name), salary from employees where salary>
(select salary from employees where last_name='bull');

##########################################################################################################################################
#2. Write a query to find the name (first_name, last_name) of all employees who works in the IT department.

select concat(first_name,' ',last_name) from employees where department_id in
(select department_id from departments where DEPARTMENT_NAME='it');

######################################################################################################################################
#3. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department. 
#Hint : Write single-row and multiple-row subqueries

select *from employees where manager_id in
(select manager_id from departments where location_id in
(select location_id from locations where country_id in
(select country_id from countries where COUNTRY_NAME='United States of America')));

select *from departments;
select *from locations;
select *from countries;

#####################################################################################################################################
#4. Write a query to find the name (first_name, last_name) of the employees who are managers. 

select *from employees where job_id in
(select job_id from jobs where job_title like '%_ Manager%');

select *from jobs;

#####################################################################################################################################################
#5. Write a query to find the name (first_name, last_name), and salary of the employees 
# whose salary is greater than the average salary. 

select concat(first_name,' ',last_name)as full_name, salary from employees where salary>
(select avg(salary) from employees where salary);

#######################################################################################################################################################
#6. Write a query to find the name (first_name, last_name), and salary of the employees 
# whose salary is equal to the minimum salary for their job grade.

select concat(first_name,' ',last_name)as full_name, salary from employees where salary =
(select min(salary) from employees where salary);

 ######################################################################################################################################
#7. Write a query to find the name (first_name, last_name), and salary of the employees 
# who earns more than the average salary and works in any of the IT departments. 

select concat(first_name,' ',last_name)as full_name, salary from employees where salary>
(select avg(salary) from employees where DEPARTMENT_ID in (
select DEPARTMENT_ID from departments where DEPARTMENT_NAME='it'));

select*from departments;

####################################################################################################################################
#8. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell.

select concat(first_name,' ',last_name)as full_name, salary from employees where salary>(
select salary from employees where last_name='bell');

select *from employees;

###############################################################################################################################################
#9. Write a query to find the name (first_name, last_name), 
# and salary of the employees who earn the same salary as the minimum salary for all departments. 

select concat(first_name,' ',last_name)as full_name, SALARY, department_id from employees e where salary =
(select min(salary) from employees where e.DEPARTMENT_ID=DEPARTMENT_ID group by DEPARTMENT_ID );

select concat(first_name,' ',last_name)as full_name, SALARY, department_id from employees where salary =
(select min(salary) from employees);

select min(salary),department_id from employees group by department_id;


#######################################################################################################################################
#10. Write a query to find the name (first_name, last_name), and salary of the employees 
# whose salary is greater than the average salary of all departments.


select concat(first_name,' ',last_name) as full_name, salary, department_id from employees e where salary>
(select avg(salary) from employees where e.department_id=DEPARTMENT_ID group by department_id);

#######################################################################################################################
#11. Write a query to find the name (first_name, last_name) and salary of the employees
# who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). 
# Sort the results of the salary of the lowest to highest. 

select concat(first_name,' ',last_name) as full_name, salary, department_id from employees where salary>
(select max(salary) from employees where job_id ='sh_clerk')order by salary asc;
 
 select job_id from employees;

###################################################################################################################
#12. Write a query to find the name (first_name, last_name) of the employees who are not supervisors. 

select concat(first_name,' ',last_name) as full_name, salary, department_id from employees;

select job_title from jobs;

####################################################################################################################
#13. Write a query to display the employee ID, first name, last name, and department names of all employees. 

select employee_id, first_name, last_name, (
select department_name from departments d where e.DEPARTMENT_ID=d.DEPARTMENT_ID) as dept_name from employees e;

#################################################################################################################################
#14. Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.

select employee_id, first_name, last_name, salary, department_id from employees e where salary>
( select avg(salary) from employees where e.department_id=department_id group by department_id);

#################################################################################################################
#15. Write a query to fetch even numbered records from the employees table. 

SET @i = 0; 
SELECT i , employee_id, full_name FROM 
(SELECT @i := @i + 1 AS i, employee_id, concat(First_name,' ',last_name) as full_name  FROM employees)
a WHERE MOD(a.i, 2) = 0;

#################################################################################################################
#16. Write a query to find the 5th maximum salary in the employees table. 

select distinct salary from employees e where 5 =(
select count(distinct salary) from employees d where e.salary<=d.salary);

select distinct salary from employees where count(distinct salary) =5;

#################################################################################################################
#17. Write a query to find the 4th minimum salary in the employees table. 

select distinct salary from employees e  where 4=
(select count(distinct salary) from employees d where e.salary>=d.salary)  order by salary asc; 

#18. Write a query to select the last 10 records from a table. 

select * from employees where 5=
(select count(*) from employees limit 5);


#################################################################################################################
#19. Write a query to list the department ID and name of all the departments
# where no employee is working. 

select department_id, department_name from departments where department_id not in(
select department_id from employees) ;

select *from employees;
select *from departments;


#################################################################################################################
#20. Write a query to get 3 maximum salaries.

select distinct salary from employees e where 3>=(
select count(distinct salary) from employees a where e.salary<=a.salary order by salary) ;

 #################################################################################################################
#21. Write a query to get 3 minimum salaries. 

select distinct salary from employees e where 3>=
(select count(distinct salary) from employees a where a.salary<=e.salary order by salary);

#################################################################################################################
#22. Write a query to get nth max salaries of employees. 

select salary from employees e where 1 = 
(select count(distinct salary) from employees a where a.salary>=e.salary) order by salary;

#################################################################################################################
# 23. Write a query that returns all employees who have a salary greater than the average salary of their department.

select *from employees where salary> all
(select avg(salary) from employees group by department_id );

select avg(salary) from employees;

#################################################################################################################
#24.Write a query that returns the names of all departments that have more than 10 employees.

select department_name from departments d where 10< 
(select count(*) from employees e where e.department_id=d.department_id );

select *from departments;
#################################################################################################################
#25.Write a query that returns the names of all employees who work in departments that have a total salary greater than $1,000,000.

select  *from employees e where 1000000 <
(select sum(salary) from employees d where e.department_id=d.department_id group by d.department_id);



#################################################################################################################
#Write a query that returns the average salary of all employees who have been with the company for less than 3 years.

select avg(salary),concat(first_name,' ',last_name)as full_name from employees where 3>(
select timestampdiff(year,hire_date,curdate()) from employees)group by salary;






#################################################################################################################
#Write a query that returns the names of all employees who have the same manager as the employee with ID 123.






#################################################################################################################
#Write a query that returns the department name and average salary of the department with the highest average salary.

select (select department_name from departments d where e.department_id=d.department_id ) as dept_name, avg(salary) from employees e 
group by  department_id order by avg(salary) desc limit 1 ;


#################################################################################################################
#Write a query that returns the names of all employees who have a salary greater than the highest salary in the sales department.

select concat(first_name,' ',last_name) as full_name from employees where salary>
(select max(salary) from employees where department_id in (select department_id from departments where department_name='sales'));


select *from departments;

#################################################################################################################
#Write a query that returns the names of all employees who have a manager with a salary greater than $100,000.

select concat(first_name,' ',last_name) as full_name from employees where manager_id in(;



#Write a query that returns the names of all departments that have at least one employee who has been with the company for more than 5 years
#Write a query that returns the name and salary of the employee with the second-highest salary in the company.

select first_name,salary from employees where max(salary) <
(select max(salary) from employees);


