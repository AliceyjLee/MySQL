USE smartfactory;
USE new_smartfactory;

-- DDL
-- CREATE : 데이터베이스, 테이블 생성 
-- 데이터베이스 생성 + 한글 인코딩 
-- 한글 인코딩 : 프로그래밍 언어는 영어 기반이므로 한글을 사용할 수 있도록 해줌
CREATE DATABASE new_smartfactory CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 테이블 생성
-- new_customer 테이블  
-- custid(고객번호) CHAR(10), NOT NULL 제약조건, PK
-- custname(고객이름) VARCHAR(10), NOT NULL 제약조건
-- addr (주소) CHAR(10), NOT NULL 제약조건
-- phone (연락처) CHAR(11)
-- birth (생년월일) DATE

-- 1. 기본키 제약 조건
-- 기본키는 중복 불가능 
-- NULL 불가능
CREATE TABLE new_customer (
	custid CHAR(10) PRIMARY KEY,         -- PK는 NULL 값을 허용치 않기때문에 PK만 써줘도 가능
    custname VARCHAR(10) NOT NULL, 
	addr CHAR(10) NOT NULL,
    phone CHAR(11),
    birth DATE
);

DESC new_customer;
SELECT * FROM new_customer;

-- new_orders 테이블 생성
-- orderid INT, NOT NULL 제약조건, PK, 숫자 자동 증가 AI = AUTO_INCREMENT
-- custid CHAR(10), NOT NULL 제약조건
-- prodname CHAR(6), NOT NULL 제약조건
-- price INT, NOT NULL 제약조건
-- amount smallint, NOT NULL 제약조건

-- 2. 외래키 제약조건 
-- 두 테이블 사이의 관계를 맺어줌 ( = 다른 테이블의 기본키를 현재 테이블의 외래키로 연결함 )
-- 기본키를 갖는 테이블 : '기준' 테이블 FOREIGN KEY
-- 외래키가 있는 테이블 : '참조' 테이블 REFERENCES
-- 형식 : FOREIGN KEY(열_이름) REFERENCES 기준_테이블 (열_이름)

-- CASCADE (외래키 설정할 때)
-- ON UPDATE CASCADE : 기준 테이블의 데이터 변경 시, 참조 테이블 데이터도 변경 
-- ON DELETE CASCADE : 기준 테이블의 데이터 삭제 시, 참조 테이블 데이터도 삭제 
CREATE TABLE new_orders (
	orderid INT PRIMARY KEY AUTO_INCREMENT,
    custid CHAR(10) NOT NULL,
    prodname CHAR(6) NOT NULL,
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (custid) REFERENCES new_customer (custid) ON UPDATE CASCADE ON DELETE CASCADE
);

DESC new_orders;
SELECT * FROM new_orders;

-- ctrl + shift + enter : 드래그한 여러 행 동시 실행
INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5);
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);

-- ALTER 문 : 새로운 속성 추가
-- 고객 테이블에 새로운 속성 'nickname' 추가
ALTER TABLE new_customer ADD nickname VARCHAR(10);

-- 속성 수정 
-- (1) 속성의 데이터타입 수정 
ALTER TABLE new_customer MODIFY nickname INT;
-- (2) 속성명 변경 
ALTER TABLE new_customer CHANGE nickname n_name VARCHAR(10);
-- (3) 기존 속성 삭제 
ALTER TABLE new_customer DROP n_name;

-- DROP 문 : 생선된 테이블과 속성 삭제 
-- 순서대로 외래키가 있는 참조 테이블부터 삭제 후, 기본키가 있는 기준 테이블을 삭제 

DROP TABLE new_orders;    -- 먼저 삭제
DROP TABLE new_customer;  -- 나중 삭제