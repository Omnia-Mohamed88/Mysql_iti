-- Q1
Delimiter //
create function hello_world(name varchar(255))
returns varchar(255)
deterministic
begin
declare welcome_message varchar(255);
set welcome_message = concat('Welcome,  ', name, '!');
return welcome_message ;
End //
Delimiter ;

select hello_world('omnia');

-----------------------------------------------------------------------------------------------------
-- Q2
delimiter //
create function multiply_numbers(x int , y int )
returns int 
deterministic no sql 
begin 
declare result int ;
set result = x * y;
return result ;
end //
delimiter ;

select multiply_numbers(2,5);

----------------------------------------------------------------------------------------------------
-- Q3
delimiter //
create function student_score (studentId int , examId int)
returns int 
deterministic reads sql data 
begin 
declare student_score int ;
select grade into student_score
from student_grade
where student_grade.student_id = studentId and student_grade.exam_id = examId ; 
return student_score;
end //
delimiter ;

select student_score(2,2)

---------------------------------------------------------------------------------------------
 -- Q4
DELIMITER //

CREATE FUNCTION sub_max_score(subject_name VARCHAR(25))
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE Max_score INT;
    SELECT max_score INTO Max_score
    FROM subject
    WHERE subject.name = subject_name;
    RETURN Max_score;
END //

DELIMITER ;

SELECT sub_max_score('Mathmatics');

------------------------------------------------------------------------------------
-- Q5
create table deleted_students(
ID int primary key,
name varchar(255) not null ,
email varchar(255),
phone varchar (255),
level_id int,
FOREIGN KEY (level_id) REFERENCES level(ID)
);

-- Q6
DELIMITER //
create trigger before_delete_studnet
before delete on student
for each row 
begin 
insert into deleted_students(ID , name , email, phone ,level_id)
values(old.ID , old.name , old.email , old.phone , old.level_id);
end //
DELIMITER ;

DELETE FROM student WHERE ID = 1;

SELECT * FROM deleted_students WHERE ID = 1;
------------------------------------------------------------------------------
-- Q7 
create table back_up_student(
ID int primary key ,
name varchar(255) not null,
email varchar(255),
phone varchar(25),
level_id int ,
foreign key (level_id) references level(ID),
gender enum('male','female'),
birthday date);

delimiter //
create trigger back_up_student
after insert on student 
for each row 
begin 
insert into back_up_student (ID , name , email , phone , level_id , gender , birthday)
values (new.ID , new.name , new.email , new.phone , new.level_id , new.gender , new.birthday);
end //
delimiter ;

insert into student (ID , name , email , phone , level_id , gender , birthday )
values (18,'omniaa mohamed ' , 'omnia@gmail.com' , '0119005647' , 2 , 'female' , '2001-1-10');

select * from back_up_student


