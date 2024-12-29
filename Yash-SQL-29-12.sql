
##Que 1. Create a table called employees with the following structure?

#Ans .-- create database office;
create table employees  (emp_id char (30) primary key , 
emp_name varchar (30) not null, 
age int CHECK (Age>=18) ,
email varchar(30) unique
, salary varchar(30) default("30.000")) ;
select *from employees;   ##If you run this query you can see the table with this constraints but the vlaues are null

#Que 2 Explain the purpose of constraints and how they help maintain data integrity in a database. Provide eamples of common types of constraints.
#Ans. #Purpose of Constraints in a Database:
#Constraints in a database are rules enforced on the data in tables to ensure the accuracy, validity, and integrity of the data. By restricting
#the type of data that can be stored or the relationships
# between tables, constraints help maintain the consistency and reliability of the database. They prevent invalid data entry, ensure relationships between data are meaningful, and facilitate efficient
#query execution.

#Types of constraints with thier examples are 

#1. CHECK Constraint: CHECK Constraint: Ensures the condition specified within the parentheses is met for the column.
#olumn-level CHECK: You can also define the CHECK constraint directly within the column definition:

#Example 
CREATE TABLE Persons (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT chk_age CHECK (age >= 18)
);   ##This is will make sure that every peroson age in the data base is alteast greater than or equat to 18

#2. NOT NULL Constraint: Ensures that a column cannot have a NULL value.

CREATE TABLE Employees (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL
); ## It Ensures every employee has an ID and name.

#3. UNIQUE Constraint: Ensures that all values in a column or a combination of columns are unique.

CREATE TABLE Users (
    email VARCHAR(255) UNIQUE,
    username VARCHAR(50) UNIQUE
); #It will make sure that Prevents duplicate email addresses or usernames.

#4 .PRIMARY KEY Constraint: Combines the NOT NULL and UNIQUE constraints to uniquely identify a row in a table.


-- Create a table with a Primary Key constraint
CREATE TABLE Customers (
    CustomerID INT NOT NULL PRIMARY KEY,  -- Primary Key Constraint
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100)
);

#5 Default Constraint

#Assigns a default value to a column if no value is provided during an insert operation.
#Example: A Status column in a Tasks table with a default value of 'Pending'.

-- Create a table with a DEFAULT constraint
-- Create a table with a DEFAULT constraint
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,                 -- Primary Key
    TaskName NVARCHAR(100) NOT NULL,        -- Task Name (mandatory)
    Status NVARCHAR(20) DEFAULT 'Pending',  -- Default value is 'Pending'
    CreatedDate DATE DEFAULT GETDATE()      -- Default value is the current date
);

-- Insert data without specifying the Status and CreatedDate
INSERT INTO Tasks (TaskID, TaskName)
VALUES (1, 'Complete project documentation');

-- Insert data by overriding the default values
INSERT INTO Tasks (TaskID, TaskName, Status, CreatedDate)
VALUES (2, 'Review code', 'In Progress', '2024-12-15');

-- Select data to see the effect of the DEFAULT constraint
SELECT * FROM Tasks;

# 6. Foreign Key Constraint

#Ensures that values in one table correspond to valid entries in another table, maintaining referential integrity.
#Example: A ProductID in an Orders table must match a valid ProductID in the Products table.

-- Create Customers Table (Parent Table)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,  -- Primary Key
    CustomerName VARCHAR(100) NOT NULL
);

-- Create Orders Table (Child Table)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,         -- Primary Key
    OrderDate DATE NOT NULL,
    CustomerID INT,                  -- Foreign Key Column
    FOREIGN KEY (CustomerID)         -- Define Foreign Key
        REFERENCES Customers(CustomerID) -- Link to Customers Table
        ON DELETE CASCADE             -- Delete orders if the customer is deleted
        ON UPDATE CASCADE             -- Update CustomerID in Orders if changed in Customers
);

#Que 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
#your answer ?

#Ans. The NOT NULL constraint is applied to a column to ensure that it cannot contain NULL (empty or undefined) values. This constraint is essential in cases where data is mandatory and the absence of a value would be illogical or lead to incomplete information.

