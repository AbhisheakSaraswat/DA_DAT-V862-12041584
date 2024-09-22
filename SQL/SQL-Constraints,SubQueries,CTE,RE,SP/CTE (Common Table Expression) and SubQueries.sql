/* Common Table Expression: CTE
CTEs are defined by 'with' clause,
They temporarily store results that are available only for 
the duration of the query execution. It is important to note that
We can not apply any indexes or constraint over the CTE

-- Syntax
With YourCteName
as
(
	YourQuery Here

);
*/
With RankAnalysis As
(
	Select FirstName, LastName, Occupation, yearlyIncome,
	Rank() Over (partition by Occupation Order by yearlyIncome) as NRank
	from EmployeeDB
)
Select * from RankAnalysis Where NRank = 2;

With RegionWiseSales AS
(
	Select Region, Segment, Year(OrderDate) as SalesYear,
	round(sum(Sales),2) as TotalSales
	From SuperStore
	Where year(OrderDate) = 2016
	Group by Region, Segment,Salesyear
) 
Select * From RegionWiseSales 
Where Region in ('South','East') and TotalSales > 50000;

-- Can you find out 1st highest YearlyIncome from each occupation suing CTE
with HighestIncome As
(
	Select *, dense_rank() over (partition by Occupation order by YearlyIncome desc) as Drank
	from EmployeeDB
)
Select FirstName, Occupation, Grade, YearlyIncome, Sales, DRank from HighestIncome
where DRank = 1;

/* Temporary Table
A Temporary table is only accessed when your sql connection is
created, A Temp table is automatically removed from the system
when the session terminated in my sql.
*/
Create Temporary Table MyEmpTable
(
	EmpID int auto_increment primary key,
    EmpName varchar(50),
    Mobile Int, unique(Mobile)
);

Insert into MyEmpTable (EmpName, Mobile) 
Values ('Abhishek',9898);

Select * from MyEmpTable;

/* View In MySQL 

A View is virtual table that is based on the result
of your sql query. Your view is just a mirror of your 
data and it does not story data physically.

Simplifying Queries:

Whenever you are applying Joins, subqueries and 
SQL Aggregations then you can only view the data
(they can not change anything or no change in your
main table or underlying table)

Enhance Security: View can be restrict to the specific
column or row of a table. They can not access main data
directly.

Reusability: User can store the complex query result into a view
for furture reference.

*/

Select * from EmployeeDB;

Create View EmployeeView
As
Select FirstName, LastName, Occupation, Grade, Sales
from EmployeeDb Where Sales > 3000;

Select * from EmployeeView;

-- I want to update Sales to 5000 where Grade is C
Update EmployeeView Set Sales = 5000 Where Grade = 'C';

Select * from EmployeeDB  Where FirstName = 'Christopher';

Update EmployeeView Set Sales = 5555 Where FirstName = 'Christopher';

/* A normal state (no join, no subquery, no sql agg) 
is written on the view above and I have
updated the sales of an employee, those changes refelected successfully
in your main table or underlying table.
*/

Create view View_EmployeeDBSummary AS
(
	Select Education, Occupation, Grade, Sum(YearlyIncome) as TotalIncome,
    Sum(Sales) as TotalSales From EmployeeDB
    Group by Education, Occupation, Grade
);

Select * from View_EmployeeDBSummary Where Grade = 'B';

Update View_EmployeeDBSummary set TotalSales = 100 Where Grade = 'B';

Select * from Employees;

use hr_database;

Select * from employees;

Create View View_EmployeeDepartment
As
(
Select Concat(First_Name, ' ', last_Name) as FullName,
Email,Salary,Department_Name from employees
Inner Join Departments
on employees.department_id = Departments.department_id
);

select * from View_EmployeeDepartment;

Update View_EmployeeDepartment set FullName = 'Abhisheak Saraswat'
Where FullName = 'Pat Fay';

Create view NormalView
AS
Select * from Employees 
Where First_Name like 'S%';

Select * from NormalView;
Update NormalView Set First_Name = 'Abhisheak' 
Where Employee_ID = 100;












