-- Finding route with most number of flights : Busiest Route
create table tickets(
    airline_number varchar(10) NOT NULL,
    origin varchar(20),
    destination varchar(20),
    oneway_round char(1),
    ticket_count int,
    primary key (airline_number)
);

INSERT INTO tickets (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);


with cte as 
    (select destination as origin, origin as destination, ticket_count from tickets where oneway_round = 'R'
     union all 
     select origin, destination , ticket_count from tickets)
, scope as (
            select origin, destination, sum(ticket_count) as total_count
            from cte 
            group by origin, destination
            )
select origin, destination 
from scope 
where total_count = (select max(total_count) from scope);