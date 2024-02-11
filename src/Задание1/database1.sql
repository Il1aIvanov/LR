create database library;	

create table Books (
    BookID int primary key,
    ISBN varchar (255),
    BookTitle varchar (255),
    CountPages int,
    PublishingDate date
);
insert into Books (BookID, ISBN, BookTitle, CountPages, PublishingDate) values 
(1, '123-4567-890', 'Преступление и наказание', 500, '1866-01-01'),
(2, '098-7654-321', 'Анна Каренина', 864, '1877-01-01'),
(3, '111-1111-111', 'Русская и советская фантастика', 320, '1989-01-01'),
(4, '222-2222-222', 'Руслан и Людмила', 150, '1820-01-01'),
(5, '333-3333-333', 'Капитанская дочка', 250, '1836-01-01'),
(6, '444-4444-444', 'Война и мир', 1225, '1869-01-01');

create table Authors (
    AuthorID int primary key,
    FirstName varchar (255),
    SecondName varchar (255)
);
insert into Authors (AuthorID, FirstName, SecondName) values 
(1, 'Федор', 'Достоевский'),
(2, 'Лев', 'Толстой'),
(3, 'Александр', 'Пушкин');

create table Genres (
    GenreID int primary key,
    GenreTitle varchar (255)
);
insert into Genres (GenreID, GenreTitle) values 
(1, 'Роман'),
(2, 'Поэзия'),
(3, 'Детектив'),
(4, 'Фантастика');

create table BookAuthor (
    BookID int,
    AuthorID int,
    foreign key (BookID) references Books(BookID),
    foreign key (AuthorID) references Authors(AuthorID) 
);

insert into BookAuthors (BookID, AuthorID) values
(1, 1),
(2, 2),
(3, 3),
(4, 3),
(5, 3),
(6, 2);

create table BookGenres (
    BookID int,
    GenreID int,
    foreign key (BookID) references Books(BookID),
    foreign key (GenreID) references Genres(GenreID) 
);

insert into BookGenres (BookID, GenreID) values
(1, 1),
(2, 1),
(3, 4),
(4, 2),
(5, 3),
(6, 1);


SELECT b.BookTitle, CONCAT(a.FirstName, ' ', a.SecondName) AS Author
FROM Books b
JOIN BookAuthor ba ON b.BookID = ba.BookID
JOIN Authors a ON ba.AuthorID = a.AuthorID
JOIN BookGenres bg ON b.BookID = bg.BookID
JOIN Genres g ON bg.GenreID = g.GenreID
WHERE g.GenreTitle = 'Фантастика';

SELECT CONCAT(a.FirstName, ' ', a.SecondName) AS Author, COUNT(*) AS BooksCount
FROM Authors a
JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID
GROUP BY a.AuthorID
ORDER BY BooksCount DESC
LIMIT 1; 