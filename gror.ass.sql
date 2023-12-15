use hr;


#Write a SQL query to find the number of employees hired in each year.

select year(hire_date)as join_year,count(*) as tot_emp
from employees 
group by join_year;

########################################################################################################################################
#Write a SQL query to find the number of employees in each department.

select department_id as dept, count(*) as tot_emp
from employees 
group by dept;

########################################################################################################################################
#Write a SQL query to find the department with the highest total salary.

select department_id,sum(salary)
from employees
group by department_id;

###################################################################################################################################
#Write a query to list the number of jobs available in the employees table.

select job_id, count(*) as tot_emp
from employees
group by job_id;

####################################################################################################################################
#Write a query to get the total salaries payable to employees.

select sum(salary) as tot_sal
from employees;

###################################################################################################################################
#Write a query to get the minimum salary from the employees table.

select concat(first_name,' ',last_name) as full_name, salary
from employees
order by salary limit 1;

####################################################################################################################################
#Write a query to get the maximum salary of an employee working as a Programmer.

select max(salary) from employees
group by job_id
having job_id = 'IT_prog';
 
######################################################################################################################################
 #Write a query to get the average salary and number of employees working the department 90. 
 
 select department_id,avg(salary)
 from employees
 group by department_id;
 
#################################################################################################################################
#Write a query to get the highest, lowest, sum, and average salary of all employees. 

select max(salary), min(salary), sum(salary), avg(salary) from employees;

####################################################################################################################################
#Write a query to get the number of employees with the same job

select job_id, count(*) as tot_emp from employees
group by job_id;

###################################################################################################################################
#Write a query to get the difference between the highest and lowest salaries. 

select max(salary) - min(salary) as diff from employees;

##################################################################################################################################
#Write a query to find the manager ID and the salary of the lowest-paid employee for that manager. 

select manager_id, concat(first_name,' ',last_name) as full_name, salary from employees
order by salary
asc limit 1;

##################################################################################################################################
#Write a query to get the department ID and the total salary payable in each department.

select  department_id,sum(salary) as tot_sal from employees group by department_id;

####################################################################################################################################
#Write a query to get the average salary for each job ID excluding programmer.

select job_id, avg(salary) from employees
where job_id !='it_prog' group by job_id ;

#################################################################################################################################
#Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only. 

select job_id, sum(salary) as tot_sal, max(salary), min(salary), avg(salary) 
from employees where department_id = 90
group by job_id;

###################################################################################################################################
#Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.

select job_id, max(salary) as max_sal from employees
group by job_id
having max_sal>=4000;

##################################################################################################################################
#Write a query to get the average salary for all departments employing more than 10 employees. 

select department_id, avg(salary), count(*) as tot_emp from employees 
group by department_id
having tot_emp>10;
