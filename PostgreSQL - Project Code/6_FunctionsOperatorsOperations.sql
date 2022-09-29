--/// Logic Operators

-- AND 

SELECT *
  FROM banktransaction
 WHERE banktransaction_type = 'C'
   AND banktransaction_type = 'D';

-- OR

SELECT *
  FROM banktransaction
 WHERE banktransaction_type = 'C'
    OR banktransaction_type = 'D';

SELECT *
  FROM banktransaction
 WHERE banktransaction_type = 'C'
    OR (banktransaction_type = 'D'
        AND banktransaction_created_at = '11/02/2022');


-- NOT

SELECT *
  FROM banktransaction
 WHERE banktransaction_type = 'C'
   AND NOT banktransaction_type = 'D';

--------------------------------------------------------------------------
-- /// Comparation Operators 

SELECT *
  FROM banktransaction
 WHERE banktransaction_value > 10000;

 SELECT *
  FROM banktransaction
 WHERE banktransaction_value < 10000;

SELECT *
  FROM banktransaction
 WHERE banktransaction_value >= 10000;

 SELECT *
  FROM banktransaction
 WHERE banktransaction_value <= 10000;

  SELECT *
  FROM banktransaction
 WHERE banktransaction_value = 111111;


--------------------------------------------------------------------------
-- /// Mathematical Operators and Mathematical Functions 

--// Mathematical Operators
select 2+3;
select 2-3;
select 2*3;
select 4/2;
select 5%4;
select 2^3;
select @ -5;
select  |/25;
select  ||/64;

--// Mathematical Functions
select abs(-5);
select cbrt(64);
select ceil(14.16);
select ceiling(14.22);
select degrees(1);
select div(8,4);
select exp(2);
select floor(12.9);
select ln(2);
select log(10);
select log(100,2);
select mod(11,2);
select pi();
select power(9.0, 3.0);
select radians(12);
select round(25.2);
select round(54.123,2);
select sqrt(9);
select trunc(335.23);
select trunc(335.123,2);

--//  Trigonometric Functions
select acos(0);
select asin(0.2);
select atan(2);
select cos(3);
select cot(3);
select sin(3);
select tan(3);

--------------------------------------------------------------------------
-- /// Text Functions

-- Concat Strings
    SELECT 'name: ' || cl.client_name || ' -- account: ' || ac.account_id
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id;

-- Count caracteres

    SELECT char_length(cl.client_name)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id;

-- Upper case & Lower case

    SELECT upper(cl.client_name), lower(cl.client_name)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id;

-- Overlay()
   SELECT overlay(cl.client_name placing '********' from 3 for 5)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id;

-- Substring()

   SELECT substring(cl.client_name from 1 for 3)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id;

-- Position()

   SELECT position('th' in cl.client_name)
      FROM client cl
	 WHERE cl.client_id = '312c2cfd-589e-4c5b-a8e0-333abfff3336';

--------------------------------------------------------------------------
-- /// Date Functions

show datestyle;

SELECT AGE(timestamp '11/04/1988');

SELECT AGE(timestamp '11/04/2000', timestamp '11/04/1988');

--// Functions to select current date time

SELECT CLOCK_TIMESTAMP();
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;
SELECT LOCALTIME;
SELECT LOCALTIMESTAMP;
SELECT NOW();
SELECT STATEMENT_TIMESTAMP();
SELECT TIMEOFDAY();

SELECT DATE_PART('DAY', TIMESTAMP '11/04/1988 20:38:40');
SELECT DATE_PART('MONTH', TIMESTAMP '11/04/1988 20:38:40');
SELECT DATE_PART('YEAR', TIMESTAMP '11/04/1988 20:38:40');

SELECT DATE_PART('HOUR', TIMESTAMP '11/04/1988 20:38:40');
SELECT DATE_PART('MINUTE', TIMESTAMP '11/04/1988 20:38:40');
SELECT DATE_PART('SECOND', TIMESTAMP '11/04/1988 20:38:40');


SELECT JUSTIFY_DAYS(INTERVAL '43 DAYS');
SELECT JUSTIFY_HOURS(INTERVAL '32 HOURS');

SELECT JUSTIFY_INTERVAL(INTERVAL '2 MON - 25 HOURS');
SELECT JUSTIFY_INTERVAL(INTERVAL '2 MON - 14 DAYS');
SELECT JUSTIFY_INTERVAL(INTERVAL '3 DAYS - 8 HOUR');
SELECT JUSTIFY_INTERVAL(INTERVAL '4 MON  - 28 HOURS');