#Reasons to Use NOT NULL
#Data Integrity: Ensures critical fields always have valid data.

#Example: A username column in a Users table should never be left empty.
#Logical Consistency: Prevents invalid scenarios due to missing values.

#Example: A price column in a Products table must always have a valid value.
#Query Optimization: Indexing and performance may improve because the database doesn't need to account for NULL values in the column.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL
);
#In this example, the FirstName, LastName, and HireDate columns cannot have empty values.


#No, a primary key cannot contain NULL values.

#Justification
#Definition of a Primary Key:

#A primary key is used to uniquely identify each row in a table.
#For a row to be uniquely identifiable, the primary key value must exist and be distinct.
#Behavior of NULL:

#NULL represents an unknown or undefined value, which violates the principle of uniqueness and consistency required by a primary key.
#Database Enforcement:

#Most database systems enforce the NOT NULL constraint automatically on columns designated as primary keys.

#Que 4 Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
#example for both adding and removing a constraint.?

#Ans . Steps to Add or Remove Constraints on an Existing Table
#1. Adding Constraints
#To add a constraint to an existing table, use the ALTER TABLE statement with the appropriate ADD CONSTRAINT clause.

Steps
#1. the table and column where the constraint needs to be added.
#2. Use the ALTER TABLE statement to define and add the constraint.
#3. Specify the type of constraint (NOT NULL, UNIQUE, CHECK, FOREIGN KEY, etc.) and its definition.
#Example: Adding a Foreign Key Constraint
-- Step 1: Create the parent table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 2: Create the child table without the foreign key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT
);

-- Step 3: Add the foreign key constraint to link Orders with Customers
ALTER TABLE Orders
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

#2. Removing Constraints
#To remove a constraint, use the ALTER TABLE statement with the DROP CONSTRAINT clause. Note that the exact syntax may vary slightly depending on the database system.

#Steps
#Identify the table and constraint to be removed.
#Use the ALTER TABLE statement with the DROP CONSTRAINT clause, specifying the constraint name.
#Example: Removing a Foreign Key Constraint
-- Step 1: Drop the foreign key constraint
ALTER TABLE Orders
DROP CONSTRAINT FK_CustomerID;

-- Step 2: Verify that the constraint is removed
DESCRIBE Orders; -- Check the schema of the table (specific command depends on the database system)

#Que 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
#Provide an example of an error message that might occur when violating a constraint.

#Ans. Consequences of Violating Constraints in a Database
#When attempting to insert, update, or delete data in a way that violates constraints, the database management system (DBMS) enforces the 
#rules set by the constraints and generates an error. This prevents the operation from completing, ensuring that data integrity is maintained.

#Types of Violations and Their Consequences
#1. Violating a NOT NULL Constraint
#Cause: Attempting to insert or update a NULL value into a column with a NOT NULL constraint.
#Consequence: The database rejects the operation, as a mandatory field cannot be left empty.
#Example:
INSERT INTO Employees (EmployeeID, LastName)
VALUES (1, NULL);
ERROR: Column 'LastName' cannot be null

#2.Violating a UNIQUE Constraint
#Cause: Attempting to insert or update a value that duplicates an existing value in a column with a UNIQUE constraint.
#Consequence: The database rejects the operation, preventing duplicate data.
#Example INSERT INTO Users (UserID, Email)
VALUES (101, 'user@example.com');  -- First insertion is successful

INSERT INTO Users (UserID, Email)
VALUES (102, 'user@example.com');  -- Duplicate email violates UNIQUE constraint

ERROR: Duplicate entry 'user@example.com' for key 'Users.Email'

#3. . Violating a FOREIGN KEY Constraint
#Cause: Attempting to insert or update a foreign key value that does not match a primary key in the referenced table, or deleting a referenced primary key.
#Consequence: The database rejects the operation, ensuring referential integrity.

INSERT INTO Orders (OrderID, CustomerID)
VALUES (1, 999);  -- CustomerID 999 does not exist in the Customers table


