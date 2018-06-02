CREATE TABLE degree (
  degree_id SMALLINT PRIMARY KEY,
  degree    VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE subject(
  subject_id SERIAL PRIMARY KEY,
  subject VARCHAR(80) UNIQUE NOT NULL,
  degree_id SMALLINT NOT NULL REFERENCES degree(degree_id)
);

CREATE TABLE department(
  department_id SMALLSERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE subject_department(
  subject_id INTEGER  NOT NULL REFERENCES subject(subject_id),
  department_id INTEGER NOT NULL REFERENCES department(department_id),
  UNIQUE (subject_id, department_id)
);

CREATE TABLE keyword(
  keyword_id SERIAL PRIMARY KEY,
  keyword VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE subject_keyword(
  subject_id INTEGER NOT NULL REFERENCES subject(subject_id),
  keyword_id INTEGER NOT NULL REFERENCES keyword(keyword_id),
  UNIQUE (subject_id, keyword_id)
);

CREATE TABLE academic_employee(
  academic_employee_id SERIAL PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  email VARCHAR(60) UNIQUE NOT NULL,
  degree_id SMALLINT NOT NULL REFERENCES degree(degree_id),
  department_id SMALLINT NOT NULL REFERENCES department(department_id)
);

CREATE TABLE thesis(
  thesis_id SERIAL PRIMARY KEY,
  subject_id INTEGER NOT NULL REFERENCES subject(subject_id),
  promoter_id INTEGER REFERENCES academic_employee(academic_employee_id) NOT NULL,
  promoters_grade DECIMAL (2,1),
  defence_date DATE,
  ending_grade DECIMAL (2,1)
);


CREATE TABLE review(
  review_id SERIAL PRIMARY KEY,
  reviewer_id INTEGER NOT NULL REFERENCES academic_employee(academic_employee_id),
  thesis_id INTEGER NOT NULL REFERENCES thesis(thesis_id),
  grade DECIMAL(2,1) NOT NULL,
  review_date DATE NOT NULL,
  UNIQUE (reviewer_id, thesis_id)
);

CREATE TABLE student(
  student_id SERIAL PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  index CHAR(10) UNIQUE NOT NULL,
  email VARCHAR(80) UNIQUE
);

CREATE TABLE thesis_student(
  thesis_id INTEGER NOT NULL REFERENCES thesis(thesis_id),
  student_id INTEGER NOT NULL  REFERENCES student(student_id),
  UNIQUE (thesis_id, student_id)
);