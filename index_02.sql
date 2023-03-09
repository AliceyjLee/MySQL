-- smartfactory 데이터베이스를 사용하는 명령어 ( 항상 먼저 써야 함 )
USE smartfactory;
SELECT * FROM customer;
SELECT * FROM orders;

-- < SELECT FROM 문 > 

-- 모든 고객의 아이디를 검색
SELECT custid FROM customer;

-- 모든 고객의 고객아이디와 생년월일 검색 
SELECT custid, birth FROM customer;

-- 모든 고객의 생년월일과 고객아이디 검색 ( 순서 있음 )
SELECT birth, custid FROM customer;

-- 모든 고객의 아이디, 주소, 전화번호, 이름, 생년월일 검색
SELECT custid, addr, phone, custname, birth FROM customer;

-- 와일드카드 사용 모든 고객의 아이디, 이름, 주소, 전화번호, 생년월일 검색
-- * (별표 ) : all, 모든 것을 의미 
SELECT * FROM customer;

-- 고객테이블에 있는 모든 주소를 검색 ( 중복 포함된 결과 ) 
SELECT addr FROM customer;

-- 고객테이블에 있는 모든 주소를 검색 ( 중복 제외 ) -> DISTINCT
SELECT DISTINCT addr FROM customer;

-- < WHERE 절 >

-- 비교 : =, >=, >, <, <=
-- 고객 이름이 강해린인 고객을 검색
SELECT * FROM customer WHERE custname = '강해린';

-- 제품 가격이 4000원 이상인 주문 내역 검색
SELECT * FROM orders WHERE price >= 4000;

-- 범위: BETWEEN a AND b 
-- 1995년이상 2000년이하 출생 고객 검색
SELECT * FROM customer WHERE birth BETWEEN '1995-01-01' AND '2000-12-31'; 
SELECT * FROM customer WHERE birth >= '1995-01-01' AND birth <= '2000-12-31'; 

-- 집합 IN, NOT IN
-- 주소가 서울 혹은 런던인 고객 검색 
SELECT * FROM customer WHERE addr IN ('대한민국 서울', '영국 런던');
SELECT * FROM customer WHERE addr = '대한민국 서울' or addr = '영국 런던';
SELECT * FROM customer WHERE addr LIKE '대한민국 서울' or addr LIKE '영국 런던';

-- 주소가 서울 혹은 런던 아닌 고객 검색 
SELECT * FROM customer WHERE addr NOT IN ('대한민국 서울', '영국 런던');
SELECT * FROM customer WHERE addr != '대한민국 서울' or addr != '영국 런던';
SELECT * FROM customer WHERE addr NOT LIKE '대한민국 서울' or addr NOT LIKE'영국 런던';

-- 패턴 LIKE : 특정 패턴을 포함하는 데이터 검색
-- % : 0개 이상의 문자  
-- _: 1개의 단일 문자

-- 주소가 미국 로스엔젤레스인 고객 검색 
SELECT * FROM customer WHERE addr LIKE '미국 로스앤젤레스';

-- 주소에 '미국'이 포함되어 있는 고객 검색 
-- 검출가능한 케이스 예시 : '미국', '미국 뉴욕', ' 미국 워싱턴', '미국 로즈앤젤레스'...
SELECT * FROM customer WHERE addr LIKE '미국%';
-- 주의) 검색 안됨 -> 미국 문자열% 까지 찾음
SELECT * FROM customer WHERE addr = '미국%';
SELECT * FROM customer WHERE addr IN ('미국%');
SELECT * FROM customer WHERE custname LIKE '미국_'; -- '미국 ', '미국인', ...
SELECT * FROM customer WHERE custname LIKE '미국__'; -- '미국  ', '미국사람', ...
SELECT * FROM customer WHERE custname LIKE '_미국_'; -- '난미국인' ...

