
-- Table Creation

DROP TABLE IF EXISTS brands;
CREATE TABLE brands 
(
    brand1      VARCHAR(20),
    brand2      VARCHAR(20),
    year        INT,
    custom1     INT,
    custom2     INT,
    custom3     INT,
    custom4     INT
);

-- Values Insertion

INSERT INTO brands VALUES ('apple', 'samsung', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('samsung', 'apple', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('apple', 'samsung', 2021, 1, 2, 5, 3);
INSERT INTO brands VALUES ('samsung', 'apple', 2021, 5, 3, 1, 2);
INSERT INTO brands VALUES ('google', NULL, 2020, 5, 9, NULL, NULL);
INSERT INTO brands VALUES ('oneplus', 'nothing', 2020, 5, 9, 6, 3);

-- Solution

with cte as (
			select 
				*,
				case when brand1 < brand2 then CONCAT(brand1, brand2, year)
					else CONCAT(brand2, brand1, year)
				end as pair_id
			FROM brands
			),
	cte_rn as (
			select 
				*,
				ROW_NUMBER() over(partition by pair_id order by pair_id) as rn
			from cte
			)
select 
	brand1, brand2, custom1, custom2, custom3, custom4
from cte_rn
where rn = 1
or (custom1 <> custom3 and custom2 <> custom4)