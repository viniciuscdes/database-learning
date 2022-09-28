
-- /// A function to return the client's name from a account id

-- function with return
CREATE OR REPLACE FUNCTION return_client_name(var_account_id uuid)
RETURNS TEXT AS 
$$
DECLARE
    var_name_client TEXT;
    
    BEGIN
        SELECT client.client_name
          INTO var_name_client
          FROM client
    INNER JOIN account ON client.client_id = account.client_id
         WHERE account_id =  var_account_id;

        RETURN var_name_client;
    END
$$
LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION return_total_debit(var_account_id uuid)
RETURNS DOUBLE PRECISION AS 
$$
DECLARE
    var_total_debit TEXT;
    
    BEGIN
        SELECT SUM(banktransaction_value)
          INTO var_total_debit
          FROM banktransaction
         WHERE account_id = var_account_id
           AND banktransaction_type =  'D';

        RETURN var_total_debit;
    END
$$
LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION return_total_credit(var_account_id uuid)
RETURNS DOUBLE PRECISION AS 
$$
DECLARE
    var_total_credit TEXT;
    
    BEGIN
        SELECT SUM(banktransaction_value)
          INTO var_total_credit
          FROM banktransaction
         WHERE account_id = var_account_id
           AND banktransaction_type =  'C';

        RETURN var_total_credit;
    END
$$
LANGUAGE PLPGSQL;

-- function without return
CREATE OR REPLACE FUNCTION func_update_balance()
RETURNS VOID AS
$$
DECLARE
    total_balance  double precision := 0;
    total_debit    double precision := 0;
    total_credit  double precision := 0;

    reg            record;

    cr_client_debit CURSOR(accountid uuid) IS
        SELECT return_total_debit(accountid);

    cr_client_credit CURSOR(accountid uuid) IS
        SELECT return_total_credit(accountid);        

    BEGIN
        FOR reg IN(
                    SELECT account.account_id, account.client_id
                      FROM account
                INNER JOIN client ON client.client_id = account.client_id
                     WHERE client.client_active = true
        )LOOP

            OPEN cr_client_debit(reg.account_id);
            FETCH cr_client_debit INTO total_debit;
            CLOSE cr_client_debit;
            
            OPEN cr_client_credit(reg.account_id);
            FETCH cr_client_credit INTO total_credit;
            CLOSE cr_client_credit;

            total_balance := total_credit - total_debit;

            UPDATE account SET account_balance = total_balance
             WHERE account_id = reg.account_id;

            total_balance := 0;
            total_credit  := 0;
            total_debit   := 0;

        END LOOP;
    END 
$$
LANGUAGE PLPGSQL;   

SELECT func_update_balance();

SELECT * FROM account;

   SELECT account_id, banktransaction_type, sum(banktransaction_value)
     FROM banktransaction
    WHERE account_id = 'dbb50508-c53f-4748-9a5f-ea57c3aed322'
 GROUP BY account_id, banktransaction_type;

DROP FUNCTION func_update_balance();

-- Using the function

SELECT return_client_name('f580509c-8341-49ba-92f6-369f126468cb');

    SELECT return_client_name(ac.account_id) as "Client Name", 
           COUNT(bt.banktransaction_id), SUM(bt.banktransaction_value)
      FROM account ac 
INNER JOIN banktransaction bt
        ON bt.account_id = ac.account_id
  GROUP BY "Client Name", ac.account_id;