-- Name : Leetcode Hard Problem 3 | Market Analysis 2 | Complex SQL 9
-- URL : https://www.youtube.com/watch?v=1ias-sP_XAY&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=9
/*
-- Setup :
create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,date '2019-01-01','Lenovo'),(2, date '2019-02-09','Samsung'),(3,date '2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,date '2019-08-01',4,1,2),(2,date '2019-08-02',2,1,3),(3,date '2019-08-03',3,2,3),(4,date '2019-08-04',1,4,2)
 ,(5,date '2019-08-04',1,3,4),(6,date '2019-08-05',2,2,4);
 */

 -- Solution: 
 with orderScope as 
	(select seller_id, item_id
	, dense_rank() over(partition by seller_id order by order_date asc) as myRank
	from orders)
, sellerItem as
	(select o.seller_id, o.item_id, i.item_brand
	from orderScope o
	inner join items i
	on o.item_id = i.item_id
	where o.myRank = 2)

select u.user_id
, case when s.item_brand = u.favorite_brand then 'Yes'
	else 'No'
  end as Second_Item_Fav_Brand
from users u 
left join sellerItem s
on u.user_id = s.seller_id;
