-- Name : Complex SQL 4 | SQL Question Asked in a FAANG Interview 
-- URL : https://www.youtube.com/watch?v=6XQAokp4UCs&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=4
/*
-- Setup : 
-- Nth Sunday after 2023-12-20 (Wednesday)
-- N = 3
-- https://www.postgresql.org/docs/8.1/functions-datetime.html

*/

-- Solution :
select current_date
-- ,(7 - extract (dow from current_date))
, current_date + (7 -  (extract (dow from current_date)) :: int) + (7 * (3-1)) as nthSundayDate
, date '2023-12-24' + (7 -  (extract (dow from date '2023-12-24')) :: int) + (7 * (3-1)) as ASundayDate
;