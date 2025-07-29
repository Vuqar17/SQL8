-- 1
CREATE DATABASE Teachers;
USE Teachers;

CREATE TABLE POSTS (
    Id INT PRIMARY KEY,
    Name NVARCHAR(20)
);

CREATE TABLE TEACHERS (
    Id INT PRIMARY KEY,
    Name NVARCHAR(15),
    Code CHAR(10),
    IdPost INT,
    Tel CHAR(7),
    Salary INT,
    Rise NUMERIC(6,2),
    HireDate DATETIME
);

-- 2
DROP TABLE POSTS;

-- 3
ALTER TABLE TEACHERS DROP COLUMN IdPost;

-- 4
ALTER TABLE TEACHERS
ADD CONSTRAINT CHK_HireDate CHECK (HireDate >= '1990-01-01');

-- 5
ALTER TABLE TEACHERS
ADD CONSTRAINT UQ_Code UNIQUE (Code);

-- 6
ALTER TABLE TEACHERS
ALTER COLUMN Salary NUMERIC(6,2);

-- 7
ALTER TABLE TEACHERS
ADD CONSTRAINT CHK_Salary CHECK (Salary >= 1000 AND Salary <= 5000);

-- 8
EXEC sp_rename 'TEACHERS.Tel', 'Phone', 'COLUMN';

-- 9
ALTER TABLE TEACHERS
ALTER COLUMN Phone CHAR(11);

-- 10
CREATE TABLE POSTS (
    Id INT PRIMARY KEY,
    Name NVARCHAR(20)
);

-- 11
ALTER TABLE POSTS
ADD CONSTRAINT CHK_PostName CHECK (Name IN (N'Professor', N'Assistant Professor', N'Teacher', N'Assistant'));

-- 12
ALTER TABLE TEACHERS
ADD CONSTRAINT CHK_TeacherName CHECK (Name NOT LIKE '%[0-9]%');

-- 13
ALTER TABLE TEACHERS
ADD IdPost INT;

-- 14
ALTER TABLE TEACHERS
ADD CONSTRAINT FK_Teachers_Posts FOREIGN KEY (IdPost) REFERENCES POSTS(Id);

-- 15
INSERT INTO POSTS (Id, Name) VALUES 
(1, N'Professor'),
(2, N'Assistant Professor'),
(3, N'Teacher'),
(4, N'Assistant');

INSERT INTO TEACHERS (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate) VALUES
(1, N'Sidorov', '0123456789', 1, NULL, 1070, 470, '1992-09-01'),
(2, N'Ramishevsky', '4567890123', 2, '4567890', 1110, 370, '1998-09-09'),
(3, N'Horenko', '1234567890', 3, NULL, 2000, 230, '2001-10-10'),
(4, N'Vibrovsky', '2345678901', 4, NULL, 4000, 170, '2003-09-01'),
(5, N'Voropaev', NULL, 4, NULL, 1500, 150, '2002-09-02'),
(6, N'Kuzintsev', '5678901234', 3, '4567890', 3000, 270, '1991-01-01');

-- 16.1
CREATE VIEW View_AllPosts AS
SELECT Name FROM POSTS;

-- 16.2
CREATE VIEW View_AllTeacherNames AS
SELECT Name FROM TEACHERS;

-- 16.3
CREATE VIEW View_TeachersSalary AS
SELECT t.Id, t.Name, p.Name AS Position, (t.Salary + t.Rise) AS TotalSalary
FROM TEACHERS t
JOIN POSTS p ON t.IdPost = p.Id


-- 16.4
CREATE VIEW View_TeachersWithPhone AS
SELECT Id, Name, Phone
FROM TEACHERS
WHERE Phone IS NOT NULL;

-- 16.5
CREATE VIEW View_Teachers_Date_ddmmyy AS
SELECT t.Name, p.Name AS Position,
FORMAT(HireDate, 'dd/MM/yy') AS HireDateFormatted
FROM TEACHERS t
JOIN POSTS p ON t.IdPost = p.Id;

-- 16.6
CREATE VIEW View_Teachers_Date_FullText AS
SELECT t.Name, p.Name AS Position,
FORMAT(HireDate, 'dd MMMM yyyy', 'en-us') AS HireDateFormatted
FROM TEACHERS t
JOIN POSTS p ON t.IdPost = p.Id;
