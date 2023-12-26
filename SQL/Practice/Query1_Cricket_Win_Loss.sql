-- Name : Complex SQL Query 1 | Derive Points table for ICC tournament
-- URL : https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb
/*
-- Setup :
create table cricket(
  team1 varchar(20),
  team2 varchar(20),
  winner varchar(20)
);

insert into cricket values
  ('India', 'SL', 'India'),
   ('SL', 'Aus', 'Aus'),
   ('SA', 'Eng', 'Eng'),
   ('Eng', 'NZ', 'NZ'),
   ('Aus', 'India', 'India');

-- Expected output
team_name	| match_played	| no_of_wins	| no_of_losses
SL	        | 2	            | 0	            | 2
NZ	        | 1	            | 1	            | 0
SA	        | 1	            | 0	            | 1
India	      | 2	            | 2	            | 0
Aus	        | 2	            | 1	            | 1
Eng	        | 2	            | 1       	    | 1
*/

-- Solution :
-- Approach 1
with teams as (
                select team1 as team_name from cricket union
                select team2 from cricket
              ),
     play as (
               select t.team_name, count(*) match_played
               from teams t left join cricket c
               on t.team_name = c.team1
               or t.team_name = c.team2
               group by  t.team_name
             )
select p.team_name, p.match_played, count(c.winner)  as no_of_wins,
 p.match_played - count(c.winner)  as no_of_losses
from play p 
left join cricket c
on p.team_name = c.winner
group by p.team_name, p.match_played;

-- Approach 2
with scope as (
select team1 as team_name,
case
  when team1 = winner
    then 1
  else 0 
end as win_flag
from cricket union all
select team2 as team_name,
case
  when team2 = winner
    then 1
  else 0 
end as win_flag
from cricket)
select team_name, count(1) as match_played,
sum(win_flag) as no_of_wins,
count(1) - sum(win_flag) as no_of_losses
from scope 
group by team_name;