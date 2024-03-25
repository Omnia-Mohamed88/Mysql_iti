use MysqlITI;
select * from student;
-- Q1
select gender, count(*) as count 
from student 
group by gender;


---------------------------------------------------------------------------------------
-- Q2
INSERT INTO student (ID, name, email, phone, level_id, gender, birthday)
VALUES
(10, 'omnia mohamed', 'alice@example.com', '123-456-7890', 1, 'female', '1990-05-15'),
(11, 'omnia mohamed', 'bob@example.com', '987-654-3210', 2, 'male', '1988-11-30');


select name , count(*) as name_count
from student 
group by name 
having name_count > 2; 

---------------------------------------------------------------------------------------
-- Q3
CREATE VIEW student_subject_view AS
SELECT s.name AS student_name, sub.name AS subject_name
FROM student s
JOIN stu_subjects ss ON s.ID = ss.student_id
JOIN subject sub ON ss.subject_id = sub.ID;

SELECT * FROM student_subject_view;



-------------------------------------------------------------------------------------------------
-- Q4
CREATE VIEW student_subject_score_view AS
SELECT student.name AS student_name, subject.name AS subject_name, student_grade.grade
FROM student
JOIN stu_subjects ON student.ID = stu_subjects.student_id
JOIN subject ON stu_subjects.subject_id = subject.ID
JOIN student_grade ON student_grade.student_id = student.ID;

select * from student_subject_score_view;

----------------------------------------------------------------------------------
-- Q5
create view subject_max_score_view as
select subject.name , subject.max_score
from subject ;

select * from  subject_max_score_view ;
----------------------------------------------------------------------------------------------------
-- Q6
create view exam_date_view as
select ID , date_format(date , '%e %M %Y') as formatted_date
from exam;

select * from  exam_date_view;
-------------------------------------------------------------------------------------------------
-- Q7
alter table  student_grade 
modify column grade float;

UPDATE student_grade
SET grade = 22.5
WHERE student_id = 4;


SELECT student.name , round(student_grade.grade) rounded_grade , exam_id
from student 
join student_grade on student.ID = student_grade.student_id
join exam on exam.id = student_grade.exam_id;
----------------------------------------------------------------------------------------------------------
-- Q8
select name, year(birthday) from student;





