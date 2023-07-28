  select venda_id,
         funcionario_id,
         venda_total
    from venda
   where venda_data_criacao >= 'data_ini'
     and venda_data_criacao <= 'data_fim'
     and venda_ativo = true


     ------------------------

INSERT INTO produto(produto_codigo,
                    produto_nome,
                    produto_valor,
                    produto_ativo,
                    produto_data_criacao,
                    produto_data_atualizacao)
             VALUES('2832',
                    'SUCO DE LIMÃO',
                    15,
                    false,
                    '02/02/2023',
                    '02/02/2023' );

SELECT * 
  FROM produto
 WHERE produto_ativo = true
   AND produto_ativo = false;                    

SELECT * 
  FROM produto
 WHERE produto_ativo = true
    OR produto_ativo = false;     

        SELECT * 
      FROM produto
 WHERE NOT produto_nome = 'SUCO DE LIMÃO';


  SELECT * 
    FROM produto
   WHERE produto_ativo = true
      OR (produto_ativo = false 
          AND produto_data_criacao = '02/02/2023');

SELECT venda_id,
       funcionario_id,
       venda_total
  FROM venda
 WHERE venda_data_criacao >= 'data_ini'
   AND venda_data_criacao <= 'data_fim'
   AND venda_ativo = falso;          

SELECT venda_id,
       funcionario_id,
       venda_total
  FROM venda
 WHERE venda_data_criacao >= '01/01/2023'
   AND venda_data_criacao <= '02/02/2023'
   AND venda_ativo = falso;          


SELECT funcionario_codigo || funcionario_nome 
  FROM funcionario
 WHERE funcionario_id = 'd44458ed-877d-4251-9a53-24ef06a248c5';   

SELECT CHAR_LENGTH(funcionario_nome)
  FROM funcionario
 WHERE funcionario_id = 'd44458ed-877d-4251-9a53-24ef06a248c5';   


SELECT UPPER(funcionario_nome)
  FROM funcionario;


SELECT UPPER('livro postgresql');

SELECT INITCAP('livro postgresql');

SELECT LOWER(funcionario_nome)
  FROM funcionario;


SELECT OVERLAY(funcionario_nome placing '000000' 
                           from 3 for 5) 
  FROM funcionario
 WHERE funcionario_id = 'd44458ed-877d-4251-9a53-24ef06a248c5';  

 SELECT SUBSTRING(funcionario_nome FROM 3 for 5)
   FROM funcionario
 WHERE funcionario_id = 'd44458ed-877d-4251-9a53-24ef06a248c5';  


  SELECT POSITION('CIUS' IN funcionario_nome) 
   FROM funcionario
  WHERE funcionario_id = 'd44458ed-877d-4251-9a53-24ef06a248c5';  

---------------------------------

INSERT INTO venda ( venda_id, 
                    funcionario_id,
                    mesa_id,
                    venda_codigo,
                    venda_valor,
                    venda_total,
                    venda_desconto,
                    venda_ativo,
                    venda_comissionado,
                    venda_data_criacao,
                    venda_data_atualizacao)
            VALUES (gen_random_uuid(),
                    'd44458ed-877d-4251-9a53-24ef06a248c5',
                    1,
                    '10201',
                    '51',
                    '51',
                    '0',
                    true,
                    false,
                    '01/01/2023',
                    '01/01/2023');
                        
INSERT INTO itens_venda(itens_venda_id,
                        produto_id,
                        venda_id,
                        itens_venda_valor,
                        itens_venda_quantidade,
                        itens_venda_total,
                        itens_venda_data_criacao,
                        itens_venda_data_atualizacao)
                VALUES (gen_random_uuid(),
                        'aac651ac-ab8b-410c-92e7-d45c701e5a22',
                        'f14abea0-d9e5-469e-9557-e52a5c79e151',
                        15,
                        2,
                        30,
                        '01/01/2023',
                        '01/01/2023');
                                     
