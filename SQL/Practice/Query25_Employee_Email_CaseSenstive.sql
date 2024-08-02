-- Question: We need to return the employee_id and email_id. 
-- If there are duplicates for a given email id and it's in CAPs, ignore that record
/*
Given 3 records
Emp ID 2 and email id 'deep.khanna@gmail.com'
Emp ID 4 and email id 'deep.khanna@gmail.com'
Emp ID 5 and email id 'DEEP.KHANNA@GMAIL.COM'

Output
Emp ID 2 and email id 'deep.khanna@gmail.com'
Emp ID 4 and email id 'deep.khanna@gmail.com'

Note: Emp ID 5 is having duplicate email id and is written in CAPS


Given 2 records
Emp ID 1 and email id 'sri.ram@gmail.com'
Emp ID 6 and email id 'NANAJI.KHANNA@GMAIL.COM'

Output
Emp ID 1 and email id 'sri.ram@gmail.com'
Emp ID 6 and email id 'NANAJI.KHANNA@GMAIL.COM'

Note: There are no duplicates. 

*/
drop table employees_case;

create table employees_case(
	emp_id int not null,
	emp_name varchar(50),
    emp_email varchar(100),
  	primary key (emp_id)
);
  
insert into employees_case values(1, 'Sriram', 'sri.ram@gmail.com');
insert into employees_case values(2, 'Deepak', 'deep.khanna@gmail.com');
insert into employees_case values(3, 'Neha', 'sri.ram@gmail.com');
insert into employees_case values(4, 'Ankita', 'deep.khanna@gmail.com');
insert into employees_case values(5, 'Nana ji', 'DEEP.KHANNA@GMAIL.COM');
insert into employees_case values(6, 'Nana ji', 'NANAJI.KHANNA@GMAIL.COM');
        
commit;


-- Case Insensitive 
with cte as (
            select emp_id, emp_email, ascii(emp_email), 
            rank() over (partition by emp_email order by ascii(emp_email) desc) as my_rank
            from employees_case
            )
select emp_id, emp_email 
from cte
where my_rank = 1
order by 1;



-- Case Sensitive 
with cte as (
            select emp_id, emp_email, ascii(emp_email), 
            rank() over (partition by lower(emp_email) order by ascii(emp_email) desc) as my_rank
            from employees_case
            )
select emp_id, emp_email 
from cte
where my_rank = 1
order by 1;