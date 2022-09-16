/*
Active User Retention

Source: DataLemur
Link: https://datalemur.com/questions/user-retention

Assume you have the table below containing information on Facebook user actions. Write a query to obtain the active user retention in July 2022. Output the month (in numerical format 1, 2, 3) and the number of monthly active users (MAUs).

Hint: An active user is a user who has user action ("sign-in", "like", or "comment") in the current month and last month.

user_actions Table:
Column Name	Type
user_id	integer
event_id	integer
event_type	string ("sign-in, "like", "comment")
event_date	datetime

user_actionsExample Input:
user_id	event_id	event_type	event_date
445	7765	sign-in	05/31/2022 12:00:00
742	6458	sign-in	06/03/2022 12:00:00
445	3634	like	06/05/2022 12:00:00
742	1374	comment	06/05/2022 12:00:00
648	3124	like	06/18/2022 12:00:00

Example Output for June 2022:
month	monthly_active_users
6	1

Example
In June 2022, there was only one monthly active user (MAU), user_id 445.

Note: We are showing you output for June 2022 as the user_actions table only have event_dates in June 2022. You should work out the solution for July 2022.
*/
-- Brute force solution
with july_user as
(SELECT distinct ua.user_id
, extract (year from ua.event_date)
, extract (month from ua.event_date) as month
FROM user_actions ua
WHERE     extract (year from ua.event_date) = 2022
      AND extract (month from ua.event_date) = 7
      AND event_type in ('sign-in', 'like', 'comment')
),
june_user as
(SELECT distinct ua.user_id
, extract (year from ua.event_date)
, extract (month from ua.event_date) as month
FROM user_actions ua
WHERE     extract (year from ua.event_date) = 2022
      AND extract (month from ua.event_date) = 6
      AND event_type in ('sign-in', 'like', 'comment')
)

select jul.month, count(*) as monthly_active_users
from july_user jul, june_user jun
where jul.user_id = jun.user_id
group by jul.month; 


-- Effective solution
with july_user as
(SELECT distinct ua.user_id
, extract (year from ua.event_date) as year
, extract (month from ua.event_date) as month
FROM user_actions ua
WHERE     extract (year from ua.event_date) = 2022
      AND extract (month from ua.event_date) = 7
      AND ua.event_type in ('sign-in', 'like', 'comment')
)

select jul.month, count(*) as monthly_active_users
from july_user jul
where exists (
select ua.user_id
from user_actions ua
where jul.user_id = ua.user_id
and ua.event_type in ('sign-in', 'like', 'comment')
and jul.year = extract (year from ua.event_date)
and jul.month = extract (month from ua.event_date + interval '1 month') 
)
group by jul.month; 