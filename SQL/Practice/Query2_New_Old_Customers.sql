-- Name : Complex SQL 2 | find new and repeat customers 
-- URL : https://www.youtube.com/watch?v=MpAMjtvarrc&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2
/*
-- Setup :
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values
  (1,100,to_date('2022-01-01', 'YYYY-MM-DD'),2000),
  (2,200,to_date('2022-01-01', 'YYYY-MM-DD'),2500),
  (3,300,to_date('2022-01-01', 'YYYY-MM-DD'),2100),
  (4,100,to_date('2022-01-02', 'YYYY-MM-DD'),2000),
  (5,400,to_date('2022-01-02', 'YYYY-MM-DD'),2200),
  (6,500,to_date('2022-01-02', 'YYYY-MM-DD'),2700),
  (7,100,to_date('2022-01-03', 'YYYY-MM-DD'),3000),
  (8,400,to_date('2022-01-03', 'YYYY-MM-DD'),1000),
  (9,600,to_date('2022-01-03', 'YYYY-MM-DD'),3000)
;

-- Expected output
order_date	newcustcount	oldcustcount
2022-01-01	3	            0
2022-01-02	2	            1
2022-01-03	1	            2
*/

-- Solution :
-- Approach 1
with cust_first_order as (
                          select customer_id, min(order_date) as firstOrder
                          from customer_orders
                          group by customer_id
                          )
, scope as (select 
co.order_date
,co.customer_id
,case 
  when co.order_date = cfo.firstOrder and co.customer_id = cfo.customer_id
    then 1
   else 0
 end as new_flag
from customer_orders co
left join cust_first_order cfo
on co.order_date = cfo.firstOrder
and co.customer_id = cfo.customer_id)

select order_date, sum(new_flag) as newCust
, count(order_date) - sum(new_flag) as OldCust
from scope
group by order_date
order by 1;

-- Approach 2
with cust_first_order as (
                          select customer_id, min(order_date) as firstOrder
                          from customer_orders
                          group by customer_id
                          )
select co.order_date
, sum( case when co.order_date = cfo.firstOrder then 1 else 0 end) as newCustCount
, sum( case when co.order_date != cfo.firstOrder then 1 else 0 end) as oldCustCount
from customer_orders co
left join cust_first_order cfo
on co.customer_id = cfo.customer_id
group by co.order_date
order by 1;