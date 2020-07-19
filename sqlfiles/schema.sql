-- PostgreSQL create tables
-- first drop old tables
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;

-- 'departments' table
CREATE TABLE departments(
	dept_no CHAR(4) PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL UNIQUE
);

-- 'titles' table
CREATE TABLE titles(
	title_id CHAR(5) PRIMARY KEY,
	title VARCHAR(30) NOT NULL UNIQUE
);

-- 'employees' table
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id CHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex CHAR(1) NOT NULL CHECK (sex IN ('M','F')),
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- 'department employees' table
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no CHAR(4) NOT NULL,
	PRIMARY KEY(emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- 'department managers' table
CREATE TABLE dept_manager(
	dept_no CHAR(4) NOT NULL,
	emp_no INT PRIMARY KEY,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- 'salaries' table
CREATE TABLE salaries(
	emp_no INT PRIMARY KEY,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);