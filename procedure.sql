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

CALL add_phone(6, 'Google', 1543, 2.8, 10, 0.4, 293, 24, TRUE, TRUE, TRUE);
SELECT *
FROM phones
