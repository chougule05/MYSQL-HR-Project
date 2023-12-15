use hr;

#1.Write a stored procedure to retrieve all employees from the Employees table for a given department ID.

delimiter $$
create procedure get_empy(in give_id int(6))
begin
	select *from employees where DEPARTMENT_ID=give_id;
end;
$$
delimiter ;

call get_empy(100);
select department_id from employees; 

###########################################################################################
# 2. Create a function that calculates the total salary expenditure for a given department ID.

delimiter $$
create function get_sal(d_id int(6))
returns int
begin
	declare paisa int(10);
	select sum(salary) into paisa from employees
    where DEPARTMENT_ID=d_id;
    return paisa;
end;
$$    
delimiter ;

drop function get_sal;
select get_sal(100);

#########################################################################################################################
# 3.Develop a stored procedure that accepts an employee ID as an input parameter and 
# increases the salary of that employee by a specified percentage.

delimiter $$
create procedure inc_sal(in emp_id int(6))
begin
	update employees set salary= salary+ salary*0.5 where employee_id=emp_id;
end;
$$
delimiter ;

drop procedure inc_sal;
select *from employees;
call inc_sal(100);

###########################################################################################################################
# 4.Write a function to determine the average salary for employees in a specific job title category.

delimiter $$
create function get_avgsal(j_t varchar(20))
returns int
begin
	declare paisa int(20);
    select avg(salary) into paisa from employees e inner join jobs j on
    j.job_id=e.job_id where j.JOB_TITLE=j_t;
    return paisa;
end;
$$
delimiter ;    

select *from jobs;
select get_avgsal('stock clerk');

drop function get_avgsal;

########################################################################################################################
# 5.Create a stored procedure that takes an employee's first name and last name as input parameters and 
# returns the full name in uppercase letters.

delimiter $$
create procedure get_full(in f_name varchar(10) , in l_name varchar(10))
begin
	select upper(concat(first_name,' ', last_name)) as full_name from employees
    where first_name = f_name and last_name = l_name;
end;
$$
delimiter ;

call get_full('steven','king');    

########################################################################################################################
#6. Write a stored procedure to insert a new employee into the Employees table with the provided first name, last name, and department ID.
desc employees;

delimiter $$
create procedure up_emp(in ep_id decimal(6,0), in f_name varchar(20), in l_name varchar(25), 
in em varchar(25), in hire date, in j_id varchar(10),in dept_id decimal (4,0))
begin
	insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID, DEPARTMENT_ID) values
    (ep_id,f_name,l_name,em,hire,j_id,dept_id);
end;
$$
delimiter ;

call  up_emp(195,'vibhi','chougule','vibhi@.com','2022-10-01','project',1);
select *from employees where department_id=1;
select *from employees;
########################################################################################################################
#7.Create a function to calculate the total number of employees in a specific department.

delimiter $$
create function get_tot(d_name varchar(25))
returns int
begin
	declare mansa int(10);
    select count(*) into mansa from employees e inner join 
    departments d on d.DEPARTMENT_ID=e.DEPARTMENT_ID
	where DEPARTMENT_NAME=d_name;
    return mansa;
end;
$$
delimiter ;    

select get_tot('it');
select *from departments;

########################################################################################################################
#8.Develop a stored procedure that accepts an employee ID as input and deletes that employee's record from the Employees table.

delimiter $$
create procedure del_kar(in emp_id int(6))
begin 
	delete from employees where employee_id=emp_id;
end;
$$
delimiter ;

select *from employees where employee_id=1;
call del_kar(1);

########################################################################################################################
# 9.Write a function to determine the highest salary in the Employees table.

delimiter $$
create function high_sal()
returns int
begin
	declare paisa int(10);
    select max(salary) into paisa from employees;
    return paisa;
end;
$$
delimiter ;

select high_sal();
drop function high_sal;
select max(salary) from employees;


########################################################################################################################
# 10.Create a stored procedure that takes a department ID as an input parameter and 
# returns the list of employees sorted by their salary in descending order within that department.

delimiter $$
create procedure kamgar(in d_id int(10))
begin
	select *from employees where department_id=d_id order by salary asc;
end;
$$
delimiter ;

call kamgar(100);
    
########################################################################################################################
# 11.Write a stored procedure to update the job title of an employee based on their employee ID.

