-- TABLES CREATION 

drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);

select * from salary;

	-- Income Table
drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);

select * from income;

	-- deduction table
drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);

select * from deduction;

-- SOLUTION

drop table if exists emp_transaction;

create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount		numeric
);

insert into emp_transaction
select 
	s.emp_id, 
	s.emp_name, 
	x.trns_type,
	case 
		when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
		when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
		when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
		when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
		when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
		when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) 
	 end as amount	   
from salary s

cross join (
		select income as trns_type, percentage from income
		union
		select deduction as trns_type, percentage from deduction
		) x;

select * from emp_transaction;

-- Report Generation

select 
	emp_name as employee,
	Basic, 
	Allowance, 
	Others, 
	(Basic + Allowance + Others) as gross,
	Insurance,
	Health,
	House,
	(Insurance + Health + House) as total_deductions,
	(Basic + Allowance + Others) - (Insurance + Health + House) as net_pay
from ( 
	select emp_name, trns_type, amount from  emp_transaction ) bq
pivot
	( 
	sum(amount)
	for trns_type in ([Allowance], [Basic], [Others], [Insurance], [Health], [House] )
	) pq

