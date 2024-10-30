-- TABLE CREATION

DROP TABLE IF EXISTS invoice;

CREATE TABLE invoice (
    serial_no INT,
    invoice_date DATE
);

INSERT INTO invoice (serial_no, invoice_date) VALUES (330115, '2024-03-01');
INSERT INTO invoice (serial_no, invoice_date) VALUES (330120, '2024-03-01');
INSERT INTO invoice (serial_no, invoice_date) VALUES (330121, '2024-03-01');
INSERT INTO invoice (serial_no, invoice_date) VALUES (330122, '2024-03-02');
INSERT INTO invoice (serial_no, invoice_date) VALUES (330125, '2024-03-02');

SELECT * FROM invoice;


--SOLUTION

DECLARE @Start INT;
DECLARE @End INT;

-- Set @Start and @End based on the values in the invoice table
SELECT @Start = MIN(serial_no) FROM invoice;
SELECT @End = MAX(serial_no) FROM invoice;

WITH NumberSeries AS (
    SELECT @Start AS Number
    UNION ALL
    SELECT Number + 1
    FROM NumberSeries
    WHERE Number + 1 <= @End
)
-- Perform the EXCEPT operation and then order the results
SELECT Number
FROM NumberSeries
EXCEPT
SELECT serial_no FROM invoice
ORDER BY Number;



