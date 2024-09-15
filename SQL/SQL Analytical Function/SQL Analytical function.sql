/* SQL Analytical Function or SQL Ranking Function

Key Analytical Functions in SQL:

1.) Window Function: Row_number, Rank(), sum(), Avg(), count() etc
2.) Ranking Function: Ranking func are subset of a window function
that are used to rank rows based on the specific order within
the partition clause.

General syntax of Analytical Function:

Select ColumnList, Analytical_Function_Name | SQL Aggregate Function_Name
Over (Parition by ColumnName | Order by ColumnName |Rows) as AliasName
from TableName

Note : Over clause is an optional : Parition by ColumnName Order by ColumnName
*/

use knowledgehut;

Select * from superstore;

Select sum(Sales) as TotalSales from superstore;

-- How to get Region wise Total Sales
Select Region, sum(Sales) as ReginWiseSales from Superstore
Group by Region;

-- How to get Region wise Total Sales without using group by 
Select Distinct Region, sum(Sales) Over() as TotalSales From Superstore;

Select Distinct Region, sum(Sales) Over(partition by Region) as TotalSales From Superstore;

Select Distinct Region,
sum(sales) Over (Partition by Region) as TotalSales,
round(avg(sales) Over (Partition by Region),2) as AvgSales,
max(sales) Over (Partition by Region) as MaxSales,
Min(sales) Over (Partition by Region) as MinSales,
Count(*) Over (Partition by Region) as TotalCount
From Superstore;

-- Can you give me Region and Category wise Sales, avg, Count
Select Distinct Region, Category,
Sum(Sales) Over (Partition by Region, Category) as TotalSales,
round(avg(Sales) Over (partition by Region, Category),2) as AvgSales,
count(*) Over (partition by region, category) as totalCount
From superstore;

-- Can you Generate Serial Number Against Each row in the Table?
Select *, row_number() over() as RowNumber from EmployeeDB;

-- Can you generate serial number against Grade
Select FirstName, LastName, Education, Occupation, Grade, Sales,
row_number() over (partition by Grade) as RowNumber
From EmployeeDB;

Select FirstName, LastName, Education, Occupation, Grade, Sales,
row_number() over (partition by Grade Order by Sales) as RowNumber
From EmployeeDB;

-- Hey, Can you give me 2nd Lowest | Highest Sales from Each Grade
Select * From
(
	Select FirstName, LastName, Education, Occupation, Grade, Sales,
	row_number() over (partition by Grade Order by Sales) as RowNumber
	From EmployeeDB
) as T
Where RowNumber = 2;

Select * From
(
	Select FirstName, LastName, Education, Occupation, Grade, Sales,
	row_number() over (partition by Grade Order by Sales DEsc) as RowNumber
	From EmployeeDB
) as T
Where RowNumber = 2;

-- Can you give 2nd highest yearlyincome for each Grade and Occupation using row_number

Select * From
(
	Select FirstName, LastName, Education, Occupation, Grade, YearlyIncome,
	row_number() over (partition by Education,occupation Order by YearlyIncome Desc)
    as RowNumber
	From EmployeeDB
) as T
Where RowNumber = 2;

-- Distinct

Select distinct FirstName, LastName, Education, Occupation, Grade, YearlyIncome
 from Employeedb;
 
-- Can you give alternative rows from Employeedb
Select * from EmployeeDB;

Select * from
(
Select *, row_number() over() as RowNumber from EmployeeDB
) as T
Where RowNumber % 2 = 0;

Select count(Distinct CustomerName) as tc from Superstore; -- it will give you unique records

Select *, row_number() over() as RowNumber from EmployeeDB;

-- dbo. : Data Base Object

-- Rank, DenseRank

Select FirstName,Education,Occupation,Grade,YearlyIncome,
rank() over (Order by yearlyIncome Asc) as RankNumber,
dense_rank() over (Order by yearlyIncome Asc) as DenseRank
From EmployeeDB;


Select FirstName,Education,Occupation,Grade,YearlyIncome,
rank() over () as RankNumber
From EmployeeDB;

Select Region, Category, Sales,
dense_rank() over (partition by region, category order by Sales desc) Drank
From Superstore;

-- Moving Average and Sum of specific rows
Select Category, Sales,
Avg(Sales) Over (Order by Category Rows Between 4 Preceding and Current Row) as MovingAvg,
Avg(Sales) Over (Order by Category Rows Between 2 Preceding and Current Row) as MovingAvg,
Avg(Sales) Over (Order by Category Rows Between 1 Preceding and Current Row) as MovingAvg
From superstore;

Select * From EmployeeDB;

Select Education, Grade, Sales,
avg(Sales) Over (Order by Education Rows between 2 Preceding and Current Row) as MovingAvg_Preceding
from employeedb;

Select Education, Grade, Sales,
avg(Sales) Over (Order by Education Rows between Current Row and 1 Following) as MovingAvg_following,
sum(Sales) Over (Order by Education Rows between Current Row and 1 Following) as Sum_following,
max(Sales) Over (Order by Education Rows between Current Row and 1 Following) as Max_following,
min(Sales) Over (Order by Education Rows between Current Row and 1 Following) as Min_following
from employeedb;

Select * from EmployeeDB;
/*
Lead Function: Lead(Column_Name, Offset, Default) Over (Parition by ColumnName Order by ColumnName)
-- Offset : The number of rows forward to look, by default offset value is 1 if not specified.
-- Default : Null
*/

Select EmpID, FirstName, Sales,
Lead(Sales, 1) Over (order by Sales) as Next_Income
from EmployeeDB;

Select EmpID, FirstName, Sales,
Lead(Sales, 2) Over (order by Sales) as Next_Income
from EmployeeDB;

Select EmpID, FirstName, Sales,
Lag(Sales, 1) Over (order by Sales) as Pre_Income
from EmployeeDB;

Select EmpID, FirstName, Sales,
Lag(Sales, 2) Over (order by Sales) as pre_Income
from EmployeeDB;








