-- Create a function that takes a student's score and returns a grade (e.g., A, B, C, F)
CREATE  or replace FUNCTION grab_grade(score numeric)
RETURNS TEXT
LANGUAGE plpgsql
as
$$

BEGIN
    IF score >= 90 THEN
        RETURN 'A';
    ELSIF score >= 80 THEN
        RETURN 'B';
    ELSIF score >= 70 THEN
        RETURN 'C';
    ELSE
        RETURN 'F';
    END IF;
END

$$

SELECT name, score, grab_grade(score) FROM students;

select * from students

select * from departments


-- Create a function that returns the full name and department of a student by ID.


SELECT students.name as student_name, departments.name as department_name 
FROM students 
JOIN departments ON departments.id = students.department_id;

CREATE or replace FUNCTION dpt_fn()
RETURNS  TABLE(student_name TEXT, department_name TEXT)
LANGUAGE sql
AS
$$
SELECT students.name as student_name, departments.name as department_name FROM students 
JOIN departments ON departments.id = students.department_id;
$$

SELECT * FROM dpt_fn();