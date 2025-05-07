CREATE DATABASE StudentRecords;

CREATE TABLE Students (
	studentId INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

INSERT INTO Students (studentId, firstName, lastName, age, email) VALUES
(1, 'John', 'Doe', 20, 'john.doe@example.com'),
(2, 'Jane', 'Smith', 22, 'jane.smith@example.com'),
(3, 'Emily', 'Clark', 19, 'emily.clark@example.com'),
(4, 'Michael', 'Brown', 21, 'michael.brown@example.com'),
(5, 'Adam', 'Sanders', 25, 'adam.sanders@example.com');

CREATE TABLE Courses (
	courseId INT PRIMARY KEY, 
    courseName VARCHAR(50), 
    courseDescription VARCHAR(100)
);

INSERT INTO Courses (courseId, courseName, courseDescription) VALUES
(1, 'Computer Science', 'Learn about programing and POO in Java'),
(2, 'Databases', 'Learn about SQL and databases');

ALTER TABLE Students ADD COLUMN course INT NOT NULL DEFAULT 0;
UPDATE `studentrecords`.`students` SET `course` = '1' WHERE (`studentId` = '1');
UPDATE `studentrecords`.`students` SET `course` = '1' WHERE (`studentId` = '2');
UPDATE `studentrecords`.`students` SET `course` = '2' WHERE (`studentId` = '3');
UPDATE `studentrecords`.`students` SET `course` = '2' WHERE (`studentId` = '4');
UPDATE `studentrecords`.`students` SET `course` = '1' WHERE (`studentId` = '5');
