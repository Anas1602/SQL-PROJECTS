-- Table Creation
use [Pizza DB]
DROP TABLE IF EXISTS company;
CREATE TABLE company
(
	employee	varchar(10) primary key,
	manager		varchar(10)
);

INSERT INTO company values ('Elon', null);
INSERT INTO company values ('Ira', 'Elon');
INSERT INTO company values ('Bret', 'Elon');
INSERT INTO company values ('Earl', 'Elon');
INSERT INTO company values ('James', 'Ira');
INSERT INTO company values ('Drew', 'Ira');
INSERT INTO company values ('Mark', 'Bret');
INSERT INTO company values ('Phil', 'Mark');
INSERT INTO company values ('Jon', 'Mark');
INSERT INTO company values ('Omid', 'Earl');

SELECT * FROM company;

-- Solution

-- Define the root manager (Elon) teams first
WITH cte_teams AS (
    SELECT 
        mng.employee AS root_manager,
        CONCAT('Team ', ROW_NUMBER() OVER (ORDER BY mng.employee)) AS Teams
    FROM company root
    JOIN company mng ON root.employee = mng.manager
    WHERE root.manager IS NULL
),
-- Recursive CTE to build hierarchy for each team
cte AS (
    SELECT 
        c.employee,
        c.manager,
        t.Teams,
        1 AS hierarchy_level  
    FROM company c
    JOIN cte_teams t ON c.manager = t.root_manager
    
    UNION ALL
    
    -- Recursive step: get the subordinates of each employee in the hierarchy
    SELECT 
        c.employee,
        c.manager,
        p.Teams,
        p.hierarchy_level + 1
    FROM company c
    JOIN cte p ON c.manager = p.employee
),
-- Add root manager (Elon) explicitly to each team with hierarchy_level 0
cte_with_root AS (
    SELECT DISTINCT root_manager AS employee, Teams, 0 AS hierarchy_level FROM cte_teams
    UNION ALL
    SELECT employee, Teams, hierarchy_level FROM cte
),
-- Concatenate Elon explicitly at the start of each team members list
cte_final AS (
    SELECT 
        Teams,
        STRING_AGG(employee, ', ') WITHIN GROUP (ORDER BY hierarchy_level, employee) AS Members
    FROM cte_with_root
    GROUP BY Teams
)
-- Final output with Elon at the beginning of each team
SELECT 
    Teams,
    'Elon, ' + Members AS Members
FROM cte_final
ORDER BY Teams;
