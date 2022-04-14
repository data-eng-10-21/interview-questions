CREATE TABLE employers (
   id  integer,
   name  varchar(100) NOT NULL,
   address  varchar(250) NOT NULL,
   PRIMARY KEY (id)
);

INSERT INTO employers (id, name, address)
VALUES  (100, 'Flywheel Software', 'San Francisco, CA')
     , (101, 'Google', 'San Francisco, CA')
     , (102, 'Indeed', 'Austin, TX')
;

CREATE TABLE jobs (
   id  integer,
   emp_id  integer NOT NULL,
   title  varchar(150) NOT NULL,
   start_date  date,
   post_date  timestamp NOT NULL,
   min_gpa  numeric(3,2),
   PRIMARY KEY (id),
   FOREIGN KEY (emp_id) REFERENCES employers (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE
);

INSERT INTO jobs (id, emp_id, title, start_date, post_date, min_gpa)
VALUES  (1001, 100, 'Data Analyst', '2021-03-01', '2021-01-01', 3.2)
     , (1002, 100, 'HR Lead', '2021-05-15', '2021-01-01', 3.5)
     , (1003, 101, 'Marketing Associate', '2021-02-01', '2021-01-15', 3.0)
     , (1004, 101, 'Data Analyst', '2021-03-01', '2021-01-01', 3.5)
     , (1005, 102, 'Product Specialist', '2021-03-01', '2021-01-01', 2.8)
     , (1006, 102, 'Senior Marketer', '2021-06-10', '2021-04-01', 3.5)
     , (1007, 101, 'Data Scientist', '2021-03-01', '2021-01-01', 3.5)
;

CREATE TABLE job_skills (
   job_id  integer,
   job_skill  varchar(50),
   PRIMARY KEY (job_id, job_skill),
   FOREIGN KEY (job_id) REFERENCES jobs (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE
);

INSERT INTO job_skills (job_id, job_skill)
VALUES  (1001, 'Python'), (1001, 'SQL'), (1001, 'Consulting')
     , (1002, 'Interviewing'), (1002, 'SQL')
     , (1003, 'Marketing')
     , (1004, 'Python'), (1004, 'SQL'), (1004, 'Excel')
     , (1005, 'Product Development'), (1005, 'Product Testing')
     , (1006, 'Marketing'), (1006, 'People Management')
     , (1007, 'Python'), (1007, 'R'), (1007, 'SQL')
;

CREATE TABLE students (
   id  integer,
   name  varchar(100) NOT NULL,
   major  varchar(100),
   degree  varchar(15),
   gpa  numeric(3,2),
   PRIMARY KEY (id),
   CHECK (degree IN ('post-graduate', 'graduate', 'undergraduate', 'visiting', 'certificate'))
);

INSERT INTO students (id, name, major, degree, gpa)
VALUES  (10001, 'Sam', 'Economics', 'graduate', 3.4)
     , (10002, 'Jane', 'Marketing', 'undergraduate', 3.1)
     , (10003, 'Fred', 'Math', 'undergraduate', 3.5)
     , (10004, 'Carl', 'Computer Science', 'undergraduate', 2.8)
;
CREATE TABLE student_skills (
   student_id  integer,
   student_skill  varchar(50),
   PRIMARY KEY (student_id, student_skill),
   FOREIGN KEY (student_id) REFERENCES students (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE
);

INSERT INTO student_skills (student_id, student_skill)
VALUES  (10001, 'Excel'), (10001, 'SQL'), (10001, 'Python')
     , (10002, 'Marketing'), (10002, 'Consulting')
     , (10003, 'Python'), (10003, 'SQL'), (10003, 'Linear Algebra')
     , (10004, 'Java'), (10004, 'SQL'), (10004, 'Algorithms')
;

CREATE TABLE applications (
   student_id  integer,
   job_id  integer,
   date_submitted  timestamp NOT NULL,
   PRIMARY KEY (student_id, job_id),
   FOREIGN KEY (student_id) REFERENCES students (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE,
   FOREIGN KEY (job_id) REFERENCES jobs (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE
);

INSERT INTO applications (student_id, job_id, date_submitted)
VALUES  (10001, 1001, '2021-01-14'), (10001, 1004, '2021-01-14')
     , (10002, 1001, '2021-01-19'), (10002, 1004, '2021-01-17'), (10002, 1007, '2021-01-19')
     , (10003, 1007, '2021-01-19')
     , (10004, 1004, '2021-01-19'), (10004, 1001, '2021-01-19')
;

CREATE TABLE interviews (
   job_id  integer,
   student_id  integer,
   interview_date  timestamp NOT NULL,
   offer_made  varchar(14),
   PRIMARY KEY (job_id, student_id),
   FOREIGN KEY (job_id) REFERENCES jobs (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE,
   FOREIGN KEY (student_id) REFERENCES students (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE,
   CHECK (offer_made IN ('no offer', 'offer accepted', 'offer rejected'))
);

INSERT INTO interviews (job_id, student_id, interview_date, offer_made)
VALUES  (1001, 10001, '2021-02-14', 'offer accepted')
     , (1004, 10001, '2021-02-14', 'offer rejected')
     , (1001, 10002, '2021-02-17', 'no offer')
     , (1004, 10002, '2021-02-18', 'no offer')
     , (1007, 10003, '2021-02-17', 'offer accepted')
     , (1004, 10004, '2021-02-17', 'no offer')
;