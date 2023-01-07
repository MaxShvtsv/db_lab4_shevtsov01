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
DELETE FROM phones WHERE phone_id = 6;

SELECT *
FROM phones;