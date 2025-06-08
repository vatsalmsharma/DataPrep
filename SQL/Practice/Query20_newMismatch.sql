create table source(id int, name varchar(5));

create table target(id int, name varchar(5));

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D');

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');

commit;


select s.id, 'New in source' as comment
from source s 
where s.id not in (select t.id from target t)
union 
select t.id, 'New in target'
from target t 
where t.id not in (select s.id from source s)
union 
select s.id, 'Mismatch'
from source s inner join target t
    on s.id = t.id
where s.name <> t.name;

