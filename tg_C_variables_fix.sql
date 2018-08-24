-- funcion del trigger de INSERT variables_fix
CREATE OR REPLACE FUNCTION audit.f_tg_C_variables_fix() RETURNS TRIGGER AS $tg_C_variables_fix$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.variables_fix
    (
			id,
			name_new,
			category_id_new,
			calc_show_new,
			sort_new,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.name,
			NEW.category_id,
			NEW.calc_show,
			NEW.sort,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_variables_fix$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - variables_fix
CREATE TRIGGER tg_C_variables_fix AFTER INSERT
ON cw.variables_fix FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_variables_fix();