ERROR: Foreign key constraint failed

#4.  Violating a CHECK Constraint
#Cause: Inserting or updating a value that fails to satisfy a condition defined by a CHECK constraint.
#Consequence: The database rejects the operation to prevent invalid data entry.
#Example:

INSERT INTO Products (ProductID, Price)
VALUES (101, -50);  -- Negative price violates CHECK constraint


ERROR: CHECK constraint failed: Products.Price > 0

#5 .Violating a PRIMARY KEY Constraint
#Cause: Inserting duplicate values or NULL into a column defined as a primary key.
#Consequence: The database rejects the operation because primary keys must be unique and not null.
#Example

INSERT INTO Orders (OrderID, OrderDate)
VALUES (1, '2024-12-01');  -- First insertion

INSERT INTO Orders (OrderID, OrderDate)
VALUES (1, '2024-12-02');  -- Duplicate OrderID

#ERROR: Duplicate entry '1' for key 'Orders.PRIMARY'

#Key Takeaways
#Purpose of Errors: These errors serve to uphold the rules defined by constraints, ensuring the database remains consistent and reliable.
#Action Required: When an error occurs, the user must correct the operation to align with the constraints (e.g., fixing invalid data or
#updating related records).

#6. You created a products table without constraints as follows:

#CREATE TABLE products (

    #product_id INT,

    #product_name VARCHAR(50),

    #price DECIMAL(10, 2));  
#Now, you realise that?
#: The product_id should be a primary keyQ
#: The price should have a default value of 50.00

	
create database product;
create table products (product__id int , product_name varchar(50),
price_of_product decimal (10,2));

#Now we adding the constraints 

alter table products 
add primary key(product__id);

alter table products
alter column  price_of_product set default ("50.00");

#Que 7. You have two tables?

#Ans
create database school;
create table students
(student_id char (30), student_name varchar(50) ,class_id int );

insert into students (student_id , student_name ,class_id)
 values ("1" ,"Alice" ,"101"),
("2","Bob","102"),
("3","chalrie","101");
select*from students;

create table classes
(class_id char (30) , class_name varchar(30));

insert into classes (class_id, class_name)
values ("101" ,"maths") ,
("102","science"), 
("103","history");

select student_name, student_id from students inner join classes 
on students.class_id = classes.class_id;

#Que 8 .Consider the following three tables:

drop database xyz_manf;

create database xyz_manf;    #crate table order 
CREATE TABLE Orders_1 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);

INSERT INTO Orders_1 (order_id, order_date, customer_id)
VALUES (1, '2024-01-01', 101),
       (2, '2024-01-03', 102);
       
#2. Create Customers Table and Insert Data

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO Customers ( customer_id, customer_name)
VALUES (101, 'Alice'),
       (102, 'Bob');
       
#3. Create Products Table and Insert Data

CREATE TABLE Products_1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    order_id INT NULL
);

INSERT INTO Products_1 (product_id, product_name, order_id)
VALUES (1, 'Laptop', 1),
       (2, 'Phone', NULL);
       
select*from orders_1;
select*from Customers;
select*from products_1;

select order_id,customer_name from  orders_1 inner join 
Customers on orders_1.customer_id = Customers.customer_id;

#Que 9. Given the following tables:

#Ans. 

create database laptop_shope;
CREATE TABLE Sales_1 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10, 2)
);

INSERT INTO Sales_1 (sale_id, product_id, amount)
VALUES 
    (1, 101, 500),
    (2, 102, 300),
    (3, 101, 700);
    
CREATE TABLE Products_500 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

INSERT INTO Products_500 (product_id, product_name)
VALUES 
    (101, 'Laptop'),
    (102, 'Phone');
    
select sum(amount) as Sum_of_amount,product_name from Sales_1 inner join
Products_500 on Products_500.product_id = Sales_1.product_id
group by product_name;

#Que 10 . You are given three tables:?

#Ans. 

create database Que_10l;
create table order_10 (order_id int primary key , 
order_date char (30) , cx_id varchar (30) );

