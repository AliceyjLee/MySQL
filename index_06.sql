USE new_smartfactory;

-- DCL 데이터 제어어 : GRANT, REVOKE
SELECT * FROM new_customer;

-- 현재 root 사용자만 존재 -> 새로운 사용자 ( 유저, 계정 ) 추가 ( codee )
-- 구조 : CREATE USER '계정명'@'접속경로' IDENTIFIED BY '비밀번호';
-- 새로운 사용자 추가 
CREATE USER 'codee'@'localhost' IDENTIFIED BY '4321';

-- 새로 생성한 사용자 확인 
SELECT user FROM mysql.user; -- mysql 데이터베이스의 user 테이블

-- 사용자 삭제 
DROP USER 'codee'@'localhost';
FLUSH PRIVILEGES;     -- 새로고침해야 반영됨

-- 참고) MySQL 사용자 비밀번호 변경하고 싶다면? 
ALTER USER 'codee'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';
FLUSH PRIVILEGES;     -- 새로고침해야 반영됨


-- GRANT 문 : 특정 데이터베이스 사용자에게 특정 작업에 대한 수행 권한 부여
-- codee에게 모든 권한 부여
-- 구조 : GRANT 권한유형 ON 데이터베이스명.테이블명 TO '계정명'@'접속경로' WITH GRANT OPTION; 
-- 모든 데이터베이스의 모든 테이블 : *.*
-- 모든 권한 부여 : GRANT ALL PRIVILEGES
-- 다른 사용자한테 권한을 부여 가능하게 하는 옵션 : WITH GRANT OPTION
GRANT ALL PRIVILEGES ON *.* TO 'codee'@'localhost' WITH GRANT OPTION; 

-- GRANT [권한 유형] ON [데이터베이스이름].[테이블이름] 
-- GRANT ALL PRIVILEGES ON [데이터베이스이름].* 
-- => 특정 데이터베이스의 모든 테이블에 / 모든 권한 부여 
-- GRANT ALL PRIVILEGES ON [데이터베이스이름].[테이블이름] 
-- => 특정 데이터베이스의 특정 테이블에 / 모든 권한 부여 
-- GRANT SELECT ON [데이터베이스이름].[테이블이름] 
-- => 특정 데이터베이스의 특정 테이블에 / SELECT 권한 부여 
-- GRANT SELECT, INSERT ON [데이터베이스이름].[테이블이름] 
-- => 특정 데이터베이스의 특정 테이블에 / SELECT, INSERT 권한 부여 

CREATE USER 'happy'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON new_smartfactory.* TO 'happy'@'localhost' WITH GRANT OPTION;

-- REVOKE 문 : 특정 데이터베이스 사용자에게 특정 작업에 대한 권한 박탈 
-- 구조 : REVOKE 권한유형 ON 데이터베이스명.테이블명 FROM '계정명'@'접속경로';
REVOKE DELETE ON *.* FROM 'codee'@'localhost';
REVOKE ALL ON *.* FROM 'codee'@'localhost';

