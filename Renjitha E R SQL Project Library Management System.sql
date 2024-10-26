CREATE DATABASE Library;
USE Library;
CREATE TABLE Branch (Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15));
desc Branch; 
INSERT INTO Branch VALUES
(1, 101, 'Downtown', '123-456-7890'),
(2, 102, 'Uptown', '123-456-7891'),
(3, 103, 'Suburban', '123-456-7892'),
(4, 104, 'City Center', '123-456-7893'),
(5, 105, 'Eastside', '123-456-7894');
select * from Branch;

CREATE TABLE Employee (Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
    desc employee;
INSERT INTO Employee VALUES
(101, 'Alice', 'Manager', 60000, 1),
(102, 'Bob', 'Librarian', 45000, 2),
(103, 'Charlie', 'Assistant', 35000, 3),
(104, 'Diana', 'Manager', 55000, 4),
(105, 'Eve', 'Librarian', 42000, 5),
(106, 'Frank', 'Assistant', 30000, 1),
(107, 'Grace', 'Assistant', 28000, 2),
(108, 'Hannah', 'Manager', 65000, 3),
(109, 'Ivy', 'Librarian', 50000, 4),
(110, 'Jack', 'Assistant', 32000, 5);
SELECT * FROM EMPLOYEE;

CREATE TABLE Books (ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100));
DESC Books;
INSERT INTO Books VALUES
(1001, 'Python Basics', 'Programming', 30.00, 'yes', 'John Doe', 'TechBooks'),
(1002, 'Advanced SQL', 'Database', 35.00, 'no', 'Jane Smith', 'DataBooks'),
(1003, 'History of Rome', 'History', 25.00, 'yes', 'Peter Paul', 'HistoryPress'),
(1004, 'Java for Beginners', 'Programming', 28.00, 'yes', 'Lucy Brown', 'TechBooks'),
(1005, 'World War II', 'History', 40.00, 'no', 'George White', 'HistoryPress'),
(1006, 'Data Science 101', 'Data Science', 45.00, 'yes', 'Alice Green', 'DataBooks'),
(1007, 'Algorithms Unlocked', 'Computer Science', 50.00, 'yes', 'Mike Blue', 'TechBooks'),
(1008, 'Modern Art', 'Arts', 20.00, 'no', 'Emma Black', 'ArtBooks'),
(1009, 'Ancient Egypt', 'History', 22.00, 'yes', 'Sophia Gold', 'HistoryPress'),
(1010, 'Cooking Mastery', 'Lifestyle', 15.00, 'yes', 'Ethan Gray', 'FoodBooks');
select * from books;

CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE);
desc Customer;
INSERT INTO Customer VALUES
(1, 'Oliver', '123 Maple St', '2021-12-20'),
(2, 'Emma', '456 Oak St', '2022-02-15'),
(3, 'Noah', '789 Pine St', '2020-11-30'),
(4, 'Ava', '321 Birch St', '2023-06-10'),
(5, 'Sophia', '654 Cedar St', '2023-06-12');
select * from customer;

CREATE TABLE IssueStatus (Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
desc IssueStatus;
INSERT INTO IssueStatus VALUES
(1, 1, 'Python Basics', '2021-12-21', 1001),
(2, 2, 'Data Science 101', '2022-02-20', 1006),
(3, 4, 'History of Rome', '2023-06-11', 1003),
(4, 5, 'Ancient Egypt', '2023-06-13', 1009);
select * from IssueStatus;

CREATE TABLE ReturnStatus (Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));
desc ReturnStatus;
INSERT INTO ReturnStatus VALUES
(1, 1, 'Python Basics', '2021-12-30', 1001),
(2, 2, 'Data Science 101', '2022-03-01', 1006);
select * from ReturnStatus;

-- Question No 1
    
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';

-- Question No 2
 
 SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- Question No 3
 
SELECT B.Book_title, C.Customer_name 
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

-- Question No 4

SELECT Category, COUNT(*) AS Book_Count 
FROM Books 
GROUP BY Category;

-- Question No 5

SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

-- Question No 6

SELECT C.Customer_name 
FROM Customer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

-- Question No 7

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no;

-- Question No 8

SELECT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Question No 9

SELECT Book_title 
FROM Books 
WHERE Category LIKE '%History%';

-- Question No 10

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- Question No 11

SELECT E.Emp_name, B.Branch_address 
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;

-- Question No 12

SELECT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;