delimiter $$
create procedure up_job(in emp_id int(10))
begin 
	update jobs set job_title = 'it' where job_id in (
    select job_id from employees 
    where employee_Id = emp_id);
end;
$$
delimiter ;

select *from jobs;
drop procedure up_job;
call up_job(110);    
rollback;
    
########################################################################################################################
#12.Create a function that returns the number of employees hired in a specific year.

delimiter $$
create function ret_emp(saal int(6))
returns int
begin
	declare num int(10);
    select count(*) into num from employees
    where year(HIRE_DATE)=saal;
    return num;
end ;
$$
delimiter ;

select year(hire_date) from employees;    
select ret_emp(1987);

########################################################################################################################
# 13.Develop a stored procedure that accepts an employee ID as input and 
# retrieves the employee's details, including their name, department, and salary.

delimiter $$
create procedure detail(in emp_id int(6))
begin
	select *from employees where EMPLOYEE_ID=emp_id;
end;
$$
delimiter ;

select *from employees where employee_id= 100;
call detail(100);   

########################################################################################################################
# 14.Write a function to calculate the average tenure (in years) of employees in the company.

delimiter $$
create function avg_tenure()
returns int
begin 
	declare saal int(10);
    select avg(year(curdate())-year(hire_date)) into saal from employees;  
    return saal;
end;
$$
delimiter ;    
    
drop function avg_tenure;
select avg_tenure();    
 

########################################################################################################################
# 15.Create a stored procedure that takes a department ID as an input parameter and
#returns the department name along with the count of employees in that department.
;
delimiter $$
create procedure count_mem(in dept_id int(10))
begin
	select count(*) ,d.department_name from employees e 
    inner join departments d on d.department_id = e.department_id 
    where d.department_id= dept_id group by department_name;
end;
$$
delimiter ;

drop procedure count_mem;
call count_mem(90);
    
select count(*) ,d.department_name from employees e inner join departments d on d.department_id = e.department_id where d.department_id= 90;



   

########################################################################################################################
#  16.Write a stored procedure to retrieve the top N highest-paid employees in the company, where N is an input parameter.

delimiter $$
create procedure upar_sal(in num_pp int(6))
begin
	select concat(first_name,' ',last_name) as full_name from employees order by salary desc limit num_pp;
end;
$$
delimiter ;
drop procedure upar_sal;
call upar_sal(5);



########################################################################################################################
# 17.Create a function that calculates the total bonus amount for all employees based on their performance ratings.


 

########################################################################################################################
# 18.Develop a stored procedure that accepts a salary threshold as an input parameter and 
# retrieves all employees with salaries above that threshold.

delimiter $$
create procedure e_d(in sal int(6))
begin
	select * from employees where salary>sal;
    
end;
$$
delimiter ;

drop procedure e_d;
call e_d(6000);


########################################################################################################################

# 19.Write a function to determine the average age of employees in the company based on their birthdates.


########################################################################################################################
# 20.Create a stored procedure that takes an employee's last name as an input parameter and 
# returns all employees with a similar last name.

delimiter $$
create procedure emp(in l_name varchar(20))
begin
	select concat(first_name,' ',last_name) as full_name from employees where last_name=l_name;
end;
$$
delimiter ;

call emp('king');    
    
########################################################################################################################
# 21. Write a stored procedure to update the email address of an employee based on their employee ID.

delimiter $$
create procedure em_emp(in emp_id int(10))
begin
	update employees set email = concat(emp_id,'@.com') where employee_id=emp_id;
end;
$$
delimiter ;

call em_emp(100);    
select *from employees where EMPLOYEE_ID=100;

########################################################################################################################
# 22.Create a function that calculates the total experience (in years) of all employees combined in the company.

delimiter $$
create function tot_exp()
returns int
begin
	declare saal int(10);
    select sum(timestampdiff(year,hire_date,curdate())) as total_experience into saal
    from employees ;
    return saal;
end;
$$
delimiter ;

drop function tot_exp;
select tot_exp();    

########################################################################################################################
# 23.Develop a stored procedure that accepts a department ID as input and 
# returns the department name along with the average salary of employees in that department.

select department_id from employees;


delimiter $$
create procedure emp_d(in dept_id int(6))
begin
	select d.department_name, avg(salary) from employees e 
    inner join departments d on d.department_id = e.department_id
    where e.DEPARTMENT_ID=dept_id group by d.department_id;
    
end;
$$
delimiter ;   

