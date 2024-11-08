-- TABLE CREATION

drop table if exists feedback;
create table feedback
(
	feedback_id		int,
	cust_name		varchar(20),
	email			varchar(50),
	rating			float,
	remarks			varchar(200)
);
insert into feedback values(1, 'Zohan', 'zohan@2024@gmail.com', 4, 'good');
insert into feedback values(2, 'Keyaan', 'keyaan.TR@gmail.com', 5, 'very good');
insert into feedback values(3, 'Zayn', 'ZAYN...@gmail', 3, 'ok');
insert into feedback values(4, 'Emir', 'emir-#1@outlook.com', 4, 'ok');
insert into feedback values(5, 'Ashar', 'Ashar-@hotmail.DE', 4, 'nice');
insert into feedback values(6, 'Zoya', 'zoya@techTFQ.org', 4, 'great');
insert into feedback values(7, 'Kabir', 'kabir.com@-gmail.com', 2, 'bad');
insert into feedback values(8, 'Ayaan', 'ayaan123@company.net', 1, 'poor');
insert into feedback values(9, 'Meir', 'meir123@', 1.5, 'poor');
insert into feedback values(10, 'Noah', 'noah_.com@.com', 3.5, 'bad');
insert into feedback values(11, 'Idris', 'i@gmail.com', 5, 'excellent');
insert into feedback values(12, 'Arhaan', 'arhaan$gmail.com', 5, 'awesome');
insert into feedback values(13, 'Abrar', 'abrar123@gmail.comm', 5, 'awesome');


select * from feedback;


-- SOLUTION
select 
	cust_name, 
	email as valid_emails 
from feedback
where 
	email like '[a-zA-Z]%@[a-zA-Z]%.[a-zA-Z]%'
and 
	email not like '%[^a-zA-Z0-9_.-]%@[a-zA-Z]%.[a-zA-Z]%'
and 
	CHARINDEX('.', reverse(email)) between 3 and 4