insert into order_10 values ("1" , "2024-01-02", "1"),
("2" , "2024-01-05", "2");

CREATE TABLE Customers_10 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO Customers_10 (customer_id, customer_name)
VALUES 
    (1, 'Alice'),
    (2, 'Bob');
    
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO Order_Details (order_id, product_id, quantity)
VALUES 
    (1, 101, 2),
    (1, 102, 1),
    (2, 101, 3);

select order_id,customer_name,sum(quantity) as Each_cm from order_10
inner join
Customers_10 on order_10.customer_id = Customers_10.customer_id
inner join 
Order_Details on Order_Details.order_id = order_10.order_id
group by
order_id, customer_name;	

#SQL Commands
use mavenmovies;

#Identifying Primary and Foreign Keys in the Maven Movies Database
#In a database like "Maven Movies," where we typically have tables such as Movies, Actors, Directors, Genres, and Movie_Roles
#(as examples), the primary keys (PK) and foreign keys (FK) are critical for maintaining data integrity and establishing relationships.

##1. Primary Keys
#A primary key is a unique identifier for each record in a table. Every table must have one primary key to distinguish each row.

#Example Primary Keys:
#Movies Table:
#movie_id (PK) - Uniquely identifies each movie.
#Actors Table:
#actor_id (PK) - Uniquely identifies each actor.
#Directors Table:
#director_id (PK) - Uniquely identifies each director.
#Genres Table:
#genre_id (PK) - Uniquely identifies each genre.
#Movie_Roles Table:
#Composite Primary Key: (movie_id, actor_id) - Represents a unique combination of a movie and the actor's role in that movie.

#2. Foreign Keys
#A foreign key is a column or set of columns in one table that establishes a relationship with a primary key in another table. Foreign keys ensure referential integrity between tables.

#Example Foreign Keys:
#Movies Table:
#director_id (FK) - References director_id in the Directors table.
#genre_id (FK) - References genre_id in the Genres table.
#Movie_Roles Table:
#movie_id (FK) - References movie_id in the Movies table.
#actor_id (FK) - References actor_id in the Actors table.

#Differences Between Primary Keys and Foreign Keys
#Feature	Primary Key	Foreign Key
#Definition	Uniquely identifies each record in a table.	Creates a link between two tables.
#Uniqueness	Must be unique for each row.	Can have duplicate values.
#Nullability	Cannot contain NULL values.	Can contain NULL values (optional links).
#Purpose	Ensures each row in the table is unique.	Ensures referential integrity across tables.
#Example	movie_id in Movies is a PK.	director_id in Movies is an FK.


#Summary
#Primary Keys uniquely identify rows within a single table.
#Foreign Keys establish and enforce relationships between two tables, ensuring referential integrity.
#Primary and Foreign Keys are foundational for relational databases, as they define structure and maintain consistent relationships between data.
#Let me know if you want to explore queries or further examples! 

#Que 2. List all details of actors?

#Ans. 
select*from actor;

#Explanation
#SELECT *: Retrieves all columns from the Actors table.
#FROM Actors: Specifies the table from which to fetch the data.

##Not  for auditor of this file excute acc when you needed as there is no mulltiple table in full file
##Since it is SQL file u can excute each and every coode when you needed.  

#Que 3.  -List all customer information from DB.

select*from customer;

#Explanation
#SELECT *: Retrieves all columns from the customer table.
#FROM customer: Specifies the table from which to fetch the data.

# Que 4 -List different countries.

#Ans 
select*from country;
#Explanation
#SELECT *: Retrieves all columns from the country table.
#FROM country: Specifies the table from which to fetch the data.

#Que 5. -Display all active customers?.

#Ans. 

select * from customer   #It is the query of the active cm is avilable in the table of the coustmer cm.
where  active = '1';

#Que 6. -List of all rental IDs for customer with ID 1.

#Ans. 
select*from rental
where customer_id = '1';

#SELECT *: Retrieves all columns from the rental table.
#FROM rental: Specifies the table from which to fetch the data.

# Que 7 - Display all the films whose rental duration is greater than 5 .

