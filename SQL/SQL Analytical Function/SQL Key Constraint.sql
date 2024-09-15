/* SQL Key Constraint:
SQL Constraint: Help enforct data integrity and establish relationhsip between tables.
There are several types of key constraint, each serving a specific purpose.
SQL Key Constraint: null, not null, default, Primary, Foreign, Check, Unique etc

1.) Primary Key Constraint:

A PK is speical column in a table that uniquely identifiers each value in the column.
It ensures that the data in the table is unique and not null. 
A single table can have only 1 primary key column. 
PK : Not contains duplicates and null and 1 table can have 1 PK column.

*/

Create DataBase upGrad_Constraint;
Create Table Sales_Table
(
	SalesID varchar(10) Primary key,
	SalesDate Date,
    CustomerName Varchar(50) Not null,
    Amount Decimal(10,2)
);

-- ERD :  Entitiy Relationship Diagram




