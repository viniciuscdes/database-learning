
-- // Data insert 

-- clients 
insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Darth Vader','vader29@disney.co' ,'975.254.242-50', true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Princess Leia','galaxy_princess@disney.co' ,'214.412.564-43',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Yoda Master','yoda_master@jedi.co' ,'168.735.258-93',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'Sand Stormtrooper','sandtrooper@china.co' ,'325.982.523-00',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'C3PO','c3po@robots.co' ,'058.367.102-98',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'R2D2','r2d2@robots.co' ,'059.567.103-99',true, now(), now());

insert into client (client_id, client_name, client_email, client_cpf, client_active, client_created_at, client_updated_at)
values(gen_random_uuid(), 'CHEWBACCA','chew@disney.co' ,'436.234.167-44',true, now(), now());

SELECT * FROM client

-- account 
insert into account (account_id, client_id, account_active, account_agency_number, account_number, account_balance,account_date_opening, account_created_at, account_updated_at)
values(gen_random_uuid(),'312c2cfd-589e-4c5b-a8e0-333abfff3336', true, '0001', '10000', 0, '01/01/2022', '01/01/2022', '01/01/2022');

insert into account (account_id, client_id, account_active, account_agency_number,account_number, account_balance, account_date_opening, account_created_at, account_updated_at)
values(gen_random_uuid(), '133f1ec5-385a-4253-b7d6-5006e9c70284', true, '0001', '20000', 0, '01/01/2022', '01/01/2022', '01/01/2022');

insert into account (account_id, client_id, account_active, account_agency_number, account_number, account_balance, account_date_opening, account_created_at, account_updated_at)
values(gen_random_uuid(), '28c1b69a-791a-42de-90c7-d7da89addcd5' , true, '0001', '30000', 0, '01/01/2022', '01/01/2022', '01/01/2022');

insert into account (account_id, client_id, account_active, account_agency_number, account_number, account_balance, account_date_opening, account_created_at, account_updated_at)
values(gen_random_uuid(), '7c37610f-f7a6-46a7-a71b-584a67546dfa' , true, '0001', '40000', 0, '01/01/2022', '01/01/2022', '01/01/2022');





    SELECT cl.client_id, cl.client_name, ac.account_id
      FROM client cl
RIGHT JOIN account ac ON cl.client_id = ac.client_id

    SELECT cl.client_id, cl.client_name, ac.account_id
      FROM client cl
LEFT JOIN account ac ON cl.client_id = ac.client_id

SELECT cl.client_id, cl.client_name, ac.account_id
  FROM client cl, account ac
 WHERE cl.client_id = ac.client_id;



--product 

insert into product (product_id, product_description, product_active,product_created_at, product_updated_at )
values(gen_random_uuid(), 'CREDIT CARD',  true, '01/01/2022', '01/01/2022');

insert into product (product_id, product_description, product_active, product_created_at, product_updated_at )
values(gen_random_uuid(), 'POINTS PROGRAM',  true, '01/01/2022', '01/01/2022');

insert into product (product_id, product_description, product_active, product_created_at, product_updated_at )
values(gen_random_uuid(), 'LIFE INSURANCE',  true, '01/01/2022', '01/01/2022');

insert into product (product_id, product_description, product_active, product_created_at, product_updated_at )
values(gen_random_uuid(), 'STOCK OPTIONS',  true, '01/01/2022', '01/01/2022');

insert into product (product_id, product_description, product_active, product_created_at, product_updated_at )
values(gen_random_uuid(), 'BITCOIN',  true, '01/01/2022', '01/01/2022');

-- accountproduct

insert into accountproduct (accountproduct_id,account_id, product_id, accountproduct_created_at, accountproduct_updated_at )
values(gen_random_uuid(),'7563428d-1c43-4038-9067-c24cba354511' , '93654e71-0682-4af2-a80a-e3115004eb8c' ,'01/01/2022', '01/01/2022');

insert into accountproduct (accountproduct_id,account_id, product_id, accountproduct_created_at, accountproduct_updated_at )
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb' ,'93654e71-0682-4af2-a80a-e3115004eb8c' ,'01/01/2022', '01/01/2022');

insert into accountproduct (accountproduct_id,account_id, product_id, accountproduct_created_at, accountproduct_updated_at )
values(gen_random_uuid(),'7563428d-1c43-4038-9067-c24cba354511' , 'cc60d7b2-50d3-4fc8-bf6c-a1cccb2f5491','01/01/2022', '01/01/2022');

insert into accountproduct (accountproduct_id,account_id, product_id, accountproduct_created_at, accountproduct_updated_at )
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb' , '93654e71-0682-4af2-a80a-e3115004eb8c','01/01/2022', '01/01/2022');


  SELECT cl.client_id, cl.client_name, ac.account_id, apt.accountproduct_id, apt.product_id , pt.product_description
      FROM client cl
 LEFT JOIN account ac ON cl.client_id = ac.client_id
 LEFT JOIN accountproduct apt ON ac.account_id = apt.account_id
 LEFT JOIN product pt ON apt.product_id = pt.product_id
order by cl.client_name, ac.account_id, pt.product_description


-- banktransaction

--- VADER
insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), '7563428d-1c43-4038-9067-c24cba354511', 5000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), '7563428d-1c43-4038-9067-c24cba354511', 6000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), '7563428d-1c43-4038-9067-c24cba354511', 10000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), '7563428d-1c43-4038-9067-c24cba354511', 3000, 'D', '01/01/2022', '01/01/2022');


--- LEIA
insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb',  9000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb' , 12000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb', 300000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb', 150000, 'D', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb',  9000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb' , 12000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb', 300000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb', 150000, 'D', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb',  500, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb' , 985, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb', 34534, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb', 23454, 'D', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb',  23462, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb' , 8231, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'f580509c-8341-49ba-92f6-369f126468cb', 1236, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'f580509c-8341-49ba-92f6-369f126468cb', 7454, 'D', '01/01/2022', '11/02/2022');


--- YODA
insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'dbb50508-c53f-4748-9a5f-ea57c3aed322',  259000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'dbb50508-c53f-4748-9a5f-ea57c3aed322' , 120300, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(),'dbb50508-c53f-4748-9a5f-ea57c3aed322', 300000, 'C', '01/01/2022', '01/01/2022');

insert into banktransaction (banktransaction_id, account_id, banktransaction_value,banktransaction_type, banktransaction_created_at,banktransaction_updated_at)
values(gen_random_uuid(), 'dbb50508-c53f-4748-9a5f-ea57c3aed322', 1520000, 'D', '01/01/2022', '01/01/2022');