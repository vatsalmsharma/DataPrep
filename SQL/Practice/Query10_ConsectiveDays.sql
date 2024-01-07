-- Name : An Awesome Tricky SQL Logic | Complex SQL 10
-- URL : https://www.youtube.com/watch?v=WrToXXN7Jb4&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=10
/*
-- Setup :
create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values (date '2019-01-01','success'),(date '2019-01-02','success'),(date '2019-01-03','success'),(date '2019-01-04','fail')
,(date '2019-01-05','fail'),(date '2019-01-06','success')

-- Expected Output
state	| start_date	| end_date
success	| 2019-01-01	| 2019-01-03
fail	| 2019-01-04	| 2019-01-05
success	| 2019-01-06	| 2019-01-06

*/

-- Solution :
with scope as (
select 
date_value, state
, (row_number() over(partition by state order by date_value asc)) as myRowNo
, date_value + (-1 * (row_number() over(partition by state order by date_value asc))) :: integer as group_date
from tasks 
)
select state, min(date_value) as Start_Date, max(date_value) as End_Date
from scope
group by state, group_date
order by 2;