-- Extract

SELECT EXTRACT(CENTURY FROM TIMESTAMP '11/04/1988');
SELECT EXTRACT(CENTURY FROM NOW());

SELECT EXTRACT(DAY FROM TIMESTAMP '11/04/1988');
SELECT EXTRACT(DECADE FROM TIMESTAMP '11/04/1988');
SELECT EXTRACT(DOY FROM TIMESTAMP '11/04/1988');
SELECT EXTRACT(YEAR FROM TIMESTAMP '11/04/1988');
SELECT EXTRACT(MONTH FROM TIMESTAMP '11/04/1988');


SELECT EXTRACT(HOUR FROM TIMESTAMP '11/04/1988 20:14:26');
SELECT EXTRACT(MINUTE FROM TIMESTAMP '11/04/1988 20:14:26');
SELECT EXTRACT(SECOND FROM TIMESTAMP '11/04/1988 20:14:26');

SELECT EXTRACT(YEAR FROM account_created_at)
 FROM account;


--------------------------------------------------------------------------
-- /// Aggregators Functions - COUNT() SUM() AVG() MAX() MIN() GROUP BY 

-- MAX() -> MAXIMUM VALUE OF banktransaction_value 
    SELECT cl.client_name, ac.account_id, MAX(bt.banktransaction_value)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY cl.client_name, ac.account_id

-- MIN() -> MINIMUM VALUE OF banktransaction_value 
 SELECT cl.client_name, ac.account_id, MIN(bt.banktransaction_value)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY cl.client_name, ac.account_id

-- AVG() -> AVERAGE VALUE OF banktransaction_value 

 SELECT cl.client_name, ac.account_id, AVG(bt.banktransaction_value)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY cl.client_name, ac.account_id

-- SUM() -> SUMMARIZE VALUE OF banktransaction_value 

 SELECT cl.client_name, ac.account_id, SUM(bt.banktransaction_value)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY cl.client_name, ac.account_id

-- COUNT() -> COUNT VALUE OF banktransaction_value 

    SELECT cl.client_name, COUNT(bt.banktransaction_id), SUM(bt.banktransaction_value)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY cl.client_name, ac.account_id

-- HAVING 

  SELECT cl.client_name, COUNT(bt.banktransaction_id), SUM(bt.banktransaction_value)
      FROM client cl
INNER JOIN account ac 
        ON cl.client_id = ac.client_id
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY cl.client_name, ac.account_id
  HAVING SUM(bt.banktransaction_value) > 30000

--------------------------------------------------------------------------
--/// Window functions

-- ROW_NUMBER()

  SELECT "client_name", tab.banktransaction_value, banktransaction_type 
    FROM (
            SELECT cl.client_name as "client_name", ac.account_id, bt.banktransaction_value, 
                    bt.banktransaction_type,
                    ROW_NUMBER() over (partition by bt.banktransaction_type order by bt.banktransaction_value desc) as tp
                FROM client cl
        INNER JOIN account ac 
                ON cl.client_id = ac.client_id
        INNER JOIN banktransaction bt
                ON bt.account_id = ac.account_id
                WHERE bt.account_id = 'f580509c-8341-49ba-92f6-369f126468cb'
            ORDER BY bt.banktransaction_value 
        ) as tab
   WHERE tp = 1
ORDER BY banktransaction_type


--------------------------------------------------------------------------
--/// Select with In 

SELECT *
  FROM banktransaction
 WHERE banktransaction_type IN ('C', 'D');


-- /// Sub query 

SELECT * 
  FROM account
 WHERE account_in IN (SELECT account_id
                        FROM banktransaction
                       WHERE banktransaction_type = 'D')

SELECT return_client_name(account.account_id), account.account_id
  FROM account
 WHERE account_id NOT IN (SELECT account_id
                            FROM banktransaction)



-- DISTINCT

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Sand Stormtrooper','sandtrooper2@china.co' ,'981.982.24-15',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Sand Stormtrooper','sandtrooper9@china.co' ,'644.982.24-14',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Stormtrooper','trooper3@china.co' ,'123.151.742-02',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Stormtrooper','trooper4@china.co' ,'215.145.742-08',true, now(), now());


SELECT DISTINCT client_name
  FROM client;