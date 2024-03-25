CREATE DATABASE MysqlITI;
use MysqlITI;

create table level (
ID Int primary key ,
name varchar(255) not null
);

create table student (
ID Int primary key,
name varchar(255) not null,
email varchar(255),
phone varchar(255),
level_id int ,
foreign key (level_id) references level(ID)
);

create table subject(
ID int primary key,
name varchar(255) not null,
sub_desc text,
max_score int
);

create table exam(
ID int primary key,
date Date );


create table stu_subjects(
student_id int,
subject_id int ,
PRIMARY KEY (student_id, subject_id),
foreign key (student_id) references student(ID),
foreign key (subject_id) references subject(ID)
);
create table student_grade(
student_id int,
sub_id int,
exam_id int,
grade decimal,
primary key (student_id , sub_id , exam_id),
foreign key (student_id) references student(ID),
foreign key (sub_id) references subject(ID),
foreign key (exam_id) references exam(ID)
);



insert into level (ID,name) values
(1,'jounior'),
(3,'senior'),
(2,'mid-level');


INSERT INTO student (ID, name, email, phone, level_id) VALUES
-- (1, 'omnia mohamed', 'omnia.mohamed@example.com', '123-456-7890', 1),
-- (2, 'salama sherief', 'salma@example.com', '987-654-3210', 2),
-- (3, 'nourann tareq', 'nouran@example.com', '555-123-4567', 3);
(4, 'Ahmed tareq', 'ahmed@example.com', '555-123-4567', 3);



INSERT INTO subject (ID, name, sub_desc, max_score) VALUES
(1, 'Mathematics', 'Algebra and Calculus', 100),
(2, 'History', 'World History', 90),
(3, 'Biology', 'Cell Biology', 95);

INSERT INTO exam (ID, date) VALUES
(1, '2024-03-01'),
(2, '2024-03-02'),
(3, '2024-03-03');

INSERT INTO stu_subjects (student_id, subject_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3);

INSERT INTO student_grade (student_id, sub_id, exam_id, grade) VALUES
(1, 1, 1, 85),
(1, 2, 1, 92),
(2, 2, 2, 88),
(3, 3, 3, 94);


alter table student 
add column gender enum('male','female'),
add column birthday date;
-------------------------------------------------------------

alter table student
drop foreign key student_ibfk_1;


alter table stu_subjects
drop foreign key stu_subjects_ibfk_1 ;

alter table stu_subjects 
drop foreign key stu_subjects_ibfk_2;



alter table student_grade 
drop foreign key student_grade_ibfk_1;

alter table student_grade 
drop foreign key student_grade_ibfk_2;

alter table student_grade 
drop foreign key student_grade_ibfk_3;

-------------------------------------------------------------------------
ALTER TABLE student
ADD CONSTRAINT fk_student_level
FOREIGN KEY (level_id) REFERENCES level(ID) ON DELETE CASCADE;

ALTER TABLE stu_subjects
ADD CONSTRAINT fk_student_subject
FOREIGN KEY (student_id) REFERENCES student(ID) ON DELETE CASCADE;
ALTER TABLE stu_subjects
ADD CONSTRAINT fk_subject_subject
FOREIGN KEY (subject_id) REFERENCES subject(ID) ON DELETE CASCADE;

ALTER TABLE student_grade
ADD CONSTRAINT fk_student_grade_student
FOREIGN KEY (student_id) REFERENCES student(ID) ON DELETE CASCADE,
ADD CONSTRAINT fk_student_grade_subject
FOREIGN KEY (sub_id) REFERENCES subject(ID) ON DELETE CASCADE,
ADD CONSTRAINT fk_student_grade_exam
FOREIGN KEY (exam_id) REFERENCES exam(ID) ON DELETE CASCADE;



SELECT name
FROM student
WHERE name LIKE 'A%';

INSERT INTO student (ID, name, email, phone, level_id, gender, birthday)
VALUES
(5, 'Alice', 'alice@example.com', '123-456-7890', 1, 'female', '1990-05-15'),
(6, 'Bob', 'bob@example.com', '987-654-3210', 2, 'male', '1988-11-30'),
(7, 'Alex', 'alex@example.com', '555-123-4567', 3, 'male', '1992-02-20');


SELECT name, gender, birthday
FROM student
WHERE gender = 'male' AND birthday < '1991-10-01';



DELETE FROM student
WHERE ID IN (
    SELECT student_id
    FROM student_grade
    WHERE grade < 50
      AND exam_id = 1
      AND sub_id = 1
);


SELECT s.name, sg.grade
FROM student s
JOIN student_grade sg ON s.ID = sg.student_id
ORDER BY sg.grade DESC
LIMIT 1 OFFSET 2;










