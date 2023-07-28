-- DROP TABLE IF EXISTS public.mesa;

CREATE TABLE IF NOT EXISTS public.mesa
(
    mesa_id integer NOT NULL,
    mesa_codigo character varying(20) COLLATE pg_catalog."default",
    mesa_ativo boolean DEFAULT true,
    mesa_data_criacao timestamp without time zone,
    mesa_data_atualizacao timestamp without time zone,
    CONSTRAINT mesa_pkey PRIMARY KEY (mesa_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.mesa
    OWNER to postgres;


-- DROP TABLE IF EXISTS public.funcionario;

CREATE TABLE IF NOT EXISTS public.funcionario
(
    funcionario_id uuid NOT NULL,
    funcionario_codigo character varying(20) COLLATE pg_catalog."default",
    funcionario_nome character varying(100) COLLATE pg_catalog."default",
    funcionario_ativo boolean DEFAULT true,
    funcionario_comissao double precision,
    funcionario_cargo character varying(30) COLLATE pg_catalog."default",
    funcionario_data_criacao timestamp without time zone,
    funcionario_data_atualizacao timestamp without time zone,
    CONSTRAINT funcionario_pkey PRIMARY KEY (funcionario_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.funcionario
    OWNER to postgres;



-- DROP TABLE IF EXISTS public.venda;

CREATE TABLE IF NOT EXISTS public.venda
(
    venda_id uuid NOT NULL,
    venda_codigo character varying(20) COLLATE pg_catalog."default",
    venda_valor double precision,
    venda_total double precision,
    venda_desconto double precision,
    venda_ativo boolean DEFAULT true,
    venda_comissionado boolean DEFAULT false,
    venda_data_criacao timestamp without time zone,
    venda_data_atualizacao timestamp without time zone,
    funcionario_id uuid,
    mesa_id integer,
    CONSTRAINT venda_pk PRIMARY KEY (venda_id),
    CONSTRAINT venda_funcionario_fk FOREIGN KEY (funcionario_id)
        REFERENCES public.funcionario (funcionario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT venda_mesa_fk FOREIGN KEY (mesa_id)
        REFERENCES public.mesa (mesa_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.venda
    OWNER to postgres;


-- DROP TABLE IF EXISTS public.produto;

CREATE TABLE IF NOT EXISTS public.produto
(
    produto_id uuid NOT NULL,
    produto_codigo character varying(20) COLLATE pg_catalog."default",
    produto_nome character varying(60) COLLATE pg_catalog."default",
    produto_valor double precision,
    produto_ativo boolean NOT NULL DEFAULT true,
    produto_data_criacao timestamp without time zone,
    produto_data_atualizacao timestamp without time zone,
    CONSTRAINT produto_pkey PRIMARY KEY (produto_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.produto
    OWNER to postgres;



-- DROP TABLE IF EXISTS public.itens_venda;

CREATE TABLE IF NOT EXISTS public.itens_venda
(
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
        REFERENCES public.produto (produto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT itens_venda_venda_fk FOREIGN KEY (venda_id)
        REFERENCES public.venda (venda_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.itens_venda
    OWNER to postgres;


-- DROP TABLE IF EXISTS public.comissao;

CREATE TABLE IF NOT EXISTS public.comissao
(
    comissao_id uuid NOT NULL,
    funcionario_id uuid,
    comissao_valor double precision,
    comissao_ativo boolean DEFAULT true,
    comissao_data_criacao timestamp without time zone,
    comissao_data_atualizacao timestamp without time zone,
    CONSTRAINT comissao_pk PRIMARY KEY (comissao_id),
    CONSTRAINT comissa_funcionario_fk FOREIGN KEY (funcionario_id)
        REFERENCES public.funcionario (funcionario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.comissao
    OWNER to postgres;