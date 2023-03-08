USE smartfactory;
SELECT * FROM user;

-- 1. 모든 회원목록 중 birthday 오름차순 기준 정렬 검색
SELECT * FROM user ORDER by birthday;
-- 2. 회원목록 중 gender 값이 'M'인 회원목록 이때 name 내림차순 정렬 검색
SELECT * FROM user WHERE gender = 'M'ORDER BY Name DESC;
-- 3. 1990년대 출생 회원의 id, Name 검색
SELECT Id, Name FROM user Where birthday BETWEEN '1900-01-01' AND '1999-12-31'; 
-- 4. 6월생 회원목록 birthday 오름차순 정렬 검색
SELECT * FROM user Where birthday LIKE '%-06-%' ORDER BY birthday;
-- 5. gender 값이 'M', 1970년대 출생 회원 검색
SELECT * FROM user WHERE gender LIKE 'M' AND birthday BETWEEN '1970-01-01' AND '1979-12-31';
-- 6. 모든 회원목록 중 age 내림차순 정렬, 처음 3개만 검색 
SELECT * FROM user ORDER BY age DESC LIMIT 3;
-- 7. 모든 회원목록 중 나이가 25이상 50이상 회원 목록 검색
SELECT * FROM user WHERE age BETWEEN '25' AND '50';
