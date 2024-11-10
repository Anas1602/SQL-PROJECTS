-- Table Creation

drop table if exists vacation_plans;
create table vacation_plans
(
	id 			int primary key,
	emp_id		int,
	from_dt		date,
	to_dt		date
);
insert into vacation_plans values(1,1, '2024-02-12', '2024-02-16');
insert into vacation_plans values(2,2, '2024-02-20', '2024-02-29');
insert into vacation_plans values(3,3, '2024-03-01', '2024-03-31');
insert into vacation_plans values(4,1, '2024-04-11', '2024-04-23');
insert into vacation_plans values(5,4, '2024-06-01', '2024-06-30');
insert into vacation_plans values(6,3, '2024-07-05', '2024-07-15');
insert into vacation_plans values(7,3, '2024-08-28', '2024-09-15');


drop table if exists leave_balance;
create table leave_balance
(
	emp_id			int,
	balance			int
);
insert into leave_balance values (1, 12);
insert into leave_balance values (2, 10);
insert into leave_balance values (3, 26);
insert into leave_balance values (4, 20);
insert into leave_balance values (5, 14);

select * from vacation_plans;
select * from leave_balance;

-- SOLUTION

CREATE FUNCTION dbo.WeekdayDifference (
    @start_date DATE,
    @end_date DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @current_date DATE = @start_date;
    DECLARE @weekday_count INT = 0;

    WHILE @current_date <= @end_date
    BEGIN
        IF DATEPART(WEEKDAY, @current_date) NOT IN (1, 7) -- 1 = Sunday, 7 = Saturday 
            SET @weekday_count += 1;
        
        SET @current_date = DATEADD(DAY, 1, @current_date);
    END

    RETURN @weekday_count;
END;


WITH cte AS (
    SELECT 
        id,
        v.emp_id,
        from_dt,
        to_dt,
        l.balance AS leave_balance,
        dbo.WeekdayDifference(from_dt, to_dt) AS vacation_days,
        ROW_NUMBER() OVER(PARTITION BY v.emp_id ORDER BY v.emp_id, v.id) AS rn
    FROM vacation_plans v
    LEFT JOIN leave_balance l 
    ON v.emp_id = l.emp_id
),
recursive_cte AS (
    SELECT 
        id,
        emp_id,
        from_dt,
        to_dt,
        leave_balance,
        vacation_days,
        rn,
        (leave_balance - vacation_days) AS remaining_balance
    FROM cte
    WHERE rn = 1

    UNION ALL

    SELECT 
        c.id id,
        c.emp_id emp_id,
        c.from_dt from_dt,
        c.to_dt to_dt,
        c.leave_balance,
        c.vacation_days vacation_days,
        c.rn,
        (rc.remaining_balance - c.vacation_days) AS remaining_balance
    FROM cte c
    JOIN recursive_cte rc 
    ON c.emp_id = rc.emp_id AND c.rn = rc.rn + 1
)
SELECT 
	id, 
	emp_id, 
	from_dt, 
	to_dt, 
	vacation_days, 
	case 
		when remaining_balance < 0 then 'Insufficient Leave Balance' else 'Approved' 
	end as status FROM recursive_cte
ORDER BY status, emp_id
