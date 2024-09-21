/* SQL Constraint and Joins 
SQL Constraints are some rules by which we can enforced on a
table's column to ensure the correct data or accuracy.
SQL Constraint will help to insert the correct data in that
respective column. 
SQL Constraint -> Ensure the data integrity, accuracy and reliability
of data in database.

1. Primary Key:
A PK is a special column in a table that uniquely identifiers each record
in a table. It ensures that the data in the table is unique and not null.
A single table can have only 1 primary key column.

Purpose: Uniquely identifiers each row or record in a table.
-> Value must be unique accross the columns
-> Cannot contain NULL Values
-> A table can have only single primary key on a table.

----------------------------------------------------------
Foreign Key: FK is a column in a table that refers to the primary key column
of another table.
Using FK, We can establish linking or connection between two or more tables,
Using FK a table maintain data integrity. 
A FK column can have null or duplicate values unlike PK.

Note: A column with a FK must match with primary key in another table or be null.
*/

use upgrad_constraint;

Create table SalesTable
(
	SalesID varchar(10) primary key,
    SaleDate Date,
    Customer_Name varchar(50),
    Amount decimal(10,2)
);

Create Table Order_Table
(
	OrderID varchar(10) Primary key,
    Sales_ID varchar(10),
    Product_name varchar(50),
	Quantity int,
    Price decimal(10,2),
    Foreign key (Sales_ID) references SalesTable(SalesID)
);

Insert into salestable(SalesID, SaleDate, Customer_Name, Amount)
Values
	('S101','2024-05-09','Abhishek',5000.00),
	('S102','2024-05-10','Ashok',1300.00),
	('S103','2024-05-11','Eric',400.00),
	('S104','2024-05-12','Corey',6000.00),
	('S105','2024-05-15','Rashmi',9000.00);

Select * from SalesTable;

Insert into order_table(OrderID, Sales_ID, Product_Name, Quantity, Price)
Values ('O121A-24-1',Null,'Hard Disk',5,1000),
('O121B-24-1','S103','Mouse',2,200);

Select * from Order_Table;

Insert into order_table(OrderID, Sales_ID, Product_Name, Quantity, Price)
Values ('O121C-24-1','S111','KeyBoard',5,1500);
-- ---------------------------------------------------------
/* SQL Joins
Different Types of Join:
-- Inner Join
-- Left Join
-- Right Join
-- Full Join
-- Cross Join

1.) Inner Join:
Inner Join will give you only the common records from the table.
General Formua of Joins:

Select ColumnList from TableName1
Inner Join TableName2
on TableName1.columnName = TableName2.ColumnName
inner Join TableName3
on TableName2.ColumnName = TableName3.ColumName

*/
-- ---------------------- HR Schema
Create table Jobs
(
	job_id int primary key,
    job_title varchar(20),
    min_salary int,
    max_salary int
);
create table regions
(
	region_id varchar(20) primary key,
    region_name varchar(30)
);

create table countries
(
	country_id varchar(20) primary key,
    country_name varchar(30),
    region_id varchar(20),
    foreign key (region_id) references regions(region_id)
);
create table locations
(
	location_id varchar(20) primary key,
    street_address varchar(50) default null,
    postal_code int,
    city varchar(20),
    state_province varchar(30),
    country_id varchar(20) not null,
    foreign key (country_id) references countries(country_id)
);

create table departments
(
	department_id varchar(20) primary key,
    department_name varchar(20),
    manger_id varchar(10),
    location_id varchar(20),
    foreign key (location_id) references locations(location_id)
);

	create table employees
	(
		Employee_ID varchar(10) primary key,
		first_name varchar(20),
		last_name varchar(20),
		email varchar(40),
		phone_number int,
		hire_date date,
		job_id int,
		salary int,
		manager_id varchar(10),
		department_id varchar(20),
		foreign key (job_id) references jobs(job_id),
		foreign key (manager_id) references employees(Employee_ID),
		foreign key (department_id) references Departments(department_id)
	);

create table dependents
(
	dependent_id varchar(20),
    first_name varchar(20),
    last_name varchar(20),
    relationship varchar(20),
    employee_id varchar(10) primary key,
    foreign key (employee_id) references employees(employee_id)
);

use hr_database;

Select * from employees;
select * from departments;

Select Employee_id, First_Name, salary,hire_date,
department_name, location_id
from employees as E
Inner Join departments as D
on E.department_id = D.department_id;

Select Employee_id, First_Name, salary,hire_date,
department_name, D.location_id
from employees as E
Inner Join departments as D
on E.department_id = D.department_id
Inner Join locations as loc
on D.location_id = loc.location_id;

-- Error Code: 1052. Column 'location_id' in field list is ambiguous

Select * from employees;

Select ManagerName, count(*) as EmpCount from 
(
Select M.First_Name as EmpName,E.First_Name as ManagerName,  M.manager_id as ManagerID
from Employees as E
Inner Join employees as M
On E.Employee_id = M.manager_id
Order by ManagerName
) as ManagerTable
group by ManagerName;

Select * from Orders;
Select * from returned;
-- renaming the table name
Rename table returns to returned;

Select count(*) from orders; -- 5000
select count(*) from returned; -- 2000
-- Inner Join (Common Record) => 89
-- can you map the state in the orders table

Select O.`Order ID` as OrderID, O.Customer, State, 
O.City
from orders as O
Inner Join returned
on O.`Order ID` = returned.`Order ID`;

select count(*) from
(
Select O.`Order ID` as OrderID, O.Customer, State, 
O.City
from orders as O
Inner Join returned
on O.`Order ID` = returned.`Order ID`
) as T;

/* Left Join:
Using the left join we can find out all the records from the left table
including matching record from the right table
*/

Select * from Orders
left Join returned
on orders.`order id` = returned.`order id`;

Select * from Orders
left Join returned
on orders.`order id` = returned.`order id`
Where returned.City is not null;


-- Right Join
-- Right Join : All the records from right table including matching recording
Select * from Orders
right Join returned
on orders.`order id` = returned.`order id`;

Select * from Orders
right Join returned
on orders.`order id` = returned.`order id`
where Quantity is not null;

-- Note: My SQL does not support full join or full outer join

Select * from Orders
left Join returned
on orders.`order id` = returned.`order id`
union
Select * from Orders
right Join returned
on orders.`order id` = returned.`order id`;

Select * from orders limit 5;




























