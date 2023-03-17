/*
Table 1: employees
Columns: employee_id (PK), first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id

Table 2: jobs
Columns: job_id (PK), job_title, min_salary, max_salary

Table 3: departments
Columns: department_id (PK), department_name, manager_id, location_id
*/
CREATE DATABASE final CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
USE final;

/*
참고) DECIMAL(M, D) 자료형
https://velog.io/@dlawogus/MySQL-DataTypes-DECIMAL
*/
DROP TABLE IF EXISTS employees;
-- create employees table
CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT,
    salary DECIMAL(8,2),
    commission_pct DECIMAL(4,2),
    manager_id INT,
    department_id INT
);
INSERT INTO employees VALUES
  (1, 'John', 'Doe', 'johndoe@example.com', '555-1234', '2021-01-01', 1, 100000.00, 0.05, 3, 1),
  (2, 'Jane', 'Smith', 'janesmith@example.com', '555-5678', '2021-02-01', 2, 80000.00, NULL, 3, 1),
  (3, 'Bob', 'Johnson', 'bobjohnson@example.com', '555-9012', '2021-03-01', 1, 90000.00, 0.02, 5, 2),
  (4, 'Alice', 'Williams', 'alicewilliams@example.com', '555-3456', '2021-04-01', 3, 70000.00, NULL, 5, 2),
  (5, 'Mike', 'Brown', 'mikebrown@example.com', '555-7890', '2021-05-01', 4, 120000.00, 0.08, NULL, 3),
  (6, 'Sara', 'Lee', 'saralee@example.com', '555-2345', '2021-06-01', 4, 75000.00, NULL, 7, 4),
  (7, 'Tom', 'Jackson', 'tomjackson@example.com', '555-6789', '2021-07-01', 5, 110000.00, 0.03, NULL, 4),
  (8, 'Karen', 'Davis', 'karendavis@example.com', '555-1234', '2021-08-01', 5, 95000.00, NULL, 7, 4),
  (9, 'David', 'Miller', 'davidmiller@example.com', '555-5678', '2021-09-01', 2, 85000.00, NULL, 10, 5),
  (10, 'Lisa', 'Wilson', 'lisawilson@example.com', '555-9012', '2021-10-01', 1, 110000.00, 0.06, NULL, 5);
DESC employees;

DROP TABLE IF EXISTS jobs;
-- create jobs table
CREATE TABLE jobs (
	job_id INT PRIMARY KEY, 
    job_title VARCHAR(50), 
    min_salary DECIMAL(8,2), 
    max_salary DECIMAL(8,2)
); 

INSERT INTO jobs VALUES
  (1, 'Manager', 80000.00, 120000.00),
  (2, 'Developer', 60000.00, 100000.00),
  (3, 'Designer', 50000.00, 90000.00),
  (4, 'Salesperson', 40000.00, 80000.00),
  (5, 'Accountant', 50000.00, 100000.00);
  DESC jobs;

DROP TABLE IF EXISTS departments;
-- create departments table
CREATE TABLE departments (
	department_id INT PRIMARY KEY, 
    department_name VARCHAR(50), 
    manager_id INT, 
    location_id VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Engineering', 3, 'New York'),
(2, 'Sales', 5, 'Los Angeles'),
(3, 'Marketing', 7, 'Chicago'),
(4, 'Accounting', 8, 'Houston'),
(5, 'IT', 10, 'San Francisco');
DESC departments;

SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM departments;

-- < 실습 문제 >
-- 1. IT 부서에서 일하는 모든 직원을 반환하는 쿼리를 작성합니다.
SELECT * FROM employees JOIN departments 
	ON employees.department_id = departments.department_id
    WHERE department_name = 'IT';

SELECT * FROM employees WHERE department_id = 5;

-- 2. 각 부서의 총 직원 수를 반환하는 쿼리를 작성합니다.
SELECT department_name, COUNT(employee_id) AS 'total_employees' FROM employees JOIN departments
	ON employees.department_id = departments.department_id
    GROUP BY departments.department_name;

SELECT department_id, COUNT(*) AS 'total_employees' FROM employees GROUP BY department_id;

-- 3. $80,000 이상의 급여를 받는 모든 직원의 이름을 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, salary FROM employees JOIN jobs
	ON employees.job_id = jobs.job_id
    WHERE employees.salary >= 80000;

SELECT first_name, last_name, salary FROM employees WHERE employees.salary >= 80000;

-- 4. 영업부에서 근무하며 $50,000 이상의 급여를 받는 모든 직원의 이름과 급여를 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name salary FROM employees JOIN departments
	ON employees.department_id = departments.department_id
    WHERE department_name = 'Sales' AND salary >= 50000;
    
SELECT first_name, last_name salary FROM employees 
	WHERE department_id = ( SELECT department_id FROM departments WHERE department_name = 'Sales' )
    AND salary >= 50000;
    
SELECT first_name, last_name salary FROM employees WHERE department_id = 2 AND salary >= 50000;


-- 5. 직함과 직함별 평균 급여를 반환하는 조회를 작성합니다.
SELECT job_title, AVG(salary) AS 'avg_salary' FROM employees JOIN jobs
	ON employees.job_id = jobs.job_id GROUP BY jobs.job_title;


-- 6. 모든 작업에 대한 직책과 최대 급여를 반환하는 조회를 작성합니다.
SELECT job_title, max_salary FROM jobs;

SELECT job_title, MAX(max_salary) FROM jobs GROUP BY job_title;
SELECT job_id, MAX(max_salary) FROM jobs GROUP BY job_id;


-- 7. 가장 높은 연봉을 받는 직원 상위 10명의 이름과 급여를 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC LIMIT 10;


-- 8. 최저임금을 받는 하위 5명의 직원들의 이름과 급여를 반환하는 쿼리를 작성하세요.
SELECT first_name, last_name, salary FROM employees ORDER BY salary LIMIT 5;


-- 9. 관리자와 동일한 직함(job_id)을 가진 모든 직원의 이름을 반환하는 쿼리를 작성합니다.
-- 직원과 직원에 할당된 상사의 job_id가 일치 
-- manager_id - employee_id 관계에서 job_id가 일치하는 사람만 
SELECT a.first_name, a.last_name FROM employees AS a JOIN employees AS b
	ON b.job_id = a.job_id WHERE b.employee_id = a.manager_id; 

SELECT e.first_name, e.last_name
	FROM employees AS e JOIN employees AS m
	ON e.manager_id = m.employee_id
	WHERE e.job_id = m.job_id;

SELECT e.first_name, e.last_name
	FROM employees AS e JOIN employees AS m
	ON e.job_id = m.job_id
	WHERE e.manager_id = m.employee_id;

-- 10. 2021년에 채용된 모든 직원 이름을 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date LIKE '2021%'; 


-- 11. 수수료를 받는 모든 직원의 이름과 급여를 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, salary, commission_pct FROM employees WHERE commission_pct IS NOT NULL;


-- 12. 수수료를 받지 않는 모든 직원의 이름과 급여를 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, salary, commission_pct FROM employees WHERE commission_pct IS NULL;




