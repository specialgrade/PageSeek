 --Table Definitions (Open for Revisions)
 CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
 );
  
 CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
 );

 CREATE TABLE librarians (
    librarian_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
 );

 CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
 );

 CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
 );

 CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role ENUM('student', 'teacher', 'librarian') NOT NULL, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
 );
 
 CREATE TABLE book_copies (
    copy_id SERIAL PRIMARY KEY,
    book_id INT,
    status ENUM('available', 'borrowed', 'reserved', 'lost', 'damaged') NOT NULL, 
    FOREIGN KEY (book_id) REFERENCES books(book_id)
 );

 CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    book_id INT,
    user_id INT,
    reservation_date DATE,
    expiration_date DATE,
    status ENUM('active', 'fulfilled', 'cancelled', 'expired') NOT NULL, 
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
 );

 CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
 );

 CREATE TABLE book_genres (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
 );

 CREATE TABLE borrowing_records (
    borrow_id SERIAL PRIMARY KEY,
    book_id INT,
    borrower_id INT,
    borrowed_by VARCHAR(50) NOT NULL,
    librarian_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    status ENUM('borrowed', 'returned', 'overdue') NOT NULL, 
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (borrower_id) REFERENCES users(user_id),
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
 );

 CREATE TABLE fines (
    fine_id SERIAL PRIMARY KEY,
    borrow_id INT,
    amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') NOT NULL, 
    paid_date DATE,
    FOREIGN KEY (borrow_id) REFERENCES borrowing_records(borrow_id)
 );
