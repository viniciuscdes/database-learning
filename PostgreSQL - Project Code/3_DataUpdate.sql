
---- /// Update

SELECT *
  FROM banktransaction
 WHERE account_id = 'f580509c-8341-49ba-92f6-369f126468cb';

UPDATE banktransaction SET banktransaction_value = 9749
 WHERE banktransaction_id = 'ebbd9405-3a0d-4b54-9970-bc736bf2fe26';

UPDATE banktransaction SET banktransaction_type = 'E'
 WHERE banktransaction_id = 'ebbd9405-3a0d-4b54-9970-bc736bf2fe26';
