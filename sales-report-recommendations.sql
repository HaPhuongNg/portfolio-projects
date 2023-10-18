----------2015
-- Temp table for return 2015 by product 
begin
create table #temp_re15 (
ProductKey nvarchar(50),
ProductReturn int) 
insert into #temp_re15
select productkey, sum(returnquantity)
from Porfolio..AdventureWorks_Returns 
where 
ReturnDate >= '1/18/2015' and ReturnDate <=  '12/31/2015'
group by productkey
end;
-- Temp table for sales 2015 by product 
begin
create table #temp_sa15 (
ProductKey nvarchar(50),
ProductSales int) 
insert into #temp_sa15
select productkey, sum(orderquantity) as productsales15
from Porfolio..AdventureWorks_Sales_2015 
group by productkey 
end;
-- Margin revenue 2015
begin
with CTE_ProductSold15 as
(
select #temp_sa15.ProductKey as ProductKey, Pro.ProductSubcategoryKey as ProductSubcategoryKey, Pro.ProductColor as Color, #temp_sa15.ProductSales - #temp_re15.ProductReturn as ProductSold15, convert(decimal(10, 4),Pro.ProductCost) as Cost, convert(decimal(10, 4),Pro.ProductPrice) as Price
from #temp_sa15
inner join #temp_re15 on #temp_sa15.productkey=#temp_re15.productkey
inner join Porfolio..AdventureWorks_Products Pro on #temp_sa15.productkey=Pro.productkey 
)
select ProductKey, CTE_ProductSold15.ProductSubcategoryKey, Sub.SubcategoryName, Price, Color, Sub.SubcategoryName, ProductSold15, convert(decimal(10,2),(Price-Cost)*ProductSold15) as MarginRevenue 
from CTE_ProductSold15
left join Porfolio..AdventureWorks_Product_Subcategories Sub on CTE_ProductSold15.ProductSubcategoryKey = Sub.ProductSubcategoryKey
order by MarginRevenue desc
end;
----------2016
-- Temp table for return 2016 by product 
begin
create table #temp_re16 (
ProductKey nvarchar(50),
ProductReturn int) 
insert into #temp_re16
select productkey, sum(returnquantity)
from Porfolio..AdventureWorks_Returns 
where 
ReturnDate >= '1/1/2016' and ReturnDate <=  '12/31/2016'
group by productkey
end;
-- Temp table for sales 2016 by product  
begin
create table #temp_sa16 (
ProductKey nvarchar(50),
ProductSales int) 
insert into #temp_sa16
select productkey, sum(orderquantity) as productsales16
from Porfolio..AdventureWorks_Sales_2016 
group by productkey 
end;
-- Margin revenue 2016
begin
with CTE_ProductSold16 as
(
select #temp_sa16.ProductKey as ProductKey, Pro.ProductColor as Color, Pro.ProductSubcategoryKey as ProductSubcategoryKey, #temp_sa16.ProductSales - #temp_re16.ProductReturn as ProductSold16, convert(decimal(10, 4),Pro.ProductCost) as Cost, convert(decimal(10, 4),Pro.ProductPrice) as Price
from #temp_sa16
inner join #temp_re16 on #temp_sa16.productkey=#temp_re16.productkey
inner join Porfolio..AdventureWorks_Products Pro on #temp_sa16.productkey=Pro.productkey 
)
select ProductKey, CTE_ProductSold16.ProductSubcategoryKey, Sub.SubcategoryName, Price, Color, ProductSold16, convert(decimal(10,2),(Price-Cost)*ProductSold16) as MarginRevenue,Count(SubCategoryName) OVER (Partition by SubCategoryName) 
from CTE_ProductSold16
left join Porfolio..AdventureWorks_Product_Subcategories Sub on CTE_ProductSold16.ProductSubcategoryKey = Sub.ProductSubcategoryKey
order by MarginRevenue desc
end;
----------2017
-- Temp table for return 2017 by product 
begin
create table #temp_re17 (
ProductKey nvarchar(50),
ProductReturn int) 
insert into #temp_re17
select productkey, sum(returnquantity)
from Porfolio..AdventureWorks_Returns 
where 
ReturnDate >= '1/1/2017' and ReturnDate <=  '12/31/2017'
group by productkey
end;
-- Temp table for sales 2017 by product
begin
create table #temp_sa17 (
ProductKey nvarchar(50),
ProductSales int) 
insert into #temp_sa17
select productkey, sum(orderquantity) as productsales17
from Porfolio..AdventureWorks_Sales_2017 
group by productkey 
end;
-- Margin revenue 2017
with CTE_ProductSold17 as
(
select #temp_sa17.ProductKey as ProductKey, Pro.ProductSubcategoryKey as ProductSubcategoryKey, Pro.ProductColor as Color, #temp_sa17.ProductSales - #temp_re17.ProductReturn as ProductSold17, convert(decimal(10, 4),Pro.ProductCost) as Cost, convert(decimal(10, 4),Pro.ProductPrice) as Price
from #temp_sa17
inner join #temp_re17 on #temp_sa17.productkey=#temp_re17.productkey
inner join Porfolio..AdventureWorks_Products Pro on #temp_sa17.productkey=Pro.productkey 
)
select ProductKey, CTE_ProductSold17.ProductSubcategoryKey, Sub.SubcategoryName, Price, Color, ProductSold17, convert(decimal(10,2),(Price-Cost)*ProductSold17) as MarginRevenue,Count(SubCategoryName) OVER (Partition by SubCategoryName) 
from CTE_ProductSold17
left join Porfolio..AdventureWorks_Product_Subcategories Sub on CTE_ProductSold17.ProductSubcategoryKey = Sub.ProductSubcategoryKey
order by MarginRevenue desc



 
















