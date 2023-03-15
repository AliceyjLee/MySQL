USE smartfactory;
SELECT * FROM orders;
SELECT * FROM customer;
INSERT INTO customer VALUES ( 'sky2', '이찬혁', '일본 오사카', '01012341234', NULL );

-- JOIN 문 : 두 테이블 엮기

-- 조건없는 테이블간의 JOIN
SELECT * FROM customer, orders; 

SELECT COUNT(*) FROM customer;  -- 9명
SELECT COUNT(*) FROM orders;    -- 19건
SELECT COUNT(*) FROM customer, orders; -- 171 = 9명 * 19건 
-- a 고객이 orders의 19개 행과 결합, b 고객이 orders의 19개 행과 결합, .... -> 논리에 안맞음 !! 

-- WHERE 절을 이용해 JOIN 조건 추가
-- 테이븖명.속성명 표기 : 특정 테이블의 열을 가르킴
SELECT * FROM customer, orders WHERE customer.custid = orders.custid;
SELECT * FROM customer INNER JOIN orders ON customer.custid = orders.custid;
SELECT * FROM customer JOIN orders ON customer.custid = orders.custid;  -- INNER 생략가능
SELECT * FROM orders JOIN customer ON customer.custid = orders.custid;  -- 테이블명 순서가 바뀌면, 앞에 테이블 속성부터 차례로 추출 

-- custid 순으로 정렬 
SELECT * FROM customer, orders 
	WHERE customer.custid = orders.custid 
	ORDER BY customer.custid;
SELECT * FROM customer 
	INNER JOIN orders ON customer.custid = orders.custid 
    ORDER BY customer.custid;

-- 고객별로 주문한 제품 총 구매액 조회
SELECT custname, SUM(price*amount) AS 'total_price' FROM customer 
	JOIN orders ON customer.custid = orders.custid 
    GROUP BY custname ORDER BY custname;
    
SELECT custname, SUM(price*amount) AS 'total_price' FROM customer, orders
	WHERE customer.custid = orders.custid
    GROUP BY custname ORDER BY custname;

-- SUB QUERY : 서브 쿼리, 부속 질의
-- SQL 문 내에 또 다른 SQL 문 작성
-- SELECT 문의 WHERE 절에 또 다른 테이블 결과를 이용해서 다시 SELECT 문을 괄호로 묶는다.
-- 구조 -> SELECET ~ FROM ~ WHERE ( SELECT ~ FROM ~ ) ~ 
-- STEP 1. 주문 금액이 가장 큰 주문 내역은 무엇인가?
SELECT MAX(price*amount) AS'Max' FROM orders;

-- STEP 2. 가장 큰 주문 금액이 내역의 주문아이디, 고객아이디, 상품명 조회
SELECT orderid, custid, prodname FROM orders WHERE price*amount = 10000;

-- STEP 3. 서브 쿼리를 이용해 두 SQL 문을 하나로 합치기 
SELECT orderid, custid, prodname FROM orders 
	WHERE price*amount = ( SELECT MAX(price*amount) AS'Max' FROM orders );
    
-- 주문 이력이 있는 고객 조회 
SELECT custname FROM customer WHERE custid IN ( SELECT custid FROM orders );