#Ans. 
select*from film
where rental_duration > 5;
#SELECT *: Retrieves all columns from the rental table.
#FROM rental: Specifies the table from which to fetch the data.
# > opertor which drag the data of the rental i d greater than 5.alter

# Que 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.

#Ans . 

select *from film
where replacement_cost < 15 and replacement_cost > 20;

#There is no single film for this particular queries 

# Que 9 - Display the count of unique first names of actors.

#Ans 

select* from actor;
select count(distinct (first_name)) as Unique_first_name from actor;

#Count disctinct is unique way of idnetify the each letter in fist name as becaause it is not allowed the duplicate letter

#Que 10 .Display the first 10 records from the customer table .

#Ans. 

select*from customer
limit 10;

## Here is the limit which help us to display the data of the user requirment.

#Que 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.

#Ans . 

select*from customer;
select*from customer
where first_name like('B%')
limit 3;

#Here is like function which help us to display the name 

#Que 12.-Display the names of the first 5 movies which are rated as ‘G’.

#Ans 
select*from film;
select*from film 
where rating = 'G'
order by title
limit 5;

#Here is the answer of the Queriy

#Que 13-Find all customers whose first name starts with "a".?

#Ans 
select * from customer;
select*from customer 
where first_name like ('a%');

#Here is the name of the all cm whose name start with "A".

#Que 14. Display the list of first 4 cities which start and end with ‘a’ .

#Ans. 

select*from city;

select*from city
where city like ('A%') and city like ('%A')
order by city
limit 4;
#Here is the answer for this queires

#Que 16- Find all customers whose first name have "NI" in any position.

#Ans 

select * from customer;
select* from customer
where first_name like ("%%NI%%")
order by first_name;
#Here is the all the name ahving NI in there in name at any positon

#Que 17- Find all customers whose first name have "r" in the second position .

#Ans 
select* from  customer;
select* from customer 
where first_name like ('_r%%');

#Here is the name of the coustmer having name in the r in second place.

#Que 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

#Ans .

select*from customer ;
select*from customer
where first_name like ('a%%') and length(first_name) >= 5;

#Here is the name of the 

#Que 19- Find all customers whose first name starts with "a" and ends with "o".

#Ans. 

select*from customer;
select*from customer 
where first_name like ('a%') and first_name like ('%o')
order by first_name;

#Here is the name of the all the cm whos name start with a And end with o.

#Que 20 - Get the films with pg and pg-13 rating using IN operator.?

#Ans. 

select* from film;
select *from film 
where rating in ('pg-13','pg')
order by title;

#Here is the rating with the given parameter.alter

# Que 21 - Get the films with length between 50 to 100 using between operator.

#Ans. 

select*from film;
select*from film
where length between 50 and 100;

#Here is the name of the movies where length between 50 and 100.

#Que 22 - Get the top 50 actors using limit operator.

#Ans. 

select*from actor;
select*from actor
limit 50;
#Here is the top 50 actor of the actor coloumn.

#Que 23 - Get the distinct film ids from inventory table.

#Ans. 

select*from inventory;
select count(distinct(film_id)) from inventory;

#Here is  the disctnict film id for the inventory coloumns.

use sakila;
drop database sakila;

###Basic Aggregate Functions:

#Question 1:
#Retrieve the total number of rentals made in the Sakila database.
#Hint: Use the COUNT() function.

#Ans. 

use sakila;
select count(rental_id) from rental;

#Here is the total retntal made in sakila data base

#Question 2:
#Find the average rental duration (in days) of movies rented from the Sakila database.
#Hint: Utilize the AVG() function.

#Ans. 

select*from film;

select avg(rental_duration) as Avg_of_rental_duration from film;

#Averge of the rental duration.

#Que 3. Question 3:

#Display the first name and last name of customers in uppercase.
#Hint: Use the UPPER () function

#Ans . 
select*from customer;

select  upper(first_name), upper(last_name)  from customer;

#Here is the uupper and lower case of the first and last name 

#Question 4:
#Extract the month from the rental date and display it alongside the rental ID.
#Hint: Employ the MONTH() function.

