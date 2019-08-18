--DROP TABLE IF EXISTS departments;
--DROP TABLE IF EXISTS dept_emp;
--DROP TABLE IF EXISTS dept_manager;
--DROP TABLE IF EXISTS employees;
--DROP TABLE IF EXISTS salaries;
--DROP TABLE IF EXISTS titles;

CREATE TABLE departments(dept_no VARCHAR NOT NULL, dept_name VARCHAR NOT NULL);
CREATE TABLE dept_emp(emp_no INT NOT NULL, dept_no VARCHAR NOT NULL, from_date DATE NOT NULL, to_date DATE NOT NULL);
CREATE TABLE dept_manager(dept_no VARCHAR NOT NULL, emp_no INT NOT NULL, from_date DATE NOT NULL, to_date DATE NOT NULL);
CREATE TABLE employees(emp_no INT NOT NULL, 
					   birth_date DATE NOT NULL, 
					   first_name VARCHAR NOT NULL, 
					   last_name VARCHAR NOT NULL, 
					   gender CHAR NOT NULL, 
					   hire_date DATE NOT NULL);
CREATE TABLE salaries(emp_no INT NOT NULL, salary INT NOT NULL, from_date DATE NOT NULL, to_date DATE NOT NULL);
CREATE TABLE titles(emp_no INT NOT NULL, title VARCHAR NOT NULL, from_date DATE NOT NULL, to_date DATE NOT NULL);

--List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.emp_no, employees.first_name, employees.last_name, employees.gender, salaries.salary from salaries inner join employees on employees.emp_no=salaries.emp_no;

--List employees who were hired in 1986.
select * from employees where hire_date between '01/01/1986' and '12/31/1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select e.last_name, e.first_name, d.dept_name, m.dept_no, m.from_date, m.to_date from departments d JOIN dept_manager m ON (m.dept_no=d.dept_no) JOIN employees e ON (e.emp_no=m.emp_no);

--List the department of each employee with the following information: employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name from departments d JOIN dept_emp f ON (f.dept_no=d.dept_no) JOIN employees e ON (e.emp_no=f.emp_no);

--List all employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name from employees where first_name='Hercules' and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name from departments d join dept_emp f on (f.dept_no=d.dept_no) JOIN employees e ON (e.emp_no=f.emp_no) where d.dept_name='Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name from departments d join dept_emp f on (f.dept_no=d.dept_no) JOIN employees e ON (e.emp_no=f.emp_no) where d.dept_name='Sales' OR d.dept_name='Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, COUNT(last_name) AS "Duplicate Count" from employees group by last_name HAVING count(last_name) > 1 order by count(last_name) DESC;

--ERDs
CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" char   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Title" (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Title" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_salary" FOREIGN KEY("salary")
REFERENCES "Title" ("title");

ALTER TABLE "Title" ADD CONSTRAINT "fk_Title_title" FOREIGN KEY("title")
REFERENCES "Departments" ("dept_name");