CREATE OR REPLACE FUNCTION
retorna_nome_funcionario(func_id uuid)
RETURNS TEXT AS
$$
    DECLARE
        nome  TEXT;
        ativo BOOLEAN;
        BEGIN
                SELECT funcionario_nome,
                       funcionario_ativo
                  INTO nome, ativo
                  FROM funcionario
                 WHERE funcionario_id = func_id;

                    IF ativo = true THEN
                        RETURN nome || ' - Funcionario Ativo';
                    ELSE
                        RETURN nome || ' - Funcionario Inativo';
                    END IF;
        END
$$
LANGUAGE PLPGSQL;



-------------

CREATE OR REPLACE FUNCTION 
rt_valor_comissao(func_id UUID)
RETURNS DOUBLE PRECISION AS 
$$
DECLARE             
    valor_comissao DOUBLE PRECISION;
BEGIN              
    SELECT funcionario_comissao
      INTO valor_comissao
      FROM funcionario
     WHERE funcionario_id = func_id;    

    RETURN valor_comissao;
END
$$
LANGUAGE PLPGSQL;


----------------------------------------
----------------------------------------

CREATE OR REPLACE FUNCTION 
calc_comissao(data_ini TIMESTAMP,
              data_fim TIMESTAMP)
RETURNS VOID AS $$
DECLARE 

-- declaração das variáveis que vamos
-- utilizar. Já na declaração elas
-- recebem o valor zero. Pois assim
-- garanto que elas estarão zeradas
-- quando for utilizá-las.

    total_comissao  DOUBLE PRECISION := 0;
    porc_comissao   DOUBLE PRECISION := 0;

-- declarando uma variável para armazenar 
-- os registros dos loops
    reg RECORD;

--cursor para buscar a % de comissão do funcionário

    cr_porce CURSOR (func_id UUID) IS 
        SELECT rt_valor_comissao(func_id);

BEGIN

-- realiza um loop e busca todas as vendas
--  no período informado

    FOR reg IN( 
         SELECT venda_id,
                funcionario_id,
                venda_total
           FROM venda
          WHERE venda_data_criacao  >= data_ini
            AND venda_data_criacao <= data_fim 
            AND venda_comissionado = false)LOOP         

-- abertura, utilização e fechamento do cursor

        OPEN cr_porce(reg.funcionario_id);
        FETCH cr_porce INTO porc_comissao;
        CLOSE cr_porce;
    
                
        total_comissao := (reg.venda_total * 
                           porc_comissao)/100;
    
-- insere na tabela de comissões o valor 
-- que o funcionário irá receber de comissão
-- daquela venda

        INSERT INTO comissao( comissao_id,
                              funcionario_id,
                              comissao_valor,
                              comissao_ativo,
                              comissao_data_criacao,
                              comissao_data_atualizacao ) 
            VALUES( gen_random_uuid(),
                    reg.funcionario_id,
                    total_comissao,
                    true,
                    NOW(),
                    NOW() );

-- update no campo venda comissionado 
-- para que ela não seja mais comissionada

        UPDATE venda SET venda_comissionado = true
        WHERE venda_id = reg.venda_id;

-- devemos zerar as variáveis para reutilizá-las

        total_comissao := 0;
        porc_comissao  := 0;
    
-- término do loop

END LOOP;                                    

END
$$ LANGUAGE PLPGSQL;