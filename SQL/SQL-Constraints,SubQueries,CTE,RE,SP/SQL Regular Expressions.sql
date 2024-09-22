-- Regular Expression:
Select * from superstore;
-- Find out the city which starts from San
Select Distinct City From Superstore where
City regexp '^san'; -- ^ starts with san

Select Distinct City From Superstore 
where City regexp 'son$'; -- $ ends with son

Select Distinct OrderID From Superstore
 where OrderID regexp 'CA-2016';

-- Can you select a product name that contains either Table or Desk
Select Region, Category, Segment, ProductName From Superstore
Where ProductName regexp 'Desk|Table';

Select Region, Category, Segment,ProductID,
regexp_replace(ProductID,'[0-9]','*') as CharFromProduct
from superstore;

Select Region, Category, Segment,ProductID,
regexp_replace(ProductID,'[0-9]','') as CharFromProduct
from superstore;

Select Region, Category, Segment,ProductID,
replace(regexp_replace(ProductID,'[0-9]','*'),'-','') as CharFromProduct
from superstore;

Select Region, Category, Segment,ProductID,
regexp_replace(ProductID,'[^0-9]','') as NumbersFromProduct
from superstore;







