-- Table Creation

drop table if exists login_details;
create table login_details
(
	times	time,
	status	varchar(3)
);
insert into login_details values('10:00:00', 'on');
insert into login_details values('10:01:00', 'on');
insert into login_details values('10:02:00', 'on');
insert into login_details values('10:03:00', 'off');
insert into login_details values('10:04:00', 'on');
insert into login_details values('10:05:00', 'on');
insert into login_details values('10:06:00', 'off');
insert into login_details values('10:07:00', 'off');
insert into login_details values('10:08:00', 'off');
insert into login_details values('10:09:00', 'on');
insert into login_details values('10:10:00', 'on');
insert into login_details values('10:11:00', 'on');
insert into login_details values('10:12:00', 'on');
insert into login_details values('10:13:00', 'off');
insert into login_details values('10:14:00', 'off');
insert into login_details values('10:15:00', 'on');
insert into login_details values('10:16:00', 'off');
insert into login_details values('10:17:00', 'off');

select * from login_details;

-- SOLUTION

with cte as (
			select 
				*, 
				ROW_NUMBER() over(order by times) as rn2, 
				rn - ROW_NUMBER() over(order by times) as diff  
			from (
					select 
						*,
						ROW_NUMBER() over(order by times) as rn
					from login_details
					) x
			where status = 'on'
			),
	cte2 as (
			select distinct
				FIRST_VALUE(times) over(partition by diff order by times) as log_on,
				LAST_VALUE(times) over(partition by diff order by times rows between unbounded preceding and unbounded following) as last_log_on
			from cte
			),

	cte_final as (
			select 
				log_on, 
				lead(times) over(order by times) as log_off 
			from login_details l
			left join cte2 
			on cte2.last_log_on = l.times
			)
select 
	*, 
	DATEDIFF(minute, log_on, log_off) as duration 
from cte_final
where log_on is not null