drop procedure emp_d;
call emp_d(10);

########################################################################################################################
# 24.Write a function to determine the number of employees who have been with the company for more than a specified number of years.

delimiter $$
create function salbt(yr int(6))
returns int
begin
	declare exp int(6); 
	select count(*)into exp from employees where (year(curdate())-year(hire_date))>yr;
	return exp;
end;
$$
delimiter ;
    
select salbt(20);

########################################################################################################################
# 25.Create a stored procedure that takes a job title as an input parameter and returns the count of employees holding that job title.

delimiter $$
create procedure tot_e(in j_t varchar(20))
begin 
	select count(*) as num_emp from employees where job_id in(
    select job_id from jobs where job_title=j_t);
end;
$$
delimiter ;

drop procedure tot_e;
select job_title from jobs;
call tot_e('it');


########################################################################################################################
# 26.Write a stored procedure to retrieve the details of employees who have a salary within a specified range.

delimiter $$
create procedure e_d(in l_ran int(6), in h_ran int(6))
begin
	select *from employees where (salary>l_ran and salary<h_ran);
end;
$$
delimiter ;

call e_d(2000,6000);    

########################################################################################################################
# 27.Create a function that calculates the total number of working hours for an employee in a given month.



# 28.Develop a stored procedure that accepts an employee ID as input and retrieves the employee's department name and manager's name.

delimiter $$
create procedure e_de(in emp_id int(6))
begin
	select e.employee_id, concat(first_name,' ',last_name), d.department_name, (select concat(first_name,' ',last_name) from employees where manager_id=employee_id) 
    from employees e inner join departments d on d.department_id = e.department_id 
    where employee_id=101
    group by department_name;

end;
$$
delimiter ;

drop procedure e_de;
select manager_id from employees;
select *from employees; 
call e_de(104);

########################################################################################################################
# 29.Write a function to determine the total number of employees hired in each year, grouped by the year of hire.

delimiter $$
create function num_emp_hire()
returns int
begin
	declare num_emp int(6);
    select group_concat(count(*),year(hire_date)separator',') into num_emp from employees ;
    return num_emp;
end;
$$
delimiter ;

drop function num_emp_hire;
select num_emp_hire();    
    
########################################################################################################################
# 30.Create a stored procedure that takes a city name as an input parameter and returns the list of employees residing in that city.

delimiter $$
create procedure emp_name(in place varchar(20))
begin
	select concat(first_name,'  ',last_name) as full_name from employees where department_id in    
    (select department_id from departments where location_id in    
    (select location_id from locations where city=place));
end;
$$
delimiter ;

drop procedure emp_name;
call emp_name('Seattle');
select city from locations;

#select concat(first_name,'  ',last_name) as full_name from employees e inner join departments d on d.department_id= e.department_id inner join locations l on l.location_id=d.location_id where l.city=place;


########################################################################################################################
# 31.Write a stored procedure that calculates the average salary increase percentage for employees 
#   who have been with the company for more than five years.

delimiter $$
create procedure new_sal()
begin
	select salary+(select avg(salary) from employees) as inc_sal from employees where timestampdiff(year , hire_date , current_date())>5;
end;
$$
delimiter ;    

call new_sal();
select *from employees;	

drop procedure new_sal;


################################################################################################################################################################################################################################################
# 32. Create a function that calculates the total sales revenue generated by each employee in the Sales department, considering both individual and team contributions.





# 33. Develop a stored procedure that accepts a date range as input and retrieves all employee attendance records within that period, including late arrivals and early departures.

#34. Write a function that determines the average number of projects handled by employees in each department and identifies departments with exceptionally high or low project volumes.

#35. Create a stored procedure that takes a job title as an input parameter and returns the list of employees holding that job title, along with the total compensation considering bonuses and allowances.

# 36. Write a stored procedure that calculates the performance rating for each employee based on various criteria, such as project completion, client feedback, and adherence to deadlines.

#37. Create a function that determines the average time taken to resolve customer issues for each support agent, considering different issue categories and urgency levels.

#38. Develop a stored procedure that accepts a date range and a specific project ID as input and retrieves all employee work hours dedicated to that project within the given period.

#39. Write a function that calculates the employee turnover rate for each department, considering the number of new hires and the number of departures over a specified time frame.

#40. Create a stored procedure that takes a location as an input parameter and returns the list of employees who have been involved in projects related to that location, along with their project contributions and performance ratings.
