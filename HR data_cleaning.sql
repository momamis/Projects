CREATE DATABASE projects;
USE projects;
ALTER TABLE projects.hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;
DESCRIBE projects.hr;
SELECT birthdate FROM projects.hr;
SET SQL_SAFE_UPDATES = 0;
UPDATE projects.hr
SET birthdate = CASE
WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
ELSE null
END;

ALTER TABLE projects.hr
MODIFY COLUMN birthdate DATE;

UPDATE projects.hr
SET hire_date = CASE
WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
ELSE null
END;
ALTER TABLE projects.hr
MODIFY hire_date DATE;

UPDATE projects.hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';
UPDATE projects.hr
SET termdate = NULL 
WHERE termdate = '';
SHOW VARIABLES LIKE 'sql_mode';
ALTER TABLE projects.hr
MODIFY COLUMN termdate DATE;
select termdate from projects.hr;

ALTER TABLE projects.hr ADD COLUMN age INT;

UPDATE projects.hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM projects.hr;

SELECT
MIN(age) AS youngest,
MAX(age) AS oldest
FROM projects.hr;
SELECT COUNT(*) FROM projects.hr
WHERE age < 18;




