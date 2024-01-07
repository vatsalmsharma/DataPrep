-- Name : Leetcode Hard Problem 4 | User Purchase Platform | Complex SQL 11
-- URL : https://www.youtube.com/watch?v=4MLVfsQEGl0&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=11
/*
-- Setup :
create table spending 
(
 user_id varchar(10),
spend_date date,
platform varchar(10),
amount int
);

insert into spending values
('1',date '2019-07-01','mobile',100),
('1',date '2019-07-01','desktop',100),
('2',date '2019-07-01','mobile',100),
('2',date '2019-07-02','mobile',100),
('3',date '2019-07-01','desktop',100),
('3',date '2019-07-02','desktop',100)
;

-- Expected output
spend_date	| platform	| amount	| total_customer
2019-07-01	| desktop	| 100	    | 1
2019-07-01	| both	    | 200	    | 1
2019-07-02	| mobile	| 100	    | 1
2019-07-02	| desktop	| 100	    | 1
2019-07-02	| both	    | 0	        | 0
*/

-- Solution 
with scope as (
select spend_date, user_id
, max(distinct (platform)) as platform -- Note this is added we get platform value without having it in group-by cluase, also we are filtering on "having count(distinct platform) = 1" it will not impact anything
, sum(amount) as amount
from spending
group by spend_date, user_id
having count(distinct platform) = 1 -- This is to get unique date and user that have purchased only on 1 platform (either mobile of desktop)
union all
-- Following query is to get all dates and users that have purchared on both the platform (mobile and desktop)
select spend_date, user_id, 'both' as platform, sum(amount)
from spending
group by spend_date, user_id
having count(distinct platform) = 2
 union all
-- inserting dummy data as on 2nd date, we do not have any record of spending for both the platforms
 select distinct(spend_date), NULL as user_id, 'both' as platform, 0 as amount 
 from spending
)

select
-- *
 spend_date, platform, sum(amount) as amount, count(distinct (user_id)) as total_customer
from scope
group by spend_date, platform
order by spend_date, platform desc
-- order by 1,2
;