/* Stored Procedure
SP is nothing, It is just a group of statement of your
sql queries, You can create SP with the set of sql statements
that can be stored on database server and all the set of statements
executed in a single unit. You can write a complex logic or n number
of queries and stored in the SP.
*/

use Knowledgehut;

call to_get_employeeDB;
call to_get_summary;

Delimiter //
Create Procedure SP_Sales_Summary()
Begin
	Select Distinct Region, round(sum(sales) Over (partition by Region),2) as TotalSales,
    Avg(Sales) Over (partition by Region) as AvgSales,
    Min(Sales) Over (partition by Region) as MinSales,
    Max(Sales) Over (partition by Region) as MaxSales,
    Count(Sales) Over (partition by Region) as Total_Transaction
    From Superstore;
End //
Delimiter ;

Call Sp_Sales_Summary();

Create Procedure Name_karan()
Begin
	Select 'hello';
    Select 'World';
End;
-- corect version
Delimiter //
Create Procedure Name_karan()
Begin
	Select 'hello';
    Select 'World';
End //
Delimiter ;

Call Name_Karan();

-- Can you create a stored procedure using some input
Delimiter //
Create Procedure get_Min_Max_Sales (MinSales Int, MaxSales Int)
Begin
	Select * from Superstore Where Sales Between Minsales and MaxSales order by Sales Desc;
End //

Call get_Min_Max_Sales(1000,1100);

-- How to drop the stored procedure
Drop Procedure If Exists Name_karan;
Drop Procedure If Exists get_Min_Max_Sales;
Drop Procedure If Exists SP_Sales_Summary;
Drop Procedure If Exists to_Get_Summary;
Drop Procedure If Exists to_Get_SummaryofSales;



