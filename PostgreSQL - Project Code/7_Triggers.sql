--------------------------------------------------------------------------
-- /// Triggers 

CREATE TABLE log_transaction (
    log_transaction_id             int not null primary key,
    log_transaction_updated_at     timestamp,
    log_transaction_change         varchar(10),
    log_transaction_id_old         uuid,
    log_transaction_account_id_old uuid,
    log_transaction_type_old       varchar(1),
    log_transaction_value_old      double precision,
    log_transaction_created_at_old timestamp,
    log_transaction_updated_at_old timestamp,
    log_transaction_id_new         uuid,
    log_transaction_account_id_new uuid,
    log_transaction_type_new       varchar(1),
    log_transaction_value_new      double precision,
    log_transaction_created_at_new timestamp,
    log_transaction_updated_at_new timestamp
);

CREATE SEQUENCE log_transaction_id_seq;

ALTER TABLE log_transaction
    ALTER column log_transaction_id SET DEFAULT 
    NEXTVAL('log_transaction_id_seq');


CREATE OR REPLACE FUNCTION generate_log_transaction()
RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
    
        INSERT INTO log_transaction(
                    log_transaction_updated_at,
                    log_transaction_change,
                    log_transaction_id_new,
                    log_transaction_account_id_new,
                    log_transaction_type_new,
                    log_transaction_value_new,
                    log_transaction_created_at_new,
                    log_transaction_updated_at_new
        )
        VALUES(
                    now(),
                    TG_OP,
                    new.banktransaction_id,
                    new.account_id,
                    new.banktransaction_type,
                    new.banktransaction_value,
                    new.banktransaction_created_at,
                    new.banktransaction_updated_at
        );

        RETURN NEW;
    
    ELSEIF TG_OP = 'UPDATE' THEN
        
        INSERT INTO log_transaction(
                    log_transaction_updated_at,
                    log_transaction_change,
                    log_transaction_id_old,
                    log_transaction_account_id_old,
                    log_transaction_type_old,
                    log_transaction_value_old,
                    log_transaction_created_at_old,
                    log_transaction_updated_at_old,
                    log_transaction_id_new,
                    log_transaction_account_id_new,
                    log_transaction_type_new,
                    log_transaction_value_new,
                    log_transaction_created_at_new,
                    log_transaction_updated_at_new
        )
        VALUES(
                    now(),
                    TG_OP,
                    old.banktransaction_id,
                    old.account_id,
                    old.banktransaction_type,
                    old.banktransaction_value,
                    old.banktransaction_created_at,
                    old.banktransaction_updated_at,
                    new.banktransaction_id,
                    new.account_id,
                    new.banktransaction_type,
                    new.banktransaction_value,
                    new.banktransaction_created_at,
                    new.banktransaction_updated_at
        );
        RETURN NEW;

    ELSEIF TG_OP = 'DELETE' THEN

        INSERT INTO log_transaction(
                    log_transaction_updated_at,
                    log_transaction_change,
                    log_transaction_id_old,
                    log_transaction_account_id_old,
                    log_transaction_type_old,
                    log_transaction_value_old,
                    log_transaction_created_at_old,
                    log_transaction_updated_at_old
        )
        VALUES(
                    now(),
                    TG_OP,
                    old.banktransaction_id,
                    old.account_id,
                    old.banktransaction_type,
                    old.banktransaction_value,
                    old.banktransaction_created_at,
                    old.banktransaction_updated_at
        );
        RETURN NEW;

    END IF;

END; 
$$ 
LANGUAGE PLPGSQL;


CREATE OR REPLACE TRIGGER tri_log_transaction
    AFTER INSERT OR UPDATE OR DELETE ON banktransaction
    FOR EACH ROW EXECUTE 
    PROCEDURE generate_log_transaction();


ALTER TABLE banktransaction
    DISABLE TRIGGER tri_log_transaction;

ALTER TABLE banktransaction
    ENABLE TRIGGER tri_log_transaction;



--- YODA
insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'dbb50508-c53f-4748-9a5f-ea57c3aed322',  111111, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'dbb50508-c53f-4748-9a5f-ea57c3aed322' , 222222, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'dbb50508-c53f-4748-9a5f-ea57c3aed322', 33333, 'D', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'dbb50508-c53f-4748-9a5f-ea57c3aed322', 44444, 'D', '01/01/2022', '01/01/2022');


SELECT *
  FROM banktransaction
 WHERE account_id = 'f580509c-8341-49ba-92f6-369f126468cb';

UPDATE banktransaction SET banktransaction_value = 9749
 WHERE banktransaction_id = 'ebbd9405-3a0d-4b54-9970-bc736bf2fe26';

--- /// Delete 

DELETE FROM banktransaction 
 WHERE banktransaction_id = 'ebbd9405-3a0d-4b54-9970-bc736bf2fe26';

SELECT *
  FROM log_transaction;
