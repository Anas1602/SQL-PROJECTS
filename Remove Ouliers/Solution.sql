-- DATASET

drop table if exists hotel_ratings;

create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		decimal(3,1)
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.4);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

select * from hotel_ratings;

-- SOLUTION

with cte as (
			select 
				*,
				cast(AVG(rating) over(partition by hotel order by year rows between unbounded preceding and unbounded following) as decimal(10,2)) as avg_rating
			from hotel_ratings
			),

	cte_rnk as (
			select 
				*,
				abs(rating - avg_rating) as difference,
				RANK() over(partition by hotel order by abs(rating - avg_rating) desc) as rnk
			from cte
			)
select
	hotel,
	year,
	rating
from cte_rnk
where rnk > 1
order by hotel desc, year