-- Table Creation

drop table if exists tokens;
create table tokens
(
	token_num	int,
	customer	varchar(20)
);
insert into tokens values(1, 'Maryam');
insert into tokens values(2, 'Rocky');
insert into tokens values(3, 'John');
insert into tokens values(3, 'John');
insert into tokens values(2, 'Arya');
insert into tokens values(1, 'Pascal');
insert into tokens values(9, 'Kate');
insert into tokens values(9, 'Ibrahim');
insert into tokens values(8, 'Lilly');
insert into tokens values(8, 'Lilly');
insert into tokens values(5, 'Shane');

select * from tokens;

-- Dataset
with cte as (
			select
				customer,
				count(customer) as count
			from tokens
			group by customer
			having count(customer) > 1
			)
select 
	min(token_num) token_num 
from tokens 
where customer in (
			select customer from cte
			)
