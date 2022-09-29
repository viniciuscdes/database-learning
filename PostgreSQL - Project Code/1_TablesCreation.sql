-- ///  Tables Creation

-- Client
--------- without constraints 
CREATE TABLE IF NOT EXISTS client2(
    client_id uuid      NOT NULL,
    client_name         varchar(255) NOT NULL,
    client_email        varchar(255) NOT NULL,
    client_cpf          varchar(30) NOT NULL,
    client_active       boolean default true,
    client_created_at   timestamp,
    client_updated_at   timestamp
);

ALTER TABLE client ADD CONSTRAINT client_pkey primary key(client_id); 
ALTER TABLE client ADD CONSTRAINT client_cpf_unique UNIQUE (client_cpf);
ALTER TABLE client ADD CONSTRAINT client_email_unique UNIQUE (client_email);
-----------------------------------------------------------------------------

--------- with constraints 
CREATE TABLE IF NOT EXISTS client(
    client_id uuid      NOT NULL,
    client_name         varchar(255) NOT NULL,
    client_email        varchar(255) NOT NULL,
    client_cpf          varchar(30) NOT NULL,
    client_active       boolean default true,
    client_created_at   timestamp,
    client_updated_at   timestamp,
    CONSTRAINT client_pkey PRIMARY KEY (client_id),
    CONSTRAINT client_cpf_unique UNIQUE (client_cpf),
    CONSTRAINT client_email_unique UNIQUE(client_email)
);

-- Account
--------- without constraints 
CREATE TABLE IF NOT EXISTS account(
    account_id uuid        NOT NULL,
    client_id uuid         NOT NULL,
    account_active         boolean default true,
    account_agency_number  varchar(15) NOT NULL,
    account_number         varchar(15) NOT NULL,
    account_balance        double precision default 0,
    account_date_opening   timestamp,
    account_created_at     timestamp,
    account_updated_at     timestamp
);

ALTER TABLE account ADD CONSTRAINT account_pkey primary key(account_id); 
ALTER TABLE account ADD CONSTRAINT account_number_unique UNIQUE (account_number);
ALTER TABLE account ADD CONSTRAINT account_client_unique UNIQUE (client_id);
ALTER TABLE account ADD CONSTRAINT account_fk_client_id FOREIGN KEY (client_id)
        REFERENCES client (client_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;

-----------------------------------------------------------------------------
--------- with constraints 
CREATE TABLE IF NOT EXISTS account(
    account_id uuid        NOT NULL,
    client_id uuid         NOT NULL,
    account_active         boolean default true,
    account_agency_number  varchar(15) NOT NULL,
    account_number         varchar(15) NOT NULL,
    account_balance        double precision default 0,
    account_date_opening   timestamp,
    account_created_at     timestamp,
    account_updated_at     timestamp,
    CONSTRAINT account_pkey PRIMARY KEY (account_id),
    CONSTRAINT account_number_unique UNIQUE(account_number),
    CONSTRAINT account_client_unique UNIQUE(client_id),
    CONSTRAINT account_fk_client_id FOREIGN KEY (client_id)
        REFERENCES client (client_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
-----------------------------------------------------------------------------

-- Products

CREATE TABLE IF NOT EXISTS product(
    product_id uuid     NOT NULL,
    product_description varchar(255) NOT NULL,
    product_active      boolean default true,
    product_created_at  timestamp,
    product_updated_at  timestamp,
    CONSTRAINT product_pkey PRIMARY KEY (product_id)
);

-- Account Products

CREATE TABLE IF NOT EXISTS accountproduct(
    accountproduct_id uuid    NOT NULL,
    account_id uuid           NOT NULL,
    product_id uuid           NOT NULL,
    accountproduct_active     boolean default true,
    accountproduct_created_at timestamp,
    accountproduct_updated_at timestamp,
    CONSTRAINT accountproduct_pkey PRIMARY KEY (accountproduct_id),
    CONSTRAINT accountproduct_fk_account_id FOREIGN KEY (account_id)
        REFERENCES account (account_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT accountproduct_fk_product_id FOREIGN KEY (product_id)
        REFERENCES product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID      
);

-- Bank Transaction

CREATE TABLE IF NOT EXISTS banktransaction(
    banktransaction_id         uuid NOT NULL,
    account_id                 uuid NOT NULL,
    banktransaction_value      double precision NOT NULL,
    banktransaction_type       varchar(1),
    banktransaction_created_at timestamp,
    banktransaction_updated_at timestamp,
    CONSTRAINT banktransaction_pkey PRIMARY KEY (banktransaction_id),
    CONSTRAINT banktransaction_fk_account_id FOREIGN KEY (account_id)
        REFERENCES account (account_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID   
);

-------------------------------------------------------------------------- 
-- /// Sequence 
create table color(
    id int not null, 
    name varchar(30),
    CONSTRAINT color_pkey PRIMARY KEY (id)
);

create sequence color_id_seq;

alter table color alter column id set default nextval('color_id_seq');

insert into color(name)
values('blue');

insert into color(name)
values('red')

drop sequence color_id_seq cascade;

create sequence color_id_seq2;

drop sequence color_id_seq2;