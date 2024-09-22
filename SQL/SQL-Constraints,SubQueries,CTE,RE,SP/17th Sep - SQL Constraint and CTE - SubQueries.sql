/* Joins:

create a table with single colun (Numbers) and set the value 1 and null (multiple time)
and the same table create once again with different name and set the value 1 and null
couple of time and then try to join them

1.) one table has 5 values like - 1,1,1,1,1 wit TestColumn
2.) 2nd table has MyNumber column with 3 times : 1,1,1 
3.) Can you try to join with All type of joins and analyze the output.
*/

Select * from superstore;
-- How to rename te column and its data type
Alter Table Superstore Change column OrderDate Order_Date Text;
Alter Table Superstore Change column Order_Date OrderDate Date;

-- If your table is already created then how we can apply the primary key
Create table upGrad_Testing
(
	StudentID varchar(10), Student_Name varchar(50)
);

Select * from upGrad_Testing;

Alter Table upGrad_Testing Add Primary key (StudentID);

Alter Table upGrad_Testing Drop Primary Key;

Alter Table YourTableName Add Foreign key (ColumnName) 
references AnotherTableName(ColumnName);

/* Unique Constraint:
Unique will ensures that all the value should be unique in the column 
(All values should be different). You can add multiple unique key column in 
a single table. A Unique key's column can have only single null value (In MicroSoft SQL Server),
Where as We can insert multiple Null Value in Unique Key column in MY SQL. 
*/
Create Table UpGrad_Testing_1
(
	ID int
);

-- Adding a unique key when you have already created a table
Alter Table upGrad_Testing_1 add constraint UK_Testing unique (ID);

Insert Into upGrad_Testing_1(ID)
values (101);

Insert Into upGrad_Testing_1(ID)
values (Null);

Select * from upgrad_testing_1;

Create Table MyTable_UK
(
	Id int, FName varchar(10),
    Mobile varchar(10),
    Grade varchar(10),
    constraint UK_MyTable_Key Unique(Fname, Mobile)
);

Create Table Employee_Tbl
(
	EmpID int not null,
    FirstName Varchar(20) not null,
    LastName varchar(20) null,
    Age int Check (Age >= 18 and Age < 59)
);

Insert into Employee_Tbl(EmpID,FirstName,LastName,Age)
values (1,'Abhishek',null,50);

-- Adding constraint on existing table
Alter TableName YourTableName Add check (condition);

Alter Table YourTableName Add Constraint Check_For_City_Country
Check (City = 'Delhi' and Country = 'India');

Alter Table YourTableName Drop Check Check_For_City_Country;







