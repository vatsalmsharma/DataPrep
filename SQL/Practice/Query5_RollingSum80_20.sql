-- Name : Complex SQL 5 | Pareto Principle (80/20 Rule) Implementation in SQL
-- URL : https://www.youtube.com/watch?v=oGgE180oaTs&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=6

/*
-- Setup : 
create table orders(
Row_ID	int not null,
  Order_ID	varchar(50), 
  Product_ID	varchar(50),
  Category varchar(50),	
  Sub_Category varchar(50),	
  Sales	decimal,
  order_date date,
  primary key (Row_ID)
);

 insert into orders values
(1,'CA-2020-152156','FUR-BO-10001798','Furniture','Bookcases',261.96, to_date('20230101', 'YYYYMMDD')),
(2,'CA-2020-152156','FUR-CH-10000454','Furniture','Chairs',731.94, to_date('20230201', 'YYYYMMDD')),
(3,'CA-2020-138688','OFF-LA-10000240','Office Supplies','Labels',14.62, to_date('20230301', 'YYYYMMDD')),
(4,'US-2019-108966','FUR-TA-10000577','Furniture','Tables',957.5775, to_date('20230401', 'YYYYMMDD')),
(5,'US-2019-108966','OFF-ST-10000760','Office Supplies','Storage',22.368, to_date('20230501', 'YYYYMMDD')),
(6,'CA-2018-115812','FUR-FU-10001487','Furniture','Furnishings',48.86, to_date('20230601', 'YYYYMMDD')),
(7,'CA-2018-115812','OFF-AR-10002833','Office Supplies','Art',7.28, to_date('20230701', 'YYYYMMDD')),
(8,'CA-2018-115812','TEC-PH-10002275','Technology','Phones',907.152, to_date('20230801', 'YYYYMMDD')),
(9,'CA-2018-115812','OFF-BI-10003910','Office Supplies','Binders',18.504, to_date('20230901', 'YYYYMMDD')),
(10,'CA-2018-115812','OFF-AP-10002892','Office Supplies','Appliances',114.9, to_date('20231001', 'YYYYMMDD')),
(11,'CA-2018-115812','FUR-TA-10001539','Furniture','Tables',1706.184, to_date('20231101', 'YYYYMMDD')),
(12,'CA-2018-115812','TEC-PH-10002033','Technology','Phones',911.424, to_date('20231201', 'YYYYMMDD'));

-- This is mock data. 
-- Actual data can be pulled from the 'Superstore_orders.xls' file from Dataset

*/
-- Solution :
with product_wise_sales as 
      (select 
      product_id
      ,sum(Sales) as mySales
      from orders 
      group by product_id)
, calc_sales as 
    (select product_id, mySales
    ,sum(mySales) over (order by mySales desc rows between unbounded preceding and 0 preceding) as rolling_sum
    ,0.8 * sum(mySales) over() as Sales80pc
    from product_wise_sales)
select * from calc_sales
 where rolling_sum <= Sales80pc;


-- Extra details
-- Rolling sum/avg/min/max
-- https://www.youtube.com/watch?v=YfDyHvH6sdc
select 
extract(year from order_date) as year
, extract(month from order_date) as month
,Sales
 ,sum(Sales) over (order by extract(year from order_date), extract(month from order_date) rows between unbounded preceding and 0 preceding) as rolling_sum
,sum(Sales) over()
,sum(Sales) over (order by extract(year from order_date), extract(month from order_date) rows between unbounded preceding and UNBOUNDED FOLLOWING) as same_sum
,sum(Sales) over (order by extract(year from order_date), extract(month from order_date) rows between 2 preceding and 0 preceding) as rolling_3_month_sum
,min(Sales) over (order by extract(year from order_date), extract(month from order_date) rows between 2 preceding and 0 preceding) as rolling_3_month_min
,avg(Sales) over (order by extract(year from order_date), extract(month from order_date) rows between 2 preceding and 0 preceding) as rolling_3_month_avg
from orders
group by extract(year from order_date) 
, extract(month from order_date)
,Sales
order by extract(year from order_date), extract(month from order_date);