SELECT funcionario_nome
  FROM funcionario
 WHERE funcionario_id in (SELECT funcionario_id
                            FROM venda);


SELECT funcionario_nome
  FROM funcionario
 WHERE funcionario_id IN (SELECT funcionario_id
                            FROM venda
                           WHERE date_part('year', venda_data_criacao) = '2023');


SELECT DISTINCT funcionario_nome
           FROM funcionario
          WHERE funcionario_id IN (SELECT funcionario_id
                         FROM venda)
       ORDER BY funcionario_nome;

SELECT DISTINCT funcionario_nome
           FROM funcionario, venda
          WHERE funcionario.id = venda.funcionario_id
       ORDER BY funcionario_nome;

SELECT DISTINCT funcionario_nome
           FROM funcionario, venda
       ORDER BY funcionario_nome;

SELECT DISTINCT funcionario_nome 
           FROM funcionario 
     INNER JOIN venda 
             ON (funcionario.funcionario_id = venda.funcionario_id)
       ORDER BY funcionario_nome;

SELECT DISTINCT funcionario_nome
           FROM funcionario
           JOIN venda
             ON (funcionario.funcionario_id = venda.funcionario_id)
       ORDER BY funcionario_nome;   


   SELECT funcionario_nome, v.venda_id
     FROM funcionario f
LEFT JOIN venda v
       ON f.funcionario_id = v.funcionario_id
 ORDER BY funcionario_nome DESC;

    SELECT v.venda_id, v.venda_total, funcionario_nome
      FROM venda v
RIGHT JOIN funcionario f
        ON v.funcionario_id = f.funcionario_id
  ORDER BY v.venda_total;


CREATE OR REPLACE VIEW venda_do_dia AS
  SELECT DISTINCT produto_nome
        , SUM(venda.venda_total)
    FROM produto, itens_venda, venda
   WHERE produto.produto_id = itens_venda.produto_id
     AND venda.venda_id   = itens_venda.venda_id
     AND venda.venda_data_criacao = '01/01/2016'
GROUP BY produto_nome;

CREATE OR REPLACE VIEW produto_venda as
      SELECT produto.produto_id PRODUTO_ID
            , produto.produto_nome PRODUTO_NOME
            , venda.venda_id VENDA_ID
            , itens_venda.itens_venda_id ITEM_ID
            , itens_venda.itens_venda_valor ITEM_VALOR
            , venda.venda_data_criacao DATA_CRIACAO
        FROM produto, venda, itens_venda
       WHERE venda.venda_id   = itens_venda.venda_id
         AND produto.produto_id = itens_venda.produto_id
    ORDER BY data_criacao DESC;



SELECT *
  FROM produto_venda;

SELECT produto_nome
  FROM produto_venda
 WHERE data_criacao = '01/01/2023';    


CREATE OR REPLACE VIEW produtos_estoque AS
           SELECT * FROM produto;