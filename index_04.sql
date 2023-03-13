-- DML ( INSERT, UPDATE, DELETE )

USE new_smartfactory;

CREATE TABLE new_customer (
	custid CHAR(10) PRIMARY KEY,
    custname VARCHAR(10) NOT NULL, 
	addr CHAR(10) NOT NULL,
    phone CHAR(11),
    birth DATE
);
INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');

CREATE TABLE new_orders (
	orderid INT PRIMARY KEY AUTO_INCREMENT,
    custid CHAR(10) NOT NULL,
    prodname CHAR(6) NOT NULL,
    price INT NOT NULL,
    amount smallint NOT NULL,
    FOREIGN KEY(custid) REFERENCES new_customer(custid) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5);
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);

DESC new_customer;
SELECT * FROM new_customer;
DESC new_orders;
SELECT * FROM new_orders;

-- INSERT : 새로운 투플(행) 추가
-- INSERT 긴 명령어 버전 
INSERT INTO new_customer ( custid, custname, addr, phone, birth )
	VALUES ( 'lucky', '강해원', '미국 뉴욕', '01022223333', '2002-03-05' );
    
-- 속성 순서를 바꿔서 추가하고 싶다면? 순서는 바꿀 수 있음, but 속성명과 속성값의 순서가 차례대로여야 함
INSERT INTO new_customer ( birth, custid, custname, addr, phone )
	VALUES ( '2007-04-28','wow', '이지은', '대한민국 부산', '01098765432' );
    
-- INSERT 짧은 명령어 버전 
INSERT INTO new_customer VALUES ( 'happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31' );

-- 여러 고객 정보를 동시에 추가하고 싶으면? 하나의 INSERT문 안에 여러 정보를 작성 
INSERT INTO new_customer VALUES 
	('asdf', '강세희', '대한민국 부산', '01033331235', '2004-11-11'),
	('sdfg', '윤지성', '일본 도쿄', '01033331236', '1995-02-15'),
    ('dfgh', '이재은', '미국 뉴욕', '01033331237', '2004-06-07');
    
    
-- UPDATE 문 : 특정 투플(행) 값 수정 
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid = 'apple';

-- DELETE 문 : 기존 투플(행) 삭제
DELETE FROM new_customer WHERE custid = 'happy';

-- 외래키로 연결 되어있는 속성인 경우, 연쇄 삭제
DELETE FROM new_customer WHERE custid = 'kiwi';

SELECT * FROM new_customer;
SELECT * FROM new_orders;