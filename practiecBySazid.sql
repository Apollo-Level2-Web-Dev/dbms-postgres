-- Active: 1747459510114@@localhost@5432@ph_2

CREATE Table orders(
order_id SERIAL PRIMARY KEY,
customer_id INTEGER,
order_date DATE,
total_amount DECIMAL(10,2)
)

INSERT INTO orders(customer_id, order_date, total_amount) VALUES
(101, '2025-05-01', 199.99),
(102, '2025-05-02', 89.50),
(103, '2025-05-03', 145.00),
(104, '2025-05-04', 320.75),
(101, '2025-05-05', 25.99),
(105, '2025-05-06', 470.00),
(102, '2025-05-07', 129.49),
(106, '2025-05-08', 250.00),
(107, '2025-05-09', 78.90),
(108, '2025-05-10', 199.00),
(102, '2024-03-07', 129.49),
(106, '2024-02-08', 250.00),
(107, '2024-01-09', 78.90),
(108, '2024-06-10', 199.00);

-- Find customers who have placed more than 2 orders and calculate the total amount spent by each of these customers.

SELECT customer_id, count(*) as order_qty, sum(total_amount) from orders
GROUP BY customer_id
HAVING count(order_id) >2;

-- Find the total amount of orders placed each month in the year 2025.

SELECT extract(month from order_date) as all_months, count(*) as order_qty FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2025
GROUP BY all_months 


-- Understanding sub queries

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    department_name VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);


INSERT INTO employees (employee_name, department_name, salary, hire_date) VALUES 
    ('John Doe', 'HR', 60000.00, '2022-01-10'),
    ('Jane Smith', 'Marketing', 75000.50, '2021-05-22'),
    ('Bob Johnson', 'Finance', 80000.75, '2020-11-15'),
    ('Alice Williams', 'IT', 90000.25, '2019-08-03'),
    ('David Lee', 'Sales', 65000.50, '2020-03-18'),
    ('Sara Brown', 'Engineering', 70000.00, '2021-09-28'),
    ('Mike Miller', 'Customer Support', 55000.75, '2022-02-05'),
    ('Emily Davis', 'Administration', 95000.00, '2018-12-12'),
    ('Chris Wilson', 'Research', 72000.50, '2020-06-30'),
    ('Amy White', 'Quality Assurance', 68000.25, '2021-11-09'),
    ('John Johnson', 'HR', 62000.00, '2022-01-15'),
    ('Jessica Thompson', 'Marketing', 78000.50, '2021-06-05'),
    ('Michael Harris', 'Finance', 85000.75, '2020-11-25'),
    ('Emma Martinez', 'IT', 92000.25, '2019-09-15'),
    ('James Taylor', 'Sales', 67000.50, '2020-04-08'),
    ('Sophia Anderson', 'Engineering', 72000.00, '2021-10-10'),
    ('William Jackson', 'Customer Support', 56000.75, '2022-02-10'),
    ('Olivia Nelson', 'Administration', 97000.00, '2018-12-20'),
    ('Daniel White', 'Research', 73000.50, '2020-07-05'),
    ('Ava Wilson', 'Quality Assurance', 69000.25, '2021-11-15'),
    ('Matthew Brown', 'HR', 63000.00, '2022-01-20'),
    ('Emily Garcia', 'Marketing', 76000.50, '2021-06-15'),
    ('Christopher Allen', 'Finance', 86000.75, '2020-12-05'),
    ('Madison Hall', 'IT', 93000.25, '2019-09-25'),
    ('Andrew Cook', 'Sales', 68000.50, '2020-04-18'),
    ('Abigail Torres', 'Engineering', 73000.00, '2021-10-20'),
    ('Ethan Murphy', 'Customer Support', 57000.75, '2022-02-15'),
    ('Ella King', 'Administration', 98000.00, '2018-12-28'),
    ('Nathan Rivera', 'Research', 74000.50, '2020-07-15'),
    ('Mia Roberts', 'Quality Assurance', 70000.25, '2021-11-20');


SELECT * FROM employees;
SELECT department_name, max(salary) FROM employees GROUP BY department_name HAVING department_name = 'HR';

SELECT * FROM employees WHERE salary > (SELECT max(salary) FROM employees WHERE department_name = 'HR');

-- subqueries with select

SELECT *, (SELECT sum(salary) FROM employees) as salary_sum FROM employees ;

DROP Table employees

CREATE TABLE departments (
  department_id SERIAL PRIMARY KEY,
  department_name VARCHAR(100)
);

CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  employee_name VARCHAR(100),
  department_id INT REFERENCES departments(department_id),
  salary NUMERIC,
  hire_date DATE
);

INSERT INTO departments (department_name) VALUES
  ('Engineering'),
  ('Human Resources'),
  ('Marketing'),
  ('Sales'),
  ('Finance');

INSERT INTO employees (employee_name, department_id, salary, hire_date) VALUES
  ('Alice', 1, 90000, '2020-03-15'),
  ('Bob', 1, 85000, '2021-07-01'),
  ('Charlie', 1, 95000, '2019-11-23'),
  ('David', 2, 60000, '2021-01-10'),
  ('Eva', 2, 58000, '2020-05-20'),
  ('Frank', 3, 72000, '2022-02-28'),
  ('Grace', 3, 75000, '2018-06-30'),
  ('Hannah', 4, 67000, '2021-12-05'),
  ('Ian', 4, 68000, '2022-01-11'),
  ('Jack', 5, 80000, '2019-09-15');

DROP TABLE departments;
DROP TABLE employees;

SELECT department_name FROM (SELECT * FROM employees natural JOIN departments) as joined_table

;

SELECT d.department_name, s.total_salary
FROM departments d
JOIN (
    SELECT department_id, SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
) s ON d.department_id = s.department_id;

SELECT * FROM(SELECT department_name, sum(salary) FROM employees GROUP BY department_name) as sum_dept_salary;

SELECT department_name FROM(SELECT department_name, sum(salary) FROM employees GROUP BY department_name) as sum_dept_salary;

CREATE VIEW test_view AS
SELECT employee_name, salary, department_name
FROM employees
WHERE department_name IN (
    SELECT department_name
    FROM employees
    WHERE department_name LIKE '%R%'
);

SELECT * FROM test_view;