-- DROP TABLE IF EXISTS logs_produtos;

CREATE TABLE IF NOT EXISTS log_produto(
    log_produto_id             INT NOT NULL PRIMARY KEY,
    log_produto_data_alteracao TIMESTAMP,
    log_produto_alteracao      VARCHAR(10),
    produto_id_old             UUID,
    produto_codigo_old         VARCHAR(20),
    produto_nome_old           VARCHAR(60),
    produto_valor_old          DOUBLE PRECISION,
    produto_ativo_old          BOOLEAN,
    produto_data_criacao_old   TIMESTAMP,
    produto_data_alteracao_old TIMESTAMP,
    produto_id_new             UUID,
    produto_codigo_new         VARCHAR(20),
    produto_nome_new           VARCHAR(60),
    produto_valor_new          DOUBLE PRECISION,
    produto_ativo_new          BOOLEAN,
    produto_data_criacao_new   TIMESTAMP,
    produto_data_alteracao_new TIMESTAMP);

CREATE SEQUENCE log_produto_id_seq;

ALTER TABLE log_produto
      ALTER COLUMN log_produto_id SET DEFAULT
            nextval('log_produto_id_seq');



CREATE OR REPLACE FUNCTION gera_log_produto()
RETURNS TRIGGER AS
$$
BEGIN

    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_produto (
            log_produto_data_alteracao,
            log_produto_alteracao,
            produto_id_new,
            produto_codigo_new,
            produto_nome_new,
            produto_valor_new,
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
            NEW.produto_data_atualizacao);
        
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN

        INSERT INTO log_produto(
            log_produto_data_alteracao,
            log_produto_alteracao,
            produto_id_old,
            produto_codigo_old,
            produto_nome_old,
            produto_valor_old,
            produto_ativo_old,
            produto_data_criacao_old,
            produto_data_alteracao_old,
            produto_id_new,
            produto_codigo_new,
            produto_nome_new,
            produto_valor_new,
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
            OLD.produto_data_atualizacao,
            NEW.produto_id,
            NEW.produto_codigo,
            NEW.produto_nome,
            NEW.produto_valor,
            NEW.produto_ativo,
            NEW.produto_data_criacao,
            NEW.produto_data_atualizacao);                

        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_produto (
            log_produto_data_alteracao,
            log_produto_alteracao,
            produto_id_new,
            produto_codigo_new,
            produto_nome_new,
            produto_valor_new,
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
            OLD.produto_data_atualizacao);
        
        RETURN NEW;
    END IF;
END;
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER tri_log_produto
AFTER INSERT OR UPDATE OR DELETE ON produto
FOR EACH ROW EXECUTE
PROCEDURE gera_log_produto();


INSERT INTO produto 
     VALUES (gen_random_uuid(),
            '1512',
            'LAZANHA',
            46,
            true,
            '01/01/2023',
            '01/01/2023');

INSERT INTO produto 
     VALUES (gen_random_uuid(),
            '1613',
            'PANQUECA',
            38,
            true,
            '01/01/2023',
            '01/01/2023');

INSERT INTO produto 
     VALUES (gen_random_uuid(),
            '733',
            'CHURRASCO',
            72,
            true,
            '01/01/2023',
            '01/01/2023');


  SELECT  log_produto_alteracao
        ,log_produto_data_alteracao
        ,produto_id_new
        ,produto_codigo_new   
        ,produto_nome_new     
        ,produto_valor_new    
        ,produto_ativo_new 
        ,produto_data_criacao_new     
        ,produto_data_alteracao_new 
    FROM log_produto; 


UPDATE produto SET produto_valor = 99
 WHERE produto_nome = 'CHURRASCO';


SELECT * 
  FROM log_produto;

DELETE FROM produtos WHERE produto_nome = 'PANQUECA';

ALTER TABLE produto
    DISABLE trigger tri_log_produtos;


INSERT INTO produto(produto_id,
                    produto_codigo,
                    produto_nome,
                    produto_valor,
                    produto_ativo,
                    data_criacao,
                    data_atualizacao)
            VALUES (gen_random_uuid(),
                    '912',
                    'SORVETE',
                    6,
                    true,
                    '01/01/2023',
                    '01/01/2023');

ALTER TABLE produto 
     ENABLE trigger tri_log_produto;

UPDATE produto SET produto_valor = 10
 WHERE produto_nome = 'SORVETE';

DROP TRIGGER tri_log_produto ON produto;


