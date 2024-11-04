select * from covid_cases

WITH cte AS (
    SELECT 
        MONTH(dates) AS month, 
        SUM(cases_reported) AS monthly_cases 
    FROM covid_cases
    GROUP BY MONTH(dates)
),
cte_final AS (
    SELECT 
        month, 
        monthly_cases, 
        SUM(monthly_cases) OVER (ORDER BY month) AS total_cases
    FROM cte
)
SELECT *,
    CASE 
        WHEN month > 1 THEN 
            CAST((CAST(monthly_cases AS FLOAT) / LAG(total_cases) OVER (ORDER BY month)) * 100 AS VARCHAR(50)) 
        ELSE '-' 
    END AS percentage_increase
FROM cte_final;