INSERT INTO itens_venda(itens_venda_id,
                        produto_id,
                        venda_id,
                        itens_venda_valor,
                        itens_venda_quantidade,
                        itens_venda_total,
                        itens_venda_data_criacao,
                        itens_venda_data_atualizacao)
                VALUES (gen_random_uuid(),
                        '86b46f1e-5056-4562-bffc-85544cc6ea9b',
                        'f14abea0-d9e5-469e-9557-e52a5c79e151',
                        7,
                        3,
                        21,
                        '01/01/2023',
                        '01/01/2023');  

INSERT INTO venda ( venda_id, 
                    funcionario_id,
                    mesa_id,
                    venda_codigo,
                    venda_valor,
                    venda_total,
                    venda_desconto,
                    venda_ativo,
                    venda_comissionado,
                    venda_data_criacao,
                    venda_data_atualizacao)
            VALUES (gen_random_uuid(),
                    'd44458ed-877d-4251-9a53-24ef06a248c5',
                    1,
                    '10202',
                    '20',
                    '20',
                    '0',
                    true,
                    false,
                    '01/01/2023',
                    '01/01/2023');
                                
INSERT INTO itens_venda(itens_venda_id,
                        produto_id,
                        venda_id,
                        itens_venda_valor,
                        itens_venda_quantidade,
                        itens_venda_total,
                        itens_venda_data_criacao,
                        itens_venda_data_atualizacao)
                VALUES (gen_random_uuid(),
                        'e8f1f733-09ff-4992-9b60-e0321266b894',
                        '78ea20e5-a5ff-48a5-b6e2-5254cbf2653d',
                        10,
                        2,
                        20,
                        '01/01/2023',
                        '01/01/2023');  
                                     
INSERT INTO venda ( venda_id, 
                    funcionario_id,
                    mesa_id,
                    venda_codigo,
                    venda_valor,
                    venda_total,
                    venda_desconto,
                    venda_ativo,
                    venda_comissionado,
                    venda_data_criacao,
                    venda_data_atualizacao)
            VALUES (gen_random_uuid(),
                    'd44458ed-877d-4251-9a53-24ef06a248c5',
                    1,
                    '10002',
                    '45',
                    '45',
                    '0',
                    true,
                    false,
                    '01/01/2023',
                    '01/01/2023');
                                 
INSERT INTO itens_venda(itens_venda_id,
                        produto_id,
                        venda_id,
                        itens_venda_valor,
                        itens_venda_quantidade,
                        itens_venda_total,
                        itens_venda_data_criacao,
                        itens_venda_data_atualizacao)
                VALUES (gen_random_uuid(),
                        'aac651ac-ab8b-410c-92e7-d45c701e5a22',
                        '04187a8a-a1e3-4ae2-b869-23928f2de70e',
                        15,
                        3,
                        45,
                        '01/01/2023',
                        '01/01/2023');


INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                 VALUES(gen_random_uuid(),
                        '0100',
                        'VINICIUS SOUZA',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');


INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                 VALUES(gen_random_uuid(),
                        '0101',
                        'VINICIUS SOUZA MOLIN',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');


INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                  VALUES(gen_random_uuid(),
                        '0102',
                        'VINICIUS RANKEL C',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');


INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                 VALUES(gen_random_uuid(),
                        '0103',
                        'BATISTA SOUZA LUIZ',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');


INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                 VALUES(gen_random_uuid(),
                        '0104',
                        'ALBERTO SOUZA CARDOSO',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');

INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                 VALUES(gen_random_uuid(),
                        '0105',
                        'CARLOS GABRIEL ALMEIDA',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');


INSERT INTO FUNCIONARIO(funcionario_id,
                        funcionario_codigo,
                        funcionario_nome,
                        funcionario_ativo,
                        funcionario_comissao,
                        funcionario_cargo,
                        funcionario_data_criacao)
                 VALUES(gen_random_uuid(),
                        '0106',
                        'RENAN SIMOES SOUZA',
                        true,
                         2,
                        'GARÇOM',
                        '01/03/2023');


-------------------
SELECT funcionario_nome
  FROM funcionario
 WHERE funcionario_nome LIKE 'VINICIUS%';


SELECT funcionario_nome
  FROM funcionario
 WHERE funcionario_nome LIKE '%SOUZA%';