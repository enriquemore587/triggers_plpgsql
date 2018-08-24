-- funcion del trigger de UPDATE variables_fix
CREATE OR REPLACE FUNCTION audit.f_tg_U_variables_fix() RETURNS TRIGGER AS $f_tg_U_variables_fix$
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
			name_old,
			category_id_old,
			calc_show_old,
			sort_old,
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
		
			OLD.name,
			OLD.category_id,
			OLD.calc_show,
			OLD.sort,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_variables_fix$ LANGUAGE 'plpgsql';

-- trigger para UPDATE variables_fix
CREATE TRIGGER tg_U_variables_fix AFTER UPDATE
ON cw.variables_fix FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_variables_fix();