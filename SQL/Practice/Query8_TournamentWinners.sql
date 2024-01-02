-- Name : Leetcode Hard problem 2| Tournament Winners | Complex SQL 8
-- URL : https://www.youtube.com/watch?v=IQ4n4n-Y9z8&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=8
/*
-- Setup :
create table players
(player_id int,
group_id int);


create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

-- Expected output
player	| group_id
15	    | 1
35	    | 2
40	    | 3
*/

-- Solution :
with scope as 
	(select 
--	m.match_id,
	m.first_player as player,
	m.first_score as score,
	p.group_id
from matches m
		inner join players p
	on m.first_player = p.player_id
union all 
select 
--	m.match_id,
	m.second_player as player,
	m.second_score as score,
	p.group_id
from matches m
		inner join players p
	on m.second_player = p.player_id
     )
, playerScore as 
	(select s.player, s.group_id, sum(s.score) as totalScore
	from scope s
	group by s.player, s.group_id
     )
, finalScope as 
	(select *
		, dense_rank() over(partition by group_id order by totalScore desc, player 			asc) as myRank  
		from  playerScore
     )

select player, group_id
from finalScope
where myrank = 1
order by 2;  

 -- https://www.db-fiddle.com/