#Ans. 

select*from rental;

select rental_id,month(rental_date) as month_of_rental from rental;

#HEre is the rental month of the col.

#Question 5:
#Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
#Hint: Use COUNT () in conjunction with GROUP BY.

#Ans. 

select * from rental;
select customer_id ,count(*) as count_retntal
from rental
group by customer_id;

#Question 6:

#Find the total revenue generated by each store.

#Hint: Combine SUM() and GROUP BY.

#Ans .

#Question 7:
#Determine the total number of rentals for each category of movies?

#Ans. 

select * from rental;
select  * from film;
select * from film_category;
select*from inventory;


#Que 8. Find the average rental rate of movies in each language.

#Ans..

use mavenmovies;
select * from film;
SELECT * FROM language;

select avg(rental_rate) as avg_rental_rate , name as Lan_name from film 
join  language on film.language_id = language.language_id 
group by name
order  by avg_rental_rate desc;

#Que 1. Display the title of the movie, customer s first name, and last name who rented it.
#Ans . 

select * from film;
select * from customer;
select *  from  inventory;
select * from rental;

select title, first_name,last_name from rental  
join inventory on inventory.inventory_id = rental.inventory_id 
join film on film.film_id = inventory.film_id
join customer on customer.customer_id = rental.customer_id;

#Here is the first and last name of the person.

# Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

#Ans. 

select * from film ;
select * from actor;
select*from film_actor;
select  first_name , last_name from actor
join film_actor on  film_actor.actor_id = actor.actor_id
join film on film.film_id = film_actor.film_id
where title = 'Gone with the Wind';

#Here as you can see that there is no single name in the data with this name 

# Question 11:Retrieve the customer names along with the total amount they've spent on rentals.

#Ans. 

select *from customer;
select * from rental;
select * from payment;

select first_name,sum(amount) from customer 
join payment on payment.customer_id = customer.customer_id
group by customer.first_name , customer.last_name;

#Question 12 list the titles of movies rented by each customer in a particular city (e.g., 'London').

#Ans. 

use mavenmovies;
select * from film;
select * from rental;
select * from city;
select *  from customer;	
select * from address;
select * from inventory;

select first_name , last_name ,city,title from customer
join address on address.address_id = customer.address_id
join city on  city.city_id = address.city_id
join rental on rental.customer_id = customer.customer_id
join inventory on inventory.inventory_id =  rental.inventory_id
join film on film.film_id = inventory.film_id;

select first_name , last_name ,city,title from customer
join rental on rental.customer_id = customer.customer_id
join address on address.address_id = customer.address_id
join city on  city.city_id = address.city_id
join inventory on inventory.inventory_id =  rental.inventory_id
join film on film.film_id = inventory.film_id;

#Question 13: Display the top 5 rented movies along with the number of times they've been rented.

#Ans. 

select * from rental;
select * from film;
select * from inventory;

select title, count(rental.rental_id) from film 
join inventory on inventory.film_id = film.film_id
join rental on rental.inventory_id = inventory.inventory_id
group by title
limit 5;

#Que Question 14:

#Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

#Ans.

use mavenmovies;
select * from rental;
select * from inventory;
select * from customer;

select first_name, last_name,customer_id
from customer join  rental on rental.customer_id = customer.customer_id
join inventory on inventory.inventory_id = rental.inventory_id
group by last_name,first_name,customer.customer_id
having count(distinct inventory.store_id)= 2;

#Windows Function:

#Que 1. Rank the customers based on the total amount they've spent on rentals.

#Ans . 

select *  from payment;

select rank () over (partition by customer_id  order by amount desc) as rank_amount ,customer_id,amount from payment;

#Que 2. Calculate the cumulative revenue generated by each film over time.

#Ans 
select * from payment;
select * from film;

SELECT 
    f.title AS film_title,
    p.payment_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY f.title, p.payment_date;

#Que 3. . Determine the average rental duration for each film, considering films with similar lengths.

