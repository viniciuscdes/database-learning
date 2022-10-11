-- DROP TABLE IF EXISTS logs_produtos;

CREATE TABLE IF NOT EXISTS log_produto(
    log_produto_id             int NOT NULL PRIMARY KEY,
    log_produto_data_alteracao timestamp,
    log_produto_alteracao      varchar(10),
    produto_id_old             int,
    produto_codigo_old         varchar(20),
    produto_nome_old           varchar(60),
    produto_valor_old          double precision,
    produto_ativo_old          boolean,
    produto_data_criacao_old   timestamp,
    produto_data_alteracao_old timestamp,
    produto_id_new             int,
    produto_codigo_new         varchar(20),
    produto_nome_new           varchar(60),
    produto_valor_new          double precision,
    produto_ativo_new          boolean,
    produto_data_criacao_new   timestamp,
    produto_data_alteracao_new timestamp);

CREATE SEQUENCE log_produto_id_seq;

alter table log_produto
alter column log_produto_id set default
nextval('log_produto_id_seq');

CREATE OR REPLACE FUNCTION gera_log_produto()
RETURNS TRIGGERS AS
$$
BEGIN

    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_produto (
            log_produto_data_alteracao,
            log_produto_alteracao,
            produto_id_new,
            produto_codigo_new,
            produto_nome_new,
            produto_ativo_new,
            produto_data_criacao_new,
            produto_data_alteracao_new)
        VALUES(
            NOW(),
            TG_OP,
            NEW.produto_id,
            NEW.produto_codigo,
            NEW.produto_nome,
            NEW.produto_valor,
            NEW.produto_ativo,
            NEW.produto_data_criacao,
            NEW.produto_data_alteracao);
        
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN

        INSERT INTO log_produto(
            log_produto_data_alteracao,
            log_produto_alteracao,
            produto_id_old,
            produto_codigo_old,
            produto_nome_old,
            produto_ativo_old,
            produto_data_criacao_old,
            produto_data_alteracao_old,
            produto_id_new,
            produto_codigo_new,
            produto_nome_new,
            produto_ativo_new,
            produto_data_criacao_new,
            produto_data_alteracao_new)
        VALUES(
            NOW(),
            TG_OP,
            OLD.produto_id,            
            OLD.produto_codigo,
            OLD.produto_nome,
            OLD.produto_valor,
            OLD.produto_ativo,
            OLD.produto_data_criacao,
            OLD.produto_data_alteracao,
            NEW.produto_id,
            NEW.produto_codigo,
            NEW.produto_nome,
            NEW.produto_valor,
            NEW.produto_ativo,
            NEW.produto_data_criacao,
            NEW.produto_data_alteracao);                

        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_produto (
            log_produto_data_alteracao,
            log_produto_alteracao,
            produto_id_new,
            produto_codigo_new,
            produto_nome_new,
            produto_ativo_new,
            produto_data_criacao_new,
            produto_data_alteracao_new)
        VALUES(
            NOW(),
            TG_OP,
            OLD.produto_id,
            OLD.produto_codigo,
            OLD.produto_nome,
            OLD.produto_valor,
            OLD.produto_ativo,
            OLD.produto_data_criacao,
            OLD.produto_data_alteracao);
        
        RETURN NEW;
    END IF;
END;
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER tri_log_produto
AFTER INSERT OR UPDATE OR DELETE ON produto
FOR EACH ROW EXECUTE
PROCEDURE gera_log_produto();


INSERT INTO PRODUTO ()
             VALUES (gen_random_uuid(),
                     '1512',
                     'LAZANHA',
                     46,
                     true,
                     '01/01/2023',
                     '01/01/2023');

INSERT INTO PRODUTO ()
             VALUES (gen_random_uuid(),
                     '1613',
                     'PANQUECA',
                     38,
                     true,
                     '01/01/2023',
                     '01/01/2023');

INSERT INTO PRODUTO ()
             VALUES (gen_random_uuid(),
                     '733',
                     'CHURRASCO',
                     72,
                     true,
                     '01/01/2023',
                     '01/01/2023');