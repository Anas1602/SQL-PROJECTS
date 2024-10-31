-- TABLEs CREATION

-- Events Table

DROP TABLE  if exists events
CREATE TABLE events
(
    event_name VARCHAR(50),
    emp_id INT,
    dates DATE
);

INSERT INTO events VALUES ('Product launch', 1, '2024-03-01');
INSERT INTO events VALUES ('Product launch', 3, '2024-03-01');
INSERT INTO events VALUES ('Product launch', 4, '2024-03-01');
INSERT INTO events VALUES ('Conference', 2, '2024-03-02');
INSERT INTO events VALUES ('Conference', 2, '2024-03-03');
INSERT INTO events VALUES ('Conference', 3, '2024-03-02');
INSERT INTO events VALUES ('Conference', 4, '2024-03-02');
INSERT INTO events VALUES ('Training', 3, '2024-03-04');
INSERT INTO events VALUES ('Training', 2, '2024-03-04');
INSERT INTO events VALUES ('Training', 4, '2024-03-04');
INSERT INTO events VALUES ('Training', 4, '2024-03-05');

-- Employees Table 

DROP TABLE  if exists employees

CREATE TABLE employees
(
    ID INT PRIMARY KEY,
    NAME VARCHAR(50)
);

INSERT INTO employees (ID, NAME) VALUES (1, 'Lewis');
INSERT INTO employees (ID, NAME) VALUES (2, 'Max');
INSERT INTO employees (ID, NAME) VALUES (3, 'Charles');
INSERT INTO employees (ID, NAME) VALUES (4, 'Sainz');

SELECT * FROM employees;
SELECT * FROM events;


-- Solution
SELECT e.NAME as name, COUNT(DISTINCT ev.event_name) AS no_of_events
FROM events ev 
JOIN employees e 
ON ev.emp_id = e.ID
WHERE ev.emp_id >= 3
GROUP BY ev.emp_id, e.NAME;




