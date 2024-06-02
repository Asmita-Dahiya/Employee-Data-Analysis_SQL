-- create a database named Practice:
create database practice;

-- select database:
use practice;

-- Write a query to create an employee table with employee ID, first name, last name, job ID, salary, manager ID, and department ID fields:
create table employee_datasets (
emp_id varchar(10) not null primary key,
f_name varchar(20),
l_name varchar(20),
job_id varchar(10),
salary int,
manager_id varchar(10),
dept_id varchar(10));

describe employee_datasets;

-- Write a query to insert values into the employee table:
insert into employee_datasets (
emp_id, f_name, l_name, job_id, salary, manager_id, dept_id)
values 
('101', 'ankit', 'jain', 'HP124', 200000, 2, 24),
('102', 'sarvesh', 'patel', 'HP123', 150000, 2, 24),
('103', 'krishna', 'gee', 'HP125', 500000, 5, 44),
('104', 'rana', 'gee', 'HP122', 250000, 3, 54),
('105', 'soniya', 'jain', 'HP121', 400000, 1, 22),
('106', 'nithin', 'kumar', 'HP120', 300000, 4, 34),
('107', 'karan', 'patel', 'HP126', 300001, 2, 34),
('108', 'shilpa', 'jain', 'HP127', 300001, 5, 24),
('109', 'mukesh', 'singh', 'HP128', 300001, 4, 44);

select * from employee_datasets;

-- Write a query to find the first and last names of every employee whose salary is higher than the employee with the last name Kumar:
select f_name, l_name from employee_datasets 
where salary> (select salary from employee_datasets where l_name ='kumar');

-- Write a query to display the employee ID, first name, last name and salary of every employee whose salary is greater than the average:
select emp_id, f_name, l_name, salary from employee_datasets 
where salary> ( select avg(salary) from employee_datasets);

-- Write a query to display the employee ID and first name of every employee whose salary is higher than the salary of the JOB_ID = HP122 and sort the results in the ascending order of the salary:
select emp_id, f_name, salary from employee_datasets 
where salary > ALL (select salary from employee_datasets where job_id ='HP122') 
order by salary;

-- Write a query to display the first name, employee ID, and salary of the three employees with the highest salaries:
select distinct f_name, emp_id, salary from employee_datasets a
where 3>= (select count(distinct salary) from employee_datasets b
where b.salary >= a.salary) order by a.salary desc;

-- or 
select f_name, emp_id, salary from employee_datasets
order by salary desc
limit 3;

-- add 3 new columns to table i.e. role, department and employee rating:
alter table employee_datasets
Add role varchar(40),
Add dept varchar(40),
Add emp_rating int;

describe employee_datasets;

select * from employee_datasets;

-- insert values in new columns:
update employee_datasets set role="senior data scientist", dept="retail", emp_rating=3 where emp_id='101';
update employee_datasets set role="junior data scientist", dept="retail", emp_rating=4 where emp_id='102';
update employee_datasets set role="associate data scientist", dept="finance", emp_rating=3 where emp_id='103';
update employee_datasets set role="senior data scientist", dept="automotive", emp_rating=5 where emp_id='104';
update employee_datasets set role="lead data scientist", dept="automotive", emp_rating=2 where emp_id='105';
update employee_datasets set role="lead data scientist", dept="finance", emp_rating=3 where emp_id='106';
update employee_datasets set role="senior data scientist", dept="healthcare", emp_rating=5 where emp_id='107';
update employee_datasets set role="manager", dept="healthcare", emp_rating=5 where emp_id='108';
update employee_datasets set role="manager", dept="retail", emp_rating=2 where emp_id='109';

select * from employee_datasets;

-- SELECT EMP_ID, FIRST_NAME,ROLE,DEPT,EMP_RATING and calculate the maximum EMP_RATING in a department from the employee table using partition clause on department, Max function:
select emp_id, f_name, role, dept, emp_rating, max(emp_rating) over (partition by dept) as max_emp_rating from employee_datasets;

-- Display the employee’s ID, first name, role, and salary by finding the minimum and maximum salary of the employees using PARTITION BY clause, MIN, and MAX functions on role and salary fields respectively:
select emp_id, f_name, role, salary, max(salary) over (partition by role) as max_salary, min(salary) over (partition by role) as min_salary from employee_datasets;

-- Display the employee’s ID, first name, department, and employee rating by calculating the average employee rating and the total number of records in a department using PARTITION BY clause, AVG, and COUNT functions on department and employee rating fields:
select emp_id, f_name, dept, emp_rating, avg(emp_rating) over (partition by dept) as avg_rating, count(*) over (partition by dept) as total_no_of_records from employee_datasets;

-- Display the employee’s Id, first name, department, and employee rating by calculating the total employee rating in a department using PARTITION BY clause and SUM function on the department and the employee rating fields respectively:
select emp_id, f_name, dept, emp_rating, sum(emp_rating) over (partition by dept) as total_emp_rating from employee_datasets;

-- Display the employee’s ID, first name, department, and employee rating by assigning a rank to all the employees based on their employee rating using ORDER BY clause, RANK, and DENSE RANK functions on the employee rating field:
select emp_id, f_name, dept, emp_rating, rank() over (order by emp_rating) as emp_rating_rank, dense_rank() over (order by emp_rating) as emp_rating_dense_rank from employee_datasets;

-- Display the employee’s ID, first name, department, employee rating by assigning a number to each employee in descending order of their employee rating using ORDER BY clause and ROW NUMBER function on the employee rating field:
select emp_id, f_name, dept, emp_rating, row_number() over (order by emp_rating desc) as emp_id_asc_row_number from employee_datasets;

