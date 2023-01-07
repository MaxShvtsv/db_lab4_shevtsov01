-- Знаходження кількості телефонів, покупці яких старше за заданий вік
DROP FUNCTION IF EXISTS phone_ages;

CREATE OR REPLACE FUNCTION phone_ages(given_age INT)
RETURNS INT
LANGUAGE 'plpgsql'

AS $$
   BEGIN
      RETURN (SELECT COUNT(phones.phone_id)
              FROM phones, customers
              WHERE customers.phone_id = phones.phone_id AND customers.age >= given_age);
   END;
$$;

-- SELECT phones.phone_id, phones.label, customers.cust_name, customers.age
-- FROM phones, customers
-- WHERE customers.phone_id = phones.phone_id AND customers.age > 20

-- SELECT *
-- FROM customers

SELECT phone_ages(70);