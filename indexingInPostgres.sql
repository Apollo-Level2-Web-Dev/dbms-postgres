-- Active: 1747459510114@@localhost@5432@ph_2
CREATE INDEX idx_score ON students(score);

CREATE INDEX idx_enrollment_composite ON course_enrollment(student_id, enroll_on);

SELECT * FROM course_enrollment


EXPLAIN ANALYZE 
SELECT * 
FROM students 
WHERE score > 80;

EXPLAIN ANALYZE 
SELECT * 
FROM course_enrollment 
WHERE student_id = 3 AND enroll_on > '2024-01-01';
