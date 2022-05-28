-- create schemas
CREATE SCHEMA my_online_class;

-- Select the schema
USE my_online_class;

-- create tables
CREATE TABLE student (
    student_id INT PRIMARY KEY auto_increment,
    first_name CHAR(50) NOT NULL,
    last_name CHAR(50) NOT NULL,
    birthdate DATE,
    phone_number VARCHAR(20),
    e_mail VARCHAR(50),
    registration_date DATE DEFAULT (CURRENT_DATE),
    registration_purpose TEXT    
);

CREATE TABLE student_progress (
    student_id INT,
    test_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    vocal_range_min FLOAT,
    vocal_range_max FLOAT,
    breath_performance INT,
    PRIMARY KEY (student_id, test_date),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY auto_increment,
    course_name VARCHAR (150) NOT NULL
);

CREATE TABLE enrollments (
    course_id INT,
    student_id INT,
    start_date DATE,
    end_date DATE DEFAULT NULL,
    drop_reason ENUM("Course is expensive", "I don't have time", " I've reached my goals", "I found another teacher"),
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE course_fee (
    course_fee_id INT PRIMARY KEY auto_increment,
    course_id INT,
    student_id INT,
    fee FLOAT NOT NULL,
    currency CHAR(10),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE schedules (
    schedule_id INT PRIMARY KEY auto_increment,
    student_id INT,
    course_id INT,
    schedule_date DATETIME NOT NULL,
    topic TEXT,
    notes TEXT, 
    assignment TEXT,
    completed_assignment TEXT,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE payment (
    schedule_id INT PRIMARY KEY,
    student_id INT,
    payment_date DATE,
    due_payment FLOAT,
    received_payment FLOAT,
    balance FLOAT,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id) ON DELETE CASCADE ON UPDATE CASCADE
);

