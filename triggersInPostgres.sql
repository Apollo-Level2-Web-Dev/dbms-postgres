-- Triggers in PostgreSQL (Based on 10-7)
-- Create a trigger that automatically logs enrollment when a student is added to course_enrollments.

-- Log table
CREATE TABLE log_table (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(id),
    course_title TEXT NOT NULL,
    department_id INTEGER NOT NULL REFERENCES departments(id),
    action TEXT,
    action_time TIMESTAMP DEFAULT NOW()
);


-- Trigger function
CREATE OR REPLACE FUNCTION save_log()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    dept_id INTEGER;
BEGIN
    -- Get department of student
    SELECT department_id INTO dept_id
    FROM students
    WHERE id = NEW.student_id;

    -- Insert log row
    INSERT INTO log_table (student_id, course_title, department_id, action)
    VALUES (NEW.student_id, NEW.course_title, dept_id, 'ENROLLED');

    RETURN NEW;
END;
$$;

CREATE TRIGGER save_enrolled_student
AFTER INSERT ON course_enrollment
FOR EACH ROW
EXECUTE FUNCTION save_log();


INSERT INTO course_enrollment (student_id, course_title, enroll_on)
VALUES
(2, 'Database Systems', '2024-01-15');

SELECT * FROM log_table

-- Add a trigger that sets the score to 0 if a new student record is added without a score.


-- Trigger function
-- Trigger function
CREATE OR REPLACE FUNCTION set_default_score()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if NEW.score is NULL
    IF NEW.score IS NULL THEN
        NEW.score := 0;
    END IF;

    RETURN NEW;
END;
$$;

-- Trigger
CREATE TRIGGER set_score_if_null
BEFORE INSERT ON students
FOR EACH ROW
EXECUTE FUNCTION set_default_score();

INSERT INTO students (name, age, score, department_id)
VALUES
('Shakil', 25,NULL, 1)






SELECT* from departments

SELECT* from course_enrollment;

SELECT* from students;