-- Create Table and Insert Data

DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;

--Solution

select * from (
select 
	top 1 car
from FOOTER 
where car is not null
order by id desc) car
cross join (
select 
	top 1 length
from FOOTER 
where length is not null
order by id desc) length
cross join (
select 
	top 1 width
from FOOTER 
where width is not null
order by id desc) width
cross join (
select 
	top 1 height
from FOOTER 
where height is not null
order by id desc) height

