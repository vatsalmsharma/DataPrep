-- 579. Find Cumulative Salary of an Employee
/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| month       | int  |
| salary      | int  |
+-------------+------+
(id, month) is the primary key (combination of columns with unique values) for this table.
Each row in the table indicates the salary of an employee in one month during the year 2020.
 

Write a solution to calculate the cumulative salary summary for every employee in a single unified table.

The cumulative salary summary for an employee can be calculated as follows:

For each month that the employee worked, sum up the salaries in that month and the previous two months. This is their 3-month sum for that month. If an employee did not work for the company in previous months, their effective salary for those months is 0.
Do not include the 3-month sum for the most recent month that the employee worked for in the summary.
Do not include the 3-month sum for any month the employee did not work.
Return the result table ordered by id in ascending order. In case of a tie, order it by month in descending order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 1  | 2     | 30     |
| 2  | 2     | 30     |
| 3  | 2     | 40     |
| 1  | 3     | 40     |
| 3  | 3     | 60     |
| 1  | 4     | 60     |
| 3  | 4     | 70     |
| 1  | 7     | 90     |
| 1  | 8     | 90     |
+----+-------+--------+
Output: 
+----+-------+--------+
| id | month | Salary |
+----+-------+--------+
| 1  | 7     | 90     |
| 1  | 4     | 130    |
| 1  | 3     | 90     |
| 1  | 2     | 50     |
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 3  | 3     | 100    |
| 3  | 2     | 40     |
+----+-------+--------+
Explanation: 
Employee '1' has five salary records excluding their most recent month '8':
- 90 for month '7'.
- 60 for month '4'.
- 40 for month '3'.
- 30 for month '2'.
- 20 for month '1'.
So the cumulative salary summary for this employee is:
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 1  | 7     | 90     |  (90 + 0 + 0)
| 1  | 4     | 130    |  (60 + 40 + 30)
| 1  | 3     | 90     |  (40 + 30 + 20)
| 1  | 2     | 50     |  (30 + 20 + 0)
| 1  | 1     | 20     |  (20 + 0 + 0)
+----+-------+--------+
Note that the 3-month sum for month '7' is 90 because they did not work during month '6' or month '5'.

Employee '2' only has one salary record (month '1') excluding their most recent month '2'.
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 2  | 1     | 20     |  (20 + 0 + 0)
+----+-------+--------+

Employee '3' has two salary records excluding their most recent month '4':
- 60 for month '3'.
- 40 for month '2'.
So the cumulative salary summary for this employee is:
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 3  | 3     | 100    |  (60 + 40 + 0)
| 3  | 2     | 40     |  (40 + 0 + 0)
+----+-------+--------+
*/

-- Write your PostgreSQL query statement below
with recent_m as (
    select id, max(month) as recent_month 
    from employee
    group by id
),
cte as (
    select e1.id, e1.month,
    e1.salary + coalesce(e2.salary, 0) + coalesce(e3.salary, 0) as m3_sal
    from employee e1 
        left join employee e2 
            on (e2.id = e1.id 
                and e2.month = e1.month -1)
        left join employee e3 
            on (e3.id = e1.id 
                and e3.month = e1.month -2)
)
select id, month, m3_sal as salary 
from cte
where (id, month) not in (select id, recent_month from recent_m)
order by id asc, month desc;

/*
with cte_month as (
select 1 as month union
select 2 as month union
select 3 as month union
select 4 as month union
select 5 as month union
select 6 as month union
select 7 as month union
select 8 as month union
select 9 as month union
select 10 as month union
select 11 as month union
select 12 as month
)
, cte_emp as (select distinct id from employee)
, cte as (select ce.id as cid, cm.month as cm
from cte_month cm 
cross join cte_emp ce
),
scope as (
select c.cid, c.cm, coalesce(e.salary,0) as salary
from cte c
left join employee e 
on c.cid = e.id
    and c.cm = e.month
order by 1,2
), final_scope as (
select cid as id, cm as month, salary
, lag(salary, 1) over(partition by cid order by cm) as lag1_sal
, lag(salary, 2) over(partition by cid order by cm) as lag2_sal
from scope),
mrecent as (
    select id, month from (
                            select id, month, dense_rank() over(partition by id order by month desc) as rn
                            from employee
                            )
    where rn = 1
)
select fs.id, fs.month, 
--fs.salary , coalesce(fs.lag1_sal,0) , coalesce(fs.lag2_sal,0), 
(fs.salary + coalesce(fs.lag1_sal,0) + coalesce(fs.lag2_sal,0)) as salary 
from final_scope fs
where fs.salary > 0
and (fs.id, fs.month) not in (select id, month from mrecent)
order by fs.id asc, fs.month desc;
*/