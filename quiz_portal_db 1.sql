create database quiz_portal_db;
use quiz_portal_db;
-- Admin Table

drop table users;
drop table admin;
drop table questions;
drop table quiz;
drop table quiz_questions;
drop table quiz_attempts;
drop table user_answers;

CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    full_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Users Table


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Questions Table


CREATE TABLE questions (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    question_text TEXT NOT NULL,
    option_1 VARCHAR(255) NOT NULL,
    option_2 VARCHAR(255) NOT NULL,
    option_3 VARCHAR(255) NOT NULL,
    option_4 VARCHAR(255) NOT NULL,
    correct_option INT NOT NULL,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Quiz Table


CREATE TABLE quiz (
    quiz_id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_title VARCHAR(200) NOT NULL,
    category VARCHAR(50),
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES admin(admin_id)


);
 
-- Quiz Questions Mapping Table


CREATE TABLE quiz_questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT NOT NULL,
    question_id INT NOT NULL,
    FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE


);
 
-- Quiz Attempts Table


CREATE TABLE quiz_attempts (
    attempt_id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT NOT NULL,
    user_id INT NOT NULL,
    score INT DEFAULT 0,
    total_questions INT,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE


);
 
-- User Answers Table


CREATE TABLE user_answers (
    answer_id INT PRIMARY KEY AUTO_INCREMENT,
    attempt_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option INT NOT NULL,
    is_correct BOOLEAN,
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(attempt_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE
);
 
-- Insert Default Admin


INSERT INTO admin (username, password, email, full_name) 
VALUES ('admin', 'admin123', 'admin@quizportal.com', 'Admin User');
 
-- Sample Questions


INSERT INTO questions (question_text, option_1, option_2, option_3, option_4, correct_option, category) VALUES
('What does OOP stand for?', 'Object Oriented Programming', 'Object Oriented Process', 'Only One Program', 'Open Object Programming', 1, 'SCIENCE'),
('How many bones are in the human body?', '206', '205', '208', '210', 1, 'SCIENCE'),
('What is the hardest natural substance on Earth?', 'Gold', 'Diamond', 'Granite', 'Steel', 2, 'SCIENCE'),
('What does DNA stand for?', 'Deoxyribose Nucleic Acid', 'Deoxyribonucleic Acid', 'Dextrose Nuclear Acid', 'None of the above', 2, 'SCIENCE'),
('What is the speed of light?', '300,000 km/s', '150,000 km/s', '299,792 km/s', '250,000 km/s', 3, 'SCIENCE');
 

 select * from users;