-- DROP TABLE IF EXISTS mesa;

CREATE TABLE IF NOT EXISTS mesa(
    mesa_id integer NOT NULL,
    mesa_codigo varchar(20),
    mesa_ativo boolean DEFAULT true,
    mesa_data_criacao timestamp without time zone,
    mesa_data_atualizacao timestamp without time zone,
    CONSTRAINT mesa_pkey PRIMARY KEY (mesa_id));

-- DROP TABLE IF EXISTS funcionario;

CREATE TABLE IF NOT EXISTS funcionario(
    funcionario_id uuid NOT NULL DEFAULT gen_random_uuid(),
    funcionario_codigo varchar(20),
    funcionario_nome varchar(100),
    funcionario_ativo boolean DEFAULT true,
    funcionario_comissao double precision,
    funcionario_cargo varchar(30),
    funcionario_data_criacao timestamp without time zone,
    funcionario_data_atualizacao timestamp without time zone,
    CONSTRAINT funcionario_pkey PRIMARY KEY (funcionario_id));


-- DROP TABLE IF EXISTS venda;

CREATE TABLE IF NOT EXISTS venda(
    venda_id uuid NOT NULL,
    venda_codigo varchar(20),
    venda_valor double precision,
    venda_total double precision,
    venda_desconto double precision,
    venda_ativo boolean DEFAULT true,
    venda_comissionado BOOLEAN DEFAULT false,
    venda_data_criacao timestamp without time zone,
    venda_data_atualizacao timestamp without time zone,
    funcionario_id uuid,
    mesa_id integer,
    CONSTRAINT venda_pk PRIMARY KEY (venda_id),
    CONSTRAINT venda_funcionario_fk FOREIGN KEY (funcionario_id)
        REFERENCES funcionario (funcionario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT venda_mesa_fk FOREIGN KEY (mesa_id)
        REFERENCES mesa (mesa_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID);


-- DROP TABLE IF EXISTS produto;

CREATE TABLE IF NOT EXISTS produto(
    produto_id uuid NOT NULL,
    produto_codigo varchar(20),
    produto_nome varchar(60),
    produto_valor double precision,
    produto_ativo boolean NOT NULL DEFAULT true,
    produto_data_criacao timestamp without time zone,
    produto_data_atualizacao timestamp without time zone,
    CONSTRAINT produto_pkey PRIMARY KEY (produto_id));


-- DROP TABLE IF EXISTS itens_venda;

CREATE TABLE IF NOT EXISTS itens_venda(
    itens_venda_id uuid NOT NULL,
    produto_id uuid,
    venda_id uuid,
    itens_venda_valor double precision,
    itens_venda_quantidade integer,
    itens_venda_total double precision,
    itens_venda_data_criacao timestamp without time zone,
    itens_venda_data_atualizacao timestamp without time zone,
    CONSTRAINT itens_venda_pk PRIMARY KEY (itens_venda_id),
    CONSTRAINT itens_venda_produto_fk FOREIGN KEY (produto_id)
        REFERENCES produto (produto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT itens_venda_venda_fk FOREIGN KEY (venda_id)
        REFERENCES venda (venda_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION);


-- DROP TABLE IF EXISTS comissao;

CREATE TABLE IF NOT EXISTS comissao(
    comissao_id uuid NOT NULL,
    funcionario_id uuid,
    comissao_valor double precision,
    comissao_ativo boolean DEFAULT true,
    comissao_data_criacao timestamp without time zone,
    comissao_data_atualizacao timestamp without time zone,
    CONSTRAINT comissao_pk PRIMARY KEY (comissao_id),
    CONSTRAINT comissa_funcionario_fk FOREIGN KEY (funcionario_id)
        REFERENCES funcionario (funcionario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION);

-- DROP TABLE IF EXISTS comissao;

CREATE TABLE IF NOT EXISTS comissao(
    comissao_id uuid NOT NULL,
    funcionario_id uuid,
    comissao_valor double precision,
    comissao_ativo boolean DEFAULT true,
    comissao_data_criacao timestamp without time zone,
    comissao_data_atualizacao timestamp without time zone);

    alter table comissao
	add constraint comissao_pk primary key (comissao_id);
    
    alter table comissao
    add constraint comissa_funcionario_fk FOREIGN KEY (funcionario_id)
        REFERENCES funcionario (funcionario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

    alter table comissao
    drop constraint comissa_funcionario_fk;

    alter table funcionario
    add check( funcionario_nome <> null);

    alter table venda 
    add check (venda_total > 0);

create sequence mesa_id_seq;
alter table mesa
alter column mesa_id set default nextval('mesa_id_seq');

-- Inserindo dados na tabela mesa

insert into mesa (mesa_codigo,
                  mesa_ativo,
                  mesa_data_criacao,
                  mesa_data_atualizacao)
           values('00001',
                  true,
                  '01/01/2023',
                  '01/01/2023');

insert into mesa (mesa_codigo,
                  mesa_ativo,
                  mesa_data_criacao,
                  mesa_data_atualizacao)
           values('00002',
                  true,
                  '01/01/2023',
                  '01/01/2023');

-- Inserindo dados na tabela funcionario 

insert into funcionario(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao,
                        funcionario_data_atualizacao)
                 values(
                        gen_random_uuid(),
                        '0001',
                        'VINICIUS CARVALHO',
                        true,
                        5,
                        'GERENTE',
                        '01/01/2023',
                         '01/01/2023');

insert into funcionario(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao,
                        funcionario_data_atualizacao)
                 values(
                        gen_random_uuid(),
                        '0002',
                        'SOUZA',
                        true,
                        2,
                        'GARÇOM',
                        '01/01/2023',
                        '01/01/2023');

-- Inserindo dados na tabela produto 

insert into produto(produto_codigo,
                    produto_nome,
                    produto_valor,
                    produto_ativo,
                    produto_data_criacao,
                    produto_data_atualizacao)
             values('001',
                    'REFRIGERANTE',
                    10,
                    true,
                    '01/01/2023',
                    '01/01/2023');

insert into produto(produto_codigo,
                    produto_nome,
                    produto_valor,
                    produto_ativo,
                    produto_data_criacao,
                    produto_data_atualizacao)
             values('002',
                    'AGUA',
                    3,
                    true,
                    '01/01/2023',
                    '01/01/2023');

insert into produto(produto_codigo,
                    produto_nome,
                    produto_valor,
                    produto_ativo,
                    produto_data_criacao,
                    produto_data_atualizacao)
             values('003',
                    'PASTEL',
                    7,
                    true,
                    '01/01/2023',
                    '01/01/2023');

-- Inserindo dados na tabela venda 

insert into venda(venda_id,
                  venda_codigo,
                  venda_valor,
                  venda_total,
                  venda_desconto,
                  venda_ativo,
                  venda_comissionado,
                  venda_data_criacao,
                  venda_data_atualizacao,
                  funcionario_id,
                  mesa_id)
           values(gen_random_uuid(),
                  '0001',
                  '20',
                  '20',
                  '0',
                  true,
                  false,
                  '01/01/2023',
                  '01/01/2023',
                  
                  1);                  

insert into venda()
           values(gen_random_uuid(),
                  '0001',
                  '20',
                  '20',
                  '0',
                  true,
                  false,
                  '01/01/2023',
                  '01/01/2023',
                  
                  1);  

-- Inserindo dados na tabela itens_venda 
insert into itens_venda(itens_venda_id,
                        produto_id,
                        venda_id,
                        itens_venda_valor,
                        itens_venda_quantidade,
                        itens_venda_total,
                        itens_venda_data_criacao,
                        itens_venda_data_atualizacao)
                 values(gen_random_uuid(),
                        'e8f1f733-09ff-4992-9b60-e0321266b894',
                        'fa9010d8-ef7e-4191-bb4b-7e8d4ac501cd',
                        10,
                        2,
                        20,
                        '01/01/2023',
                        '01/01/2023');

-- Utilizando o produto AGUA e segunda venda

insert into itens_venda(itens_venda_id,
                        produto_id,
                        venda_id,
                        itens_venda_valor,
                        itens_venda_quantidade,
                        itens_venda_total,
                        itens_venda_data_criacao,
                        itens_venda_data_atualizacao)
                 values(gen_random_uuid(),
                        '86b46f1e-5056-4562-bffc-85544cc6ea9b',
                        'da80d450-235a-4c02-af3b-e3adc43cd14f',
                        7,
                        3,
                        21,
                        '01/01/2023',
                        '01/01/2023');

  SELECT produto_id , SUM(itens_venda_total)
    FROM itens_venda
GROUP BY produto_id;


CREATE OR REPLACE FUNCTION 
retorna_nome_produto(prod_id UUID) 
RETURNS TEXT AS 
$$              
    DECLARE 
    nome     TEXT;   
BEGIN
    SELECT produto_nome                     
      INTO nome
      FROM produto
     WHERE produto_id = prod_id;                
        
    RETURN nome;
END
$$ 
LANGUAGE PLPGSQL;


  SELECT retorna_nome_produto(produto_id) , sum(itens_venda_total)
    FROM itens_venda
GROUP BY produto_id;


  SELECT retorna_nome_produto(produto_id) PRODUTO, 
         sum(itens_venda_total) VL_TOTAL_PRODUTO
    FROM itens_venda
GROUP BY produto_id
ORDER BY vl_total_produto, produto;


  SELECT retorna_nome_produto(produto_id) PRODUTO, 
         sum(itens_venda_total) VL_TOTAL_PRODUTO
    FROM itens_venda
GROUP BY produto_id
ORDER BY vl_total_produto DESC, produto;


  SELECT retorna_nome_produto(produto_id), 
         COUNT(itens_venda_id) QTDE
    FROM itens_venda
GROUP BY produto_id;


  SELECT retorna_nome_produto(produto_id) produto, 
         COUNT(itens_venda_id) qtde
    FROM itens_venda
GROUP BY produto_id
  HAVING COUNT(produto_id) >= 2
ORDER BY qtde;



---------------- 