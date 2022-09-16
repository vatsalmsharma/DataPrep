/*
Sending vs. Opening Snaps

Source: DataLemur
Link: https://datalemur.com/questions/time-spent-snaps

Assume you are given the tables below containing information on Snapchat users, their ages, and their time spent sending and opening snaps. Write a query to obtain a breakdown of the time spent sending vs. opening snaps (as a percentage of total time spent on these activities) for each of the different age groups.

To clarify, you should calculate these percentages:

time sending / (time sending + time opening)
time opening / (time sending + time opening)
Output the age bucket and percentage of sending and opening snaps. Round the percentages to 2 decimal places.

Note that to find the percentages, multiply by 100.0 and not 100 to avoid integer division.

activities Table:
Column Name	Type
activity_id	integer
user_id	integer
activity_type	string ('send', 'open', 'chat')
time_spent	float
activity_date	datetime

activities Example Input:
activity_id	user_id	activity_type	time_spent	activity_date
7274	123	open	4.50	06/22/2022 12:00:00
2425	123	send	3.50	06/22/2022 12:00:00
1413	456	send	5.67	06/23/2022 12:00:00
1414	789	chat	11.00	06/25/2022 12:00:00
2536	456	open	3.00	06/25/2022 12:00:00

age_breakdown Table:
Column Name	Type
user_id	integer
age_bucket	string ('21-25', '26-30', '31-25')

age_breakdown Example Input:
user_id	age_bucket
123	31-35
456	26-30
789	21-25

Example Output:
age_bucket	send_perc	open_perc
26-30	65.40	34.60
31-35	43.75	56.25

Explanation
For the age bucket 26-30, the time spent sending snaps was 5.67 and opening 3. The percent of time sending snaps was 5.67/(5.67+3)=65.4%, and the percent of time opening snaps was 3/(5.67+3)=34.6%.
*/
-- Brutforce solution
with 
scope as (
          SELECT 
            a.activity_type,
            ab.age_bucket,
            sum(a.time_spent) as sum_time
          FROM activities a, age_breakdown ab
          WHERE a.user_id = ab.user_id
            AND a.activity_type in ('send', 'open')
          GROUP BY a.activity_type,
            ab.age_bucket),
time_agg AS (
            SELECT 
              s.age_bucket, sum(s.sum_time) as total_time
              from scope s 
              group by s.age_bucket
              
)  

--select * from scope;

select s.age_bucket
, sum (case
    when (s.activity_type = 'send')
      then round((s.sum_time/(ta.total_time)*100.0),2)
--    else 0.0
  end) as send_perc
, sum (case
    when (s.activity_type = 'open')
      then round((s.sum_time/(ta.total_time)*100.0),2)
--    else 0.0
  end) as open_perc
from scope s, time_agg ta 
where s.age_bucket = ta.age_bucket
group by s.age_bucket
order by s.age_bucket
;

-- Effective Solution
with 
scope as (
          SELECT 
            ab.age_bucket
        ,sum(
              CASE  
                  when (activity_type = 'open')
                  then time_spent
              END    
              ) as open_time
        ,sum(CASE  
                  when (activity_type = 'send')
                  then time_spent
              END
              ) as send_time
        ,sum(time_spent) as total_time
          FROM activities a, age_breakdown ab
          WHERE a.user_id = ab.user_id
            AND a.activity_type in ('send', 'open')
          GROUP BY ab.age_bucket
          )
            
select age_bucket
, round(sum((send_time/total_time)*100.0),2)  as send_perc
, round(sum((open_time/total_time)*100.0),2)  as open_perc
from scope
group by age_bucket
order by age_bucket;