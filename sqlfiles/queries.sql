-- postgreSQL queries

-- 1. list employees' name, sex, and salaries
SELECT 
	e.emp_no AS "employee number",
	e.last_name AS "last name",
	e.first_name AS "first name",
	e.sex,
	s.salary
FROM employees AS e
JOIN salaries AS s ON
e.emp_no = s.emp_no;

-- 2. list name and hire date of employees hired in 1986
SELECT 
	first_name AS "first name",
	last_name AS "last name",
	hire_date AS "hire date"
FROM employees
WHERE EXTRACT(year FROM hire_date) = 1986;

-- 3. list department managers' detail
SELECT
	m.dept_no AS "department number",
	d.dept_name AS "department name",
	m.emp_no AS "manager employee number",
	e.last_name AS "last name",
	e.first_name AS "first name"
FROM dept_manager AS m
JOIN departments AS d ON
m.dept_no=d.dept_no
JOIN employees AS e ON
e.emp_no=m.emp_no;

-- 4. list employees' name, employee number, and department name
SELECT
	e.emp_no AS "employee number",
	e.last_name AS "last name",
	e.first_name AS "first name",
	d.dept_name AS "department name"
FROM employees AS e
JOIN dept_emp AS de ON
e.emp_no=de.emp_no
JOIN departments AS d ON
de.dept_no=d.dept_no;

-- 5. List name and sex of employees whose first name is 'Hercules' and last names begin with 'B'
SELECT 
	first_name AS "first_name",
	last_name AS "last_name",
	sex
FROM employees 
WHERE
	first_name='Hercules' AND 
	last_name like 'B%';

-- Create a view of employees' number, name, and department name
DROP VIEW IF EXISTS empname_dept;

CREATE VIEW empname_dept AS
	SELECT 
		e.emp_no AS "employee number",
		e.last_name AS "last name",
		e.first_name AS "first name",
		d.dept_name AS "department name"
	FROM employees AS e
	JOIN dept_emp AS de ON
	e.emp_no=de.emp_no
	JOIN departments AS d ON
	de.dept_no=d.dept_no;

-- 6. using created view, list employees from Sales department
SELECT * FROM empname_dept
WHERE "department name" = 'Sales';

-- 7. using created view, list employees from Sales or Developement department
SELECT * FROM empname_dept
WHERE "department name" IN ('Sales','Development');

-- 8. list frequency of employee last name by descending order
SELECT 
	last_name, 
	COUNT(last_name) 
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;