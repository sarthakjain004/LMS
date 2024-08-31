create table Person(
	person_id INTEGER PRIMARY KEY auto_increment,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role ENUM('Admin','Librarian','User') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
create table Admin(
	admin_id INT PRIMARY KEY,
    salary decimal(10,2) not null,
    admin_level ENUM('Super Admin', 'System Admin', 'Library Manager', 'Department Head', 'Admin Assistant') NOT NULL,
    foreign key (admin_id) references Person(person_id)
);
create table Librarian(
	librarian_id int primary key,
    salary decimal(10,2) not null,
    employment_date date not null,
    foreign key (librarian_id) references Person(person_id)
);
create table User(
	user_id int primary key,
    membership_start_date date DEFAULT NULL, -- can be null if membership type is Regular. if Premium then it should have a value.
    membership_end_date date DEFAULT NULL,
    membership_type ENUM('Regular','Premium') not null,
    foreign key (user_id) references Person(person_id)
);


CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    Genre VARCHAR(50),
    PublicationDate DATE,
    CurrentState ENUM('Available', 'Borrowed', 'Lost') NOT NULL DEFAULT 'Available',
    times_issued INT DEFAULT 0,
    Rating FLOAT(2,1) DEFAULT 0.0    --MySQL permits a nonstandard syntax: FLOAT(M,D) or REAL(M,D) or DOUBLE PRECISION(M,D). Here, (M,D) means than values can be stored with up to M digits in total, of which D digits may be after the decimal point.
    BookType ENUM('Regular', 'Premium') NOT NULL DEFAULT 'Regular',
    NumberOfCopies INT NOT NULL DEFAULT 1, --number of permanent copies in the book class.
    NumberOfBorrowedCopies INT NOT NULL DEFAULT 0
);
CREATE TABLE borrowed_books (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    user_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE borrow_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    user_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NOT NULL,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE purchase_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    librarian_id INT NOT NULL,
    book_title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (librarian_id) REFERENCES Librarian(librarian_id)
);