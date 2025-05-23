CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    score NUMERIC(10,4) ,
    department_id INTEGER NOT NULL REFERENCES departments(id)
);


CREATE TABLE course_enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(id),
    course_title VARCHAR(100) NOT NULL,
    enroll_on DATE NOT NULL
);

INSERT INTO departments (name)
VALUES 
    ('CSE'),
    ('EEE'),
    ('BBA'),
    ('ME'),
    ('Civil');


INSERT INTO students (name, age, score, department_id)
VALUES
('Alice', 20, 91.5, 1),
    ('Bob', 21, 78.0, 2),
    ('Charlie', 22, 84.3, 1),
    ('David', 20, 65.7, 3),
    ('Eve', 23, 88.9, 2),
    ('Frank', 24, 92.4, 4),
    ('Grace', 21, NULL, 5),
    ('Rachel', 22, 85.2, 1),
    ('Steve', 24, 60.0, 3),
    ('Trudy', 20, NULL, 2),         -- score is NULL
    ('Uma', 21, 92.7, 1),
    ('Victor', 23, 48.5, 4),
    ('Wendy', 25, 75.3, 5),
    ('Xander', 26, 88.8, 3),
    ('Yasmine', 22, 79.5, 2),
    ('Zane', 24, NULL, 4),          -- score is NULL
    ('Abigail', 20, 66.6, 5),
    ('Heidi', 22, 79.2, 1),
    ('Ivan', 20, 55.0, 3),
    ('Judy', 25, 89.5, 2),
    ('Kevin', 23, 95.0, 1),
    ('Laura', 24, 70.0, 4),
    ('Mallory', 21, 67.8, 5),
    ('Nathan', 22, 82.6, 2),
    ('Olivia', 20, NULL, 3),  -- Another NULL score
    ('Peter', 26, 74.1, 4),
    ('Quinn', 23, 90.3, 1);

INSERT INTO course_enrollment (student_id, course_title, enroll_on)
VALUES
(1, 'Database Systems', '2024-01-15'),
    (1, 'Operating Systems', '2024-02-10'),
    (2, 'Circuit Analysis', '2024-03-12'),
    (3, 'Algorithms', '2024-04-01'),
    (4, 'Marketing Basics', '2024-02-20'),
    (6, 'Thermodynamics', '2024-05-01'),
    (7, 'Cybersecurity Fundamentals', '2023-11-15'),
    (8, 'Data Analytics', '2024-01-20'),
    (9, 'Digital Marketing', '2023-12-05'),
    (10, 'Machine Learning', '2024-03-10'),
    (11, 'Thermal Engineering', '2024-04-18'),
    (12, 'Fluid Mechanics', '2023-10-08'),
    (13, 'Econometrics', '2024-05-21'),
    (14, 'Intro to AI', '2024-02-28'),
    (15, 'Project Management', '2024-03-02'),
    (16, 'Database Systems', '2024-04-25'),
    (17, 'Software Engineering', CURRENT_DATE);

drop Table course_enrollment;
drop Table students;
drop Table departments;

-- Query Practice & Subqueries (Based on 10-1 to 10-3)
-- Retrieve all students who scored higher than the average score.
-- SELECT avg(score) from students;
SELECT* from students
WHERE score > (SELECT avg(score) from students);

-- Find students whose age is greater than the average age of all students.
-- SELECT avg(age) from students;
SELECT * FROM students
WHERE age > (SELECT avg(age) from students);

-- Get names of students who are enrolled in any course (use IN with subquery).

SELECT * from students;
SELECT * from students 
WHERE id IN (SELECT student_id FROM course_enrollment);

-- Retrieve departments with at least one student scoring above 90 (use EXISTS).

SELECT * FROM departments
WHERE EXISTS (
    SELECT 1 
    FROM students 
    WHERE students.department_id = departments.id
    AND students.score > 90
);

SELECT* from students;
SELECT* from departments;
SELECT* from course_enrollment