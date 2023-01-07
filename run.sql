--- ФУНКЦІЯ ---

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

--- ПРОЦЕДУРА ---

-- Додавання нового телефону
DROP PROCEDURE IF EXISTS add_phone;
CREATE OR REPLACE PROCEDURE add_phone(phone_id_v INT, label_v VARCHAR(30), battery_power_v INT, clock_speed_v FLOAT,
									 int_memory_v INT, m_dep_v FLOAT, mobile_wt_v INT, camera_focus_v INT, blue_v BOOL,
									 dual_sim_v BOOL, four_g_v BOOL)
LANGUAGE'plpgsql'
AS $$
   BEGIN
      INSERT INTO phones(phone_id, label, battery_power, clock_speed, int_memory, m_dep,
						 mobile_wt, camera_focus, blue, dual_sim, four_g)
      VALUES(phone_id_v, label_v, battery_power_v, clock_speed_v, int_memory_v, m_dep_v,
			 mobile_wt_v, camera_focus_v, blue_v, dual_sim_v, four_g_v);
   END;
$$;


--- ТРИГЕР ---

-- Переводе назви телефонів у верхній регістр

DROP TRIGGER IF EXISTS add_upper_trig ON phones;
DROP FUNCTION IF EXISTS add_upper_func;

CREATE OR REPLACE FUNCTION add_upper_func() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS
$$
   BEGIN 
      UPDATE phones
      SET label = upper(label)
      WHERE phones.phone_id = NEW.phone_id;
      RETURN NULL;
   END;
$$;

CREATE TRIGGER add_upper_trig
AFTER INSERT ON phones
FOR EACH ROW EXECUTE FUNCTION add_upper_func();

-- INSERT INTO phones(phone_id, label, battery_power, clock_speed, int_memory, m_dep, mobile_wt, camera_focus, blue, dual_sim, four_g)
-- VALUES (6, 'Huawei', 1053, 1.5, 6, 0.2, 156, 10, TRUE, TRUE, TRUE);
-- DELETE FROM phones WHERE phone_id = 6;


-- CALL add_phone(6, 'Google', 1543, 2.8, 10, 0.4, 293, 24, TRUE, TRUE, TRUE);
-- SELECT phone_ages(10);
SELECT *
FROM phones;