-- Table Creation
DROP TABLE IF EXISTS Friends;

CREATE TABLE Friends
(
	Friend1 	VARCHAR(10),
	Friend2 	VARCHAR(10)
);
INSERT INTO Friends VALUES ('Jason','Mary');
INSERT INTO Friends VALUES ('Mike','Mary');
INSERT INTO Friends VALUES ('Mike','Jason');
INSERT INTO Friends VALUES ('Susan','Jason');
INSERT INTO Friends VALUES ('John','Mary');
INSERT INTO Friends VALUES ('Susan','Mary');

select * from Friends;

-- Logic 
	-- 1 -- get all the friends

-- Solution

with all_friends as (
			select Friend1, Friend2 from Friends 
			union all
			select Friend2, Friend1 from Friends
			-- order by 1
					)
select 
	distinct f.*, 
	count(af.Friend2) over(partition by f.Friend1, f.Friend2 
							order by af.Friend2 
							rows between unbounded preceding and unbounded following) as mutual_friends
from Friends f
left join all_friends af
	on f.Friend1 = af.Friend1
	and af.Friend2 in 
					(
					select 
						af2.Friend2 
					from all_friends af2 
					where af2.Friend1 = f.Friend2
					)
order by 1
