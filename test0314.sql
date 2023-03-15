USE new_smartfactory;


CREATE TABLE authors (
	author_id int PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) 
); 
INSERT INTO authors VALUES ( 1, 'J.K', 'Rowling', 'jkrowling@gmail.com' ); 
INSERT INTO authors VALUES ( 2, 'George R.R.', 'Martin', 'grmartin@yahoo.com');
INSERT INTO authors VALUES ( 3, 'Stephen', 'King', 'sking@hotmail.com');

SELECT * FROM authors;

CREATE TABLE books (
	book_id int PRIMARY KEY,
    title VARCHAR(100),
    author_id int, 
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES authors (author_id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO books VALUES ( 1, 'Harry Potter and the Philosopher''s Stone', 1, '1997-06-26' );
INSERT INTO books VALUES ( 2, 'A Game of Thrones', 2, '1996-08-06' );
INSERT INTO books VALUES ( 3, 'The Shining', 3, '1977-01-28' );

SELECT * FROM books;

CREATE TABLE orders (
	order_id int PRIMARY KEY,
    book_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    FOREIGN KEY (book_id) REFERENCES books (book_id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO orders VALUES ( 1, 1, 'John Smith', '2022-02-15' );
INSERT INTO orders VALUES ( 2, 2, 'Jane Doe', '2022-02-16' );
INSERT INTO orders VALUES ( 3, 3, 'Bob Johnson', '2022-02-17' );

SELECT * FROM authors;
SELECT * FROM books;
DESC books;
SELECT * FROM orders;
-- < 추가 실습 >
-- 11. Stephen King이 쓴 모든 책의 제목과 발행일을 표시합니다.
SELECT title, publication_date FROM books JOIN authors 
	ON authors.author_id = books.author_id 
    WHERE last_name = 'King' AND first_name = 'Stephen'; 
 
SELECT title, publication_date FROM books 
	WHERE author_id = ( SELECT author_id FROM authors 
		WHERE last_name = 'King' AND first_name = 'Stephen' );

-- 12. 책을 쓴 저자의 이름을 표시합니다.
SELECT first_name, last_name FROM authors JOIN books
	ON authors.author_id = books.author_id GROUP BY authors.author_id;
    
SELECT first_name, last_name FROM authors 
	WHERE author_id IN ( SELECT author_id FROM books ); 
    

-- 13. 각 저자가 쓴 책의 수를 표시합니다.
SELECT first_name, last_name, COUNT(*) AS 'num_books' FROM books JOIN authors 
	ON authors.author_id = books.author_id GROUP BY authors.author_id;
    

-- 14. 2022년 2월 16일 이후에 발생한 모든 주문에 대한 책 제목과 고객 이름을 표시합니다.
SELECT books.title, orders.customer_name FROM orders JOIN books 
	ON orders.book_id = books.book_id 
    WHERE orders.order_date >= '2022-02-16';