SELECT 
    f.title AS film_title,
    f.length AS film_length,
    AVG(r.return_date - r.rental_date) AS avg_rental_duration
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title, f.length
ORDER BY f.length, f.title;

#Que 4. Identify the top 3 films in each category based on their rental counts.

#Ans .

SELECT 
    category_name,
    film_title,
    rental_count
FROM (
    SELECT 
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.category_id, c.name, f.film_id, f.title
) ranked
WHERE rank_1 <= 3
ORDER BY category_name, rank_1;

#Que 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals

#across all customers.

#Ans 

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS total_rentals,
    (COUNT(r.rental_id) - (SELECT AVG(customer_rental_count)
                           FROM (
                               SELECT COUNT(r2.rental_id) AS customer_rental_count
                               FROM rental r2
                               GROUP BY r2.customer_id
                           ) avg_rentals)) AS rental_difference
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_difference DESC;

#Que 6. Find the monthly revenue trend for the entire rental store over time.

#Ans . 

SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY year, month;

#Que . 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

#Ans .

WITH CustomerSpending AS (
SELECT 
c.customer_id,CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
),
SpendingThreshold AS (
SELECT 
PERCENTILE_CONT(0.8) WITHIN  group(ORDER BY total_spent) AS threshold
FROM CustomerSpending)
SELECT 
cs.customer_id,
cs.customer_name,
cs.total_spent
FROM CustomerSpending cs
JOIN SpendingThreshold st ON cs.total_spent >= st.threshold
ORDER BY cs.total_spent DESC;

#Que 8  Calculate the running total of rentals per category, ordered by rental count.

#Ans. 

WITH rental_counts AS (
    SELECT 
        c.name AS category_name, 
        COUNT(r.rental_id) AS rental_count
    FROM 
        rental r
    JOIN 
        inventory i ON r.inventory_id = i.inventory_id
    JOIN 
        film f ON i.film_id = f.film_id
    JOIN 
        film_category fc ON f.film_id = fc.film_id
    JOIN 
        category c ON fc.category_id = c.category_id
    GROUP BY 
        c.name
)
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM 
    rental_counts
ORDER BY 
    rental_count DESC;
    
#Que 9. Find the films that have been rented less than the average rental count for their respective categories.

#Ans.
WITH rental_counts AS (
    -- Calculate rental count per film and category
    SELECT 
        f.film_id, 
        f.title,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM 
        rental r
    JOIN 
        inventory i ON r.inventory_id = i.inventory_id
    JOIN 
        film f ON i.film_id = f.film_id
    JOIN 
        film_category fc ON f.film_id = fc.film_id
    JOIN 
        category c ON fc.category_id = c.category_id
    GROUP BY 
        f.film_id, f.title, c.name
),
category_avg_rentals AS (
    -- Calculate the average rental count per category
    SELECT 
        category_name,
        AVG(rental_count) AS avg_rental_count
    FROM 
        rental_counts
    GROUP BY 
        category_name
)
SELECT 
    rc.film_id, 
    rc.title, 
    rc.category_name, 
    rc.rental_count, 
    car.avg_rental_count
FROM 
    rental_counts rc
JOIN 
    category_avg_rentals car ON rc.category_name = car.category_name
WHERE 
    rc.rental_count < car.avg_rental_count
ORDER BY 
    rc.category_name, rc.rental_count;
    
#Que 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

#Ans .

WITH monthly_revenue AS (
    -- #Calculate total revenue per month
    SELECT
        TO_CHAR(p.payment_date, 'YYYY-MM') AS month,
        SUM(p.amount) AS total_revenue
    FROM
        payment p
    GROUP BY
        TO_CHAR(p.payment_date, 'YYYY-MM')
)
SELECT
    month,
    total_revenue
FROM
    monthly_revenue
ORDER BY
    total_revenue DESC 
FETCH FIRST 5 ROWS ONLY;

#Normalisation & CTE

#Que 1. First Normal Form (1NF):
#a. Identify a table in the Sakila database that violates 1NF. Explain how you
#would normalize it to achieve 1NF.

#Ans. 


	








	












	
	










 






 













    




 
       

       


       












       
	



















