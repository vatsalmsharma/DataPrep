-- Name : Complex SQL 6 | Scenario based on join, group by and having clauses 
-- URL : https://www.youtube.com/watch?v=EjzhMv0E_FE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=7

/*
-- Setup :
create table person(
PersonID	int,
  Name	varchar(20),
  Email	varchar(200),
  Score int
);

insert into person values
(1,	'Alice',	'alice2018@hotmail.com',	88),
(2,	'Bob',	'bob2018@hotmail.com',	11),
(3,	'Davis',	'davis2018@hotmail.com',	27),
(4,	'Tara',	'tara2018@hotmail.com',	45),
(5,	'John',	'john2018@hotmail.com',	63);

create table friend(
PersonID	int,
  FriendID int
);

insert into friend values
(1	,2),
(1	,3),
(2	,1),
(2	,3),
(3	,5),
(4	,2),
(4	,3),
(4	,5);
*/

-- Approach #1
with pf as (
  select p.PersonID, p.name, f.FriendID
  from person p
  inner join friend f
  on p.PersonID = f.PersonID)
, fs as (
  select pf.PersonID
  , sum(p.score) friendScore
  from pf
  inner join person p 
  on pf.friendid = p.personid
  group by pf.PersonID)

select pf.PersonID, pf.name, count(pf.friendid) as friendCount
, fs.friendScore
from pf
inner join fs
on pf.PersonID = fs.PersonID
 where fs.friendScore > 100 
group by pf.PersonID, pf.name, fs.friendScore
order by 1;

-- Approach 2
with scope as (select f.personid, count(f.friendid) as friendCount, sum(p.score) as friendScore
from friend f
inner join person p
on f.friendid = p.personid
group by f.personid
having sum(p.score) > 100)

select s.personid, p.name , s.friendCount, s.friendScore
from scope s
inner join person p
on s.personid = p.personid
order by 1;