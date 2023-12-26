-- Name : Complex SQL 3 | Scenario based Interviews Question for Product companies
-- URL : https://www.youtube.com/watch?v=P6kNMyqKD0A&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb
/*
-- Setup :
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries values 
  ('A','Bangalore','A@gmail.com',1,'CPU'),
  ('A','Bangalore','A1@gmail.com',1,'CPU'),
  ('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
  ('B','Bangalore','B@gmail.com',2,'DESKTOP'),
  ('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
  ('B','Bangalore','B2@gmail.com',1,'MONITOR');

-- Expected output
name	| totalvisit	| mostvisitedfloor	| myresource
A	    | 3	            | 1	                | CPU,DESKTOP
B	    | 3	            | 2	                | DESKTOP,MONITOR
*/

-- Solution :
-- Approach 1
with scope as (
              select A.name, A.floor, A.totalVisits,
              dense_rank() over( partition by A.name order by A.totalvisits desc) as my_rank
              from (
                    select name, floor, count(name) as totalVisits
                    from entries
                    group by name, floor) A
),
myresource as (
select name, string_agg(distinct(resources), ',') as my_resource
  from entries 
  group by name
)

select s.name
 , sum(s.totalVisits)
, (select ss.floor from scope ss where ss.my_rank = 1 and ss.name = s.name) as mostVisitFloor
, m.my_resource
from scope s, myresource m
where s.name = m.name
group by s.name
, (select ss.floor from scope ss where ss.my_rank = 1 and ss.name = s.name)
,m.my_resource;

-- Approach 2
with resourcesVisit 
        as (
            select name, count(1) as totalVisit
               , string_agg(distinct resources, ',') as myResource
            from entries
            group by name
           )
   , mostVisit as (
                   select name, floor, count(1)
                   , dense_rank() over(partition by name order by count(1) desc) as myRank
                    from entries
                   group by name, floor
                   )
select r.name, r.totalVisit, m.floor as mostvisitedfloor, r.myResource
from resourcesVisit r 
inner join mostVisit m
on r.name = m.name
where myRank = 1;