--CREAT AND IMPORT TABLES

DROP TABLE IF EXISTS salaries;
CREATE TABLE IF NOT EXISTS salaries (
  emp_no VARCHAR(30) NOT NULL PRIMARY KEY, 
  salary INT,
  from_date Date,
  to_date Date
); 

DROP TABLE IF EXISTS titles;
CREATE TABLE IF NOT EXISTS titles (
  emp_no VARCHAR(30) NOT NULL PRIMARY KEY, 
  title VARCHAR(30) NOT NULL, 
  from_date Date,
  to_date Date
); 

DROP TABLE IF EXISTS dept_emp;
CREATE TABLE IF NOT EXISTS dept_emp (
  emp_no VARCHAR(30) NOT NULL PRIMARY KEY, 
  dept_no VARCHAR(30) NOT NULL FOREIGN KEY, 
  from_date Date,
  to_date Date
); 

DROP TABLE IF EXISTS dept_manager;
CREATE TABLE IF NOT EXISTS dept_manager (
  dept_no VARCHAR(30) NOT NULL PRIMARY KEY, 
  emp_no VARCHAR(30) NOT NULL FOREIGN KEY, 
  from_date Date,
  to_date Date
); 

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees (
  emp_no VARCHAR(30) NOT NULL PRIMARY KEY,  
  birth_date Date,
  first_name VARCHAR(30) NOT NULL, 
  last_name VARCHAR(30) NOT NULL,
  gender VARCHAR(30) NOT NULL, 
  hire_date Date
); 

DROP TABLE IF EXISTS departments;
CREATE TABLE IF NOT EXISTS departments (
  dept_no VARCHAR(30) NOT NULL PRIMARY KEY, 
  dept_name VARCHAR(30) NOT NULL
); 

--1.List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no,employees.last_name,employees.first_name,employees.gender,salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no=salaries.emp_no

--2.List employees who were hired in 1986
SELECT employees.emp_no,employees.last_name,employees.first_name,employees.gender,employees.hire_date
FROM employees
WHERE EXTRACT(YEAR FROM employees.hire_date) = 1986

--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT departments.dept_no,departments.dept_name,employees.emp_no,employees.last_name,employees.first_name,dept_manager.from_date,dept_manager.to_date
FROM dept_manager
FULL JOIN departments ON dept_manager.dept_no=departments.dept_no
INNER JOIN employees  ON dept_manager.emp_no=employees.emp_no

--4.List the department of each employee with the following information: employee number, last name, first name, and department name
SELECT dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM dept_emp
INNER JOIN employees  ON dept_emp.emp_no=employees.emp_no
FULL JOIN departments ON dept_emp.dept_no=departments.dept_no

--5.List all employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.last_name,employees.first_name
FROM employees
WHERE employees.first_name='Hercules' AND employees.last_name LIKE 'B%'

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM dept_emp
INNER JOIN employees  ON dept_emp.emp_no=employees.emp_no
FULL JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name='Sales' 

--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM dept_emp
INNER JOIN employees  ON dept_emp.emp_no=employees.emp_no
FULL JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name='Sales' or departments.dept_name='Development'

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT employees.last_name,count(employees.last_name) as Numberofemployees
FROM employees
GROUP BY employees.last_name
ORDER BY 2 DESC
