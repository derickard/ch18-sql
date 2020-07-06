CREATE TABLE book (
   book_id INT AUTO_INCREMENT PRIMARY KEY,
   author_id INT,
   title VARCHAR(255),
   isbn INT,
   available BOOL,
   genre_id INT
);

CREATE TABLE author (
   author_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   birthday DATE,
   deathday DATE
);

CREATE TABLE patron (
   patron_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   loan_id INT
);

CREATE TABLE reference_books (
   reference_id INT AUTO_INCREMENT PRIMARY KEY,
   edition INT,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

INSERT INTO reference_books(edition, book_id)
VALUE (5,32);

CREATE TABLE genre (
   genre_id INT PRIMARY KEY,
   genres VARCHAR(100)
);

CREATE TABLE loan (
   loan_id INT AUTO_INCREMENT PRIMARY KEY,
   patron_id INT,
   date_out DATE,
   date_in DATE,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

-- Mystery books
select title,isbn from book where genre_id = (Select genre_id from genre where genres LIKE "mystery");

-- Titles and authors for authors still living
select title,first_name,last_name from book inner join author on book.author_id = author.author_id where deathday IS null;

-- Loan out a book
-- patron_id = 21 checks out book_id = 21
update book set available = 0 where book_id = 21; 
insert into loan (patron_id, date_out, book_id) values (21, CURDATE(), 21);
update patron set loan_id = (SELECT loan_id FROM loan where patron_id = 21) where patron_id = 21;

-- Check a book back in
-- patron_id = 21 checks back in book_id = 21
update loan set date_in = curdate() where loan_id = (SELECT loan_id from patron where patron_id=21);
update patron set loan_id = null where patron_id = 21;
update book set available = 1 where book_id = 21; 


-- 5 check outs
-- patron_id = 2 checks out book_id = 12
update book set available = 0 where book_id = 12; 
insert into loan (patron_id, date_out, book_id) values (2, CURDATE(), 12);
update patron set loan_id = (SELECT loan_id FROM loan where patron_id = 2) where patron_id = 2;

-- patron_id = 4 checks out book_id = 14
update book set available = 0 where book_id = 14; 
insert into loan (patron_id, date_out, book_id) values (4, CURDATE(), 14);
update patron set loan_id = (SELECT loan_id FROM loan where patron_id = 4) where patron_id = 4;

-- patron_id = 6 checks out book_id = 16
update book set available = 0 where book_id = 16; 
insert into loan (patron_id, date_out, book_id) values (6, CURDATE(), 16);
update patron set loan_id = (SELECT loan_id FROM loan where patron_id = 6) where patron_id = 6;

-- patron_id = 8 checks out book_id = 18
update book set available = 0 where book_id = 18; 
insert into loan (patron_id, date_out, book_id) values (8, CURDATE(), 18);
update patron set loan_id = (SELECT loan_id FROM loan where patron_id = 8) where patron_id = 8;

-- patron_id = 10 checks out book_id = 20
update book set available = 0 where book_id = 20; 
insert into loan (patron_id, date_out, book_id) values (10, CURDATE(), 20);
update patron set loan_id = (SELECT loan_id FROM loan where patron_id = 10) where patron_id = 10;


-- Checked out books by patron/genre
select first_name,last_name,genres 
from loan 
inner join patron 
on loan.patron_id = patron.patron_id
inner join book
on loan.book_id = book.book_id
inner join genre
on book.genre_id = genre.genre_id
where date_in is null;

-- Bonus
-- Counts
select genres AS Genre,COUNT(*) AS Count from book inner join genre on book.genre_id = genre.genre_id group by book.genre_id order by COUNT(*) desc;


-- Reference never leaves


