USE smartfactory;

CREATE TABLE new_user (
	id VARCHAR(10) PRIMARY KEY,
    pw VARCHAR(20) NOT NULL,
    name VARCHAR(5) NOT NULL,
    gender CHAR(1),
    birthday DATE NOT NULL,
    age INT NOT NULL
);
DESC new_user;

CREATE TABLE member (
	id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(5) NOT NULL,
    age INT,
    gender VARCHAR(2) NOT NULL,
    email VARCHAR(50),
    promotion VARCHAR(2) DEFAULT 'x'
    );

DESC member;
ALTER TABLE member MODIFY id VARCHAR(10);
ALTER TABLE member DROP age;
ALTER TABLE member ADD interest VARCHAR(100);
