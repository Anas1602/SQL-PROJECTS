-- Table Creation

drop table if exists Day_Indicator;
create table Day_Indicator
(
	Product_ID 		varchar(10),	
	Day_Indicator 		varchar(7),
	Dates			date
);
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'04-Mar-2024', 102));
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'05-Mar-2024', 102));
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'06-Mar-2024', 102));
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'07-Mar-2024', 102));
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'08-Mar-2024', 102));
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'09-Mar-2024', 102));
insert into Day_Indicator values ('AP755', '1010101', CONVERT(DATE,'10-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'04-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'05-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'06-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'07-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'08-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'09-Mar-2024', 102));
insert into Day_Indicator values ('XQ802', '1000110', CONVERT(DATE,'10-Mar-2024', 102));

select * from Day_Indicator;

-- Solution

with cte as (
			select 
				*,
				case 
					when substring(Day_indicator, (((DATEPART(dw, Dates) + 5) % 7) + 1), 1) = '1' 
					then 'Include' 
					else 'Ecxlude' 
				end as flag
			from Day_Indicator
			)

select 
	Product_ID, 
	Day_indicator, 
	Dates
from cte 
where flag = 'Include'