-- 고객 이름 두번째 글자가 '지'인 고객 검색 
SELECT * FROM customer WHERE custname LIKE '_지_'; -- 이름이 3글자이며, 두번째 글자가 '지'인 경우만 해당 
SELECT * FROM customer WHERE custname LIKE '_지%'; -- 이름 글자 수 제한 없이 두번째 글자가 '지'인 경우
SELECT * FROM customer WHERE custname LIKE '%지%'; -- 이름에 '지'가 들어가는 사람

-- 고객 이름 세번째 글자가 '수'인 고객 검색 
SELECT * FROM customer WHERE custname LIKE '__수%';
SELECT * FROM customer WHERE custname LIKE '__수'; -- 이름이 3자이며, 맨 끝 글자가 '수'인 경우alter

-- 복합 조건 AND, OR, NOT 
-- 주소지가 대한민국이고, 2000년 이후 출생 고객 검색 
SELECT * FROM customer WHERE addr LIKE '대한민국%' AND birth >= '2000-01-01';

-- 주소지가 미국이거나 영국인 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국%' OR addr LIKE '영국%';

-- 휴대폰 번호 마지막 자리가 4가 아닌 고객 검색 
SELECT * FROM customer WHERE phone NOT LIKE '%4';

-- order by 결과출력 순서변경 
-- order by 절을 사용하지 않는 경우, pk기준으로 정렬 ( 인스턴스는 ABC순(오름차순)으로 정렬 )
SELECT * FROM customer;
SELECT * FROM customer ORDER BY custname; -- custname 기준으로 정렬
SELECT * FROM customer ORDER BY custname DESC; -- DESC 내림차순

-- order by & where 함께 사용 
-- 2000년 이후 출생자 중에서 주소를 기준으로 내림차순 검색 
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY addr DESC;

-- 2000년 이후 출생자 중에서 주소를 기준으로 내림차순 그리고 아이디를 기준으로 내림차순 검색
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY addr DESC, custid DESC;

-- ORDER BY 뒤에 여러 개의 속성을 줄 수 있음
SELECT * FROM orders ORDER BY price, amount; 
SELECT * FROM orders ORDER BY amount, price;

-- LIMIT 출력 갯수 제한 주의) LIMIT에서 시작은 0임을 잊지말자 !!
-- LIMIT 형식 : LIMIT 개수 == LIMIT 시작, 개수 == LIMIT 개수 OFFSET 시작
-- ex) LIMIT 2; == LIMIT 0, 2; == LIMIT 2 OFFSET 0
-- 고객 테이블 전체 정보를 조회하는데, 앞에 2건만 조회하고 싶은 경우
SELECT * FROM customer LIMIT 2;
SELECT * FROM customer LIMIT 0, 2;
SELECT * FROM customer LIMIT 2 OFFSET 0;


-- 고객 테이블 전테 정보를 조회하는데, 두번째부터 여섯번째 행만 조회하고 싶은 경우alter
SELECT * FROM customer LIMIT 1, 5;
SELECT * FROM customer LIMIT 5 OFFSET 1;


-- 2000년 이후 출생 고객 중에서 앞에 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' LIMIT 2;

-- 2000년 이후 출생 고객 중에서 고객이름 기준으로 뒤에 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY custid DESC LIMIT 2;

-- IS NULL 
-- 고객 테이블에서 연락처가 존재하지 않는 고객 조회
SELECT * FROM customer WHERE phone IS NULL;
SELECT * FROM customer WHERE birth IS NULL;
SELECT * FROM customer WHERE phone IS NULL AND birth IS NULL;

-- 고객 테이블에서 연락처가 존재하는 고객 조회
SELECT * FROM customer WHERE phone IS NOT NULL;

-- < 집계 함수 >
-- SUM, AVG, MIN, MAX, COUNT
SELECT * FROM orders;

-- 주문 테이블에서 총 주문 내역 건수 조회 (== 투플 개수)
-- COUNT(*): 모든 행의 개수를 카운트
-- COUNT(속성이름): 속성 값이 NULL인 것을 제외하고 카운트
SELECT COUNT(*) AS 'number_orders' FROM orders; 
SELECT COUNT(orderid) FROM orders; 

SELECT COUNT(*) FROM customer; -- 10
SELECT COUNT(phone) FROM customer; -- 9

-- 주문 테이블에서 총 판매 개수 검색
SELECT SUM(amount) FROM orders;

-- 주문 테이블에서 총 판매 개수 검색 + 의미 있는 열 이름으로 변경 
-- AS 변경이름 : 변경이름으로 속성이름을 변경
SELECT SUM(amount) AS 'total_amount' FROM orders;
SELECT SUM(amount) AS total_amount FROM orders; 
SELECT SUM(amount) '총 판매 개수' FROM orders; 

-- 주문 테이블에서 총 판매 개수, 평균 판매 개수, 상품 최저가, 상품 최고가 검색
SELECT SUM(amount) AS 'total_amount',
	AVG(amount) AS 'avg_amount', 
    MIN(price) AS 'min_price', 
    MAX(price) AS 'max_price'
FROM orders;

-- GROUP BY : 속성이름끼리 그룹화 
-- 고객별로 주문한 주문 내역 건수 구하기 
SELECT custid, count(*) FROM orders GROUP BY custid; 

-- 고객별로 주문한 상품 총 수량 구하기 
SELECT custid, SUM(amount) FROM orders GROUP BY custid;

-- 고객별 주문한 총 주문액 구하기 
SELECT custid, SUM(price*amount) '총 주문액' FROM orders GROUP BY custid;

-- 상품별로 판매 개수 구하기 
SELECT prodname, SUM(amount) FROM orders GROUP BY prodname;

-- 상품별로 판매 개수 구하기 + 판매 개수순 내림차순 정렬
SELECT prodname, SUM(amount) FROM orders GROUP BY prodname ORDER BY SUM(amount) DESC;
SELECT prodname, SUM(amount) 'total_amount' FROM orders GROUP BY prodname ORDER BY SUM(amount) DESC;
SELECT prodname, SUM(amount) total_amount FROM orders GROUP BY prodname ORDER BY total_amount DESC;

-- PopQuiz 짝수 해에 태어난 고객 조회
SELECT * FROM customer WHERE YEAR(birth) % 2 = 0;
SELECT * FROM customer WHERE MOD(YEAR(birth), 2) = 0;  

-- PopQuiz 홀수 일에 태어난 고객 조회
SELECT * FROM customer WHERE YEAR(birth) % 2 = 1;
SELECT * FROM customer WHERE MOD(DATE(birth), 2) = 1; 

-- PopQuiz 2000-02-22 다음날에 태어난 고객 조회 
SELECT * FROM customer WHERE birth = DATE('2000-02-22') + 1;

-- HAVING : GROUP BY 명령 이후 추가 조건 
-- GROUP BY + HAVING 반드시 같이 사용
-- WHERE 절보다 뒤에 사용
-- 총 주문액이 10000원 이상인 고객에 대해 고객별로 주문한 상품 총수량 구하기
SELECT custid, SUM(price*amount) total_price, SUM(amount) total_amount 
	FROM orders 
	GROUP BY custid 
    HAVING SUM(price*amount) >= '10000';
    
    -- 총 주문액이 10000원 이상인 고객에 대해 고객별로 주문한 상품 총 수량 구하기 ( 단, custid가 'bunny'인 경우 제외 )
SELECT custid, SUM(price*amount) total_price, SUM(amount) total_amount
    FROM orders
    WHERE custid != 'bunny'                                                     -- WHERE절이 있을 때
	GROUP BY custid 
    HAVING SUM(price*amount) >= '10000';
    
SELECT custid, SUM(price*amount) total_price, SUM(amount) total_amount
    FROM orders
	GROUP BY custid 
    HAVING SUM(price*amount) >= '10000' AND custid != 'bunny';                   -- WHERE절이 없을 때


