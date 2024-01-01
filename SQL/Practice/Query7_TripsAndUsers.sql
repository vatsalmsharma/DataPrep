-- Name : Leetcode Hard Problem | Complex SQL 7 | Trips and Users
-- URL : https://www.youtube.com/watch?v=EjzhMv0E_FE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb
/*
-- Setup :
Create table  Trips (
  id int
  , client_id int
  , driver_id int
  , city_id int
  , status varchar(50)
  , request_at varchar(50)
);

Create table Users (
  users_id int
  , banned varchar(50)
  , role varchar(50)
);

-- Truncate table Trips;
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', date '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', date '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', date '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', date '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', date '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', date '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', date '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', date '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', date '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', date '2013-10-03');

-- Truncate table Users;
insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');

-- Expected output
request_at	| totaltrips	| totalcanceltrips	| cancellationrate	| cancellationratedeci
2013-10-01	| 3	        | 1	                | 33.33	            | 33.33
2013-10-02	| 2	        | 0	                | 0	                | 0.
2013-10-03	| 2	        | 1	                | 50	                | 50.

*/

-- Solution :
-- Approach #1
with unbanned as 
  (select users_id from users where  banned = 'No')
, scope as  
  (select t.request_at
  , case
      when t.status like 'cancelled%'
        then 1
      else
        0
    end as CancelTrip
  from Trips t
  where t.client_id in (select u.users_id from unbanned u )
    and t.driver_id in (select u.users_id from unbanned u)
   )

select s.request_at, count(1) as totalTrips
, sum(s.canceltrip) as totalCancelTrips
,round(((sum(s.canceltrip) * 1.0)/ count(1))*100,2) as CancellationRate
,to_char(((sum(s.canceltrip) * 1.0)/ count(1))*100, 'FM99.99') as CancellationRateDeci
from scope s
group by s.request_at
order by 1;

-- Approach #2
select t.request_at,
count(1) as totalTrips,
count (case 
            when t.status in ('cancelled_by_driver', 'cancelled_by_client')
              then 1
            else null
      end
     ) as cancelled_trips
, (1.0 * count (case 
            when t.status in ('cancelled_by_driver', 'cancelled_by_client')
              then 1
            else null
      end ) / count(1)) *100 as Cancelled_percentage
from trips t
inner join users c on t.client_id = c.users_id
inner join users d on t.driver_id = d.users_id
where c.banned = 'No' and d.banned = 'No'
group by  t.request_at
order